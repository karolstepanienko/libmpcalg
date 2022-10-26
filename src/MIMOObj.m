%% MIMOObj
% Class delivering MIMO object functionalities
classdef MIMOObj
    properties (Access = public)
        %% Continuous-time
        cA % Continuous-time relation between internal process variables
        cB % Continuous-time relation between internal process variables and inputs
        cC % Continuous-time relation between outputs and internal process variables
        cD % Continuous-time relation between outputs and inputs
        Gs % Continuous transmittance

        %% Discrete-time
        st % Sampling time
        dA % Discrete-time relation between internal process variables
        dB % Discrete-time relation between internal process variables and inputs
        dC % Discrete-time relation between outputs and internal process variables
        dD % Discrete-time relation between outputs and inputs
        Gz % Discrete transmittance
        A  % A matrix describing relation between current output value and past
           % output values
        B  % B matrix describing relation between current control value and past
           % control values

        %% Model parameters
        ny % Number of outputs
        nu % Number of inputs
        nx % Number of state variables
        InputDelay
    end

    properties (Access = private)
        u % Utilities object
        c % Constants object
        numDen % Numerators and denominators
    end

    methods
        %% MIMOObj
        % Creates MIMO object model using continuous transmittance
        function obj = MIMOObj(Gs, st)
            obj.c = Constants();
            obj.u = Utilities();
            obj.Gs = Gs;
            obj.st = st;

            % Matlab only methods
            obj.checkMatlab();

            [obj.cA, obj.cB, obj.cC, obj.cD] = ssdata(ss(obj.Gs));
            obj = obj.getDiscreteTransmittance();
            [obj.dA, obj.dB, obj.dC, obj.dD] = ssdata(ss(obj.Gz));
            obj = obj.getNumDen();

            % A and B matrix -- need numDen
            obj = obj.getA();
            obj = obj.getB();
        end

        %% Getters
        function ny = get.ny(obj)
            ny = size(obj.cC, 1);
        end

        function nu = get.nu(obj)
            nu = max([size(obj.cB, 2), size(obj.cD, 2)]);
        end

        function nx = get.nx(obj)
            nx = size(obj.dA, 1);
        end

        function InputDelay = get.InputDelay(obj)
            InputDelay = obj.Gs.InputDelay;
        end

        % Others
        function numDen = getnumDen(obj)
            numDen = obj.numDen;
        end

        function save(obj, fileName)
            % Saves object data
            filePath = obj.u.getObjBinFilePath(fileName);
            obj.u.cdf(filePath);
            % Prepare variables for saving
            ny = obj.ny;
            nu = obj.nu;
            nx = obj.nx;
            InputDelay = obj.InputDelay;
            numDen = obj.numDen;
            % Continuous-time state-space model
            cA = obj.cA;
            cB = obj.cB;
            cC = obj.cC;
            cD = obj.cD;
            % Discrete-time state-space model
            st = obj.st;
            dA = obj.dA;
            dB = obj.dB;
            dC = obj.dC;
            dD = obj.dD;
            % Difference equation
            A = obj.A;
            B = obj.B;
            save(filePath, 'ny', 'nu', 'nx', 'InputDelay', 'numDen', 'st',...
                'A', 'B', 'cA', 'cB', 'cC', 'cD', 'dA', 'dB', 'dC', 'dD');
        end
    end

    methods (Access = private)
        function checkMatlab(obj)
            % This code has to be executed in MATLAB.
            % Stops execution if run in OCTAVE.
            if obj.u.isOctave() ~= 0
                disp("Cannot create model in octave.");
                disp("Required function c2d is not implemented.");
                exit;
            end
        end
        
        function savePath = getSavePath(obj, fileName)
            % Returns object data full save path with file name
            absLibPath = obj.u.getAbsPathToLib();
            relativePath = obj.c.objBinPath;
            savePath = join([absLibPath, relativePath, fileName], filesep);
            savePath = savePath{1,1}; % Extract string from cell
        end
        
        function obj = getDiscreteTransmittance(obj)
            % Returns object's discrete transmittance
            obj.Gz = c2d(obj.Gs, obj.st);
        end

        function obj = getNumDen(obj)
            % Returns numerators and denumerators cell for every transmittance 
            % for every combination of output and input
            % numDen{current y, current u}{1 for nominator / 2 for denominator}
            obj.numDen = cell(obj.ny, obj.nu);
            for i=1:obj.ny
                for j=1:obj.nu
                    num = obj.Gz(i,j).Num{1}(1:end);
                    % value in front of y(k) is always 1
                    % therefore it is not needed
                    den = obj.Gz(i,j).Den{1}(1:end); 
                    obj.numDen{i, j} = {num; den};
                end
            end
        end

        function obj = getA(obj)
            % Calculates normalised A matrix vectors
            commonDen = obj.getCommonDen();

            obj.A = cell(obj.ny, obj.ny);
            for cy=1:obj.ny
                obj.A{cy, cy} = commonDen{cy};
            end

            % Fill other with vectors of zeros
            bufferLength = length(commonDen{1});
            for cy=1:obj.ny
                for cy2=1:obj.ny
                    if cy ~= cy2
                        obj.A{cy, cy2} = zeros(1, bufferLength);
                    end
                end
            end
        end

        function obj = getB(obj)
            % Calculates normalised B matrix vectors
            obj.B = obj.getUCoeffs();
        end

        function uCoeffs = getUCoeffs(obj)
            % Runs multiplication of control coefficients by other denominator
            % vectors
            uCoeffs = cell(obj.ny, obj.nu);
            if obj.ny > 1 || obj.nu > 1
                for cy=1:obj.ny
                    for cu=1:obj.nu
                        uCoeffs{cy, cu} = obj.getUCoeffsVector(...
                            obj.numDen{cy, cu}{obj.c.numIdx},...
                            obj.getOtherDenominators(cy, cu));
                    end
                end
            else
                uCoeffs{1, 1} = obj.numDen{1, 1}{obj.c.numIdx};
            end
        end

        function uCoeffsVector = getUCoeffsVector(obj, uCoeffsVector, otherDenominators)
            % Runs polynomial multiplication of current control coefficients
            % vector and other denominators for the purpose of achieving a
            % common denominator
            uCoeffsVector = uCoeffsVector;
            for i=1:length(otherDenominators)
                uCoeffsVector = conv(uCoeffsVector, otherDenominators{i});
            end
        end

        function otherDenominators = getOtherDenominators(obj, cy, cu)
            % Returns other denominators except for the one for current
            % combination of input and output
            otherDenominators = 0;
            for ccu=1:obj.nu
                if ccu ~= cu
                    if otherDenominators == 0
                        otherDenominators = {obj.numDen{cy, ccu}{obj.c.denIdx}};
                    else
                        otherDenominators = {otherDenominators; obj.numDen{cy, ccu}{obj.c.denIdx}};
                    end
                end
            end
        end

        function commonDen = getCommonDen(obj)
            % Returns common denominator for every output equation
            commonDen = cell(obj.ny, 1);
            for cy=1:obj.ny
                commonDen{cy} = obj.numDen{cy, 1}{obj.c.denIdx};
                for cu=1:obj.nu-1
                    commonDen{cy} = conv(commonDen{cy}, obj.numDen{cy, cu+1}{obj.c.denIdx});
                end
            end
        end
    end
end
