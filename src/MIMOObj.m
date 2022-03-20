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
        
        %% Model parameters
        ny % Number of outputs
        nu % Number of inputs
    end
    
    properties (Access = private)
        u % Utilities object
        c % Constants object
        cSS % Continuous-time state-space model
        dSS % Discrete-time state-space model.
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
            
            obj.cSS = ss(obj.Gs);
            obj = obj.getDiscreteTransmittance();
            obj.dSS = ss(obj.Gz);
            obj = obj.getNumDen();
        end
    
        %% Getters
        function ny = get.ny(obj)
            ny = size(obj.cC, 1);
        end
        function nu = get.nu(obj)
            nu = max([size(obj.cB, 2), size(obj.cD, 2)]);
        end
        
        % Continuous-time
        function cA = get.cA(obj)
            cA = obj.cSS.A;
        end
        function cB = get.cB(obj)
            cB = obj.cSS.B;
        end
        function cC = get.cC(obj)
            cC = obj.cSS.C;
        end
        function cD = get.cD(obj)
            cD = obj.cSS.D;
        end

        % Discrete-time
        function dA = get.dA(obj)
            dA = obj.dSS.A;
        end
        function dB = get.dB(obj)
            dB = obj.dSS.B;
        end
        function dC = get.dC(obj)
            dC = obj.dSS.C;
        end
        function dD = get.dD(obj)
            dD = obj.dSS.D;
        end
        
        % Others
        function numDen = getnumDen(obj)
            numDen = obj.numDen;
        end
        
        %% save
        % Saves object data
        function save(obj, fileName)
            filePath = obj.u.getObjBinFilePath(fileName);
            obj.u.cdf(filePath);
            % Prepare variables for saving
            % TODO add cSS and dSS matrices
            ny = obj.ny;
            nu = obj.nu;
            numDen = obj.numDen;
            st = obj.st;
            save(filePath, 'ny', 'nu', 'numDen', 'st');
        end
    end
    
    methods (Access = private)
        %% checkMatlab
        % This code has to be executed in MATLAB.
        % Stops execution if run in OCTAVE.
        function checkMatlab(obj)
            if obj.u.isOctave() ~= 0
                disp("Cannot create model in octave.");
                disp("Required function c2d is not implemented.");
                exit;
            end
        end
        
        %% getSavePath
        % Returns object data full save path with file name
        function savePath = getSavePath(obj, fileName)
            absLibPath = obj.u.getAbsPathToLib();
            relativePath = obj.c.objBinPath;
            savePath = join([absLibPath, relativePath, fileName], filesep);
            savePath = savePath{1,1}; % Extract string from cell
        end
        
        %% getDiscreteTransmittance
        % Returns object's discrete transmittance
        function obj = getDiscreteTransmittance(obj)
            obj.Gz = c2d(obj.Gs, obj.st);
        end
        
        %% getNumDen
        % Returns numerators and denumerators cell for every transmittance 
        % for every combination of output and input
        % numDen{current y, current u}{1 for nominator / 2 for denominator}
        function obj = getNumDen(obj)
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
    end
end