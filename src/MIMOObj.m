%% MIMOObj
% Class delivering MIMO object functionalities
classdef MIMOObj
    properties (Access = public)
        A; % Relation between internal process variables
        B; % Relation between internal process variables and inputs
        C; % Relation between outputs and internal process variables
        D; % Relation between outputs and inputs
        st; % Sampling time
        ny; % Number of outputs
        nu; % Number of inputs
        stepResponses; % Collection of all step responses
    end
    
    properties (Access = private)
        u; % Utilities object
        Gz; % Discrete transmittance
        numDen; % Numerators and denominators
    end
    
    methods
        %% MIMOObj
        % Creates MIMO object model using differential equations
        function obj = MIMOObj(A, B, C, D, st)
            obj.A = A;
            obj.B = B;
            obj.C = C;
            obj.D = D;
            obj.st = st;
            obj.u = Utilities();
            obj = getModel(obj);
            obj.stepResponses = obj.getStepResponses();
        end
    
        %% Getters
        function ny = get.ny(obj)
            ny = size(obj.C, 1);
        end
        function nu = get.nu(obj)
            nu = max([size(obj.B, 2), size(obj.D, 2)]);
        end
        
        %% getStepResponses
        function stepResponses = getStepResponses(obj)
            stepResponses = cell(obj.nu, 1);
            for i=1:obj.nu % for every input
                stepResponses{i, 1} = obj.getStepResponse(i);
            end
        end
    end
    
    methods (Access = private)
        %% getStepResponse
        % Returns output response for a step on a given input
        function YY = getStepResponse(obj, choosenU)
            [obj.ny, obj.nu] = size(obj.numDen);
            %% Variable initialisation
            kk = 100;
            YY = zeros(kk, obj.ny);
            UU = zeros(kk, obj.nu);

            %% Add control step
            % Step starts at k = 1 (matlab indexing),
            % so step response will start at k = 2
            UU(:, choosenU) = ones(kk, 1);

            % Numerator length, DenominatorLen = NumeratorLen - 1
            numLen = length(obj.numDen{1, 1}{1,1});

            %% Define k ranges required by object
            ukmin = 0;
            ukmax = numLen - 1;
            ykmin = 1;
            ykmax = ukmax;

            for k=1:kk
                [uCell, yCell] = obj.getObjectData(UU, YY, k, ukmin,...
                                                    ukmax, ykmin, ykmax);
                y = obj.getOutput(uCell, yCell, obj.numDen);
                for i=1:obj.ny
                    YY(k, i) = y(i);
                end
            end
        end
        
        %% getModel
        % Returns an object with model info when run in MATLAB.
        % Loads object model data from file when run in OCTAVE.
        function obj = getModel(obj)
            if obj.u.isOctave() ~= 0
               if isfile('./model.mat') % Try opening saved model
                    load('./model.mat', 'numDen');
                    obj.Gz = tf(1, 1, 1);
                    obj.numDen = numDen;
               else
                    disp("Cannot create model in octave.");
                    disp("Required function c2d is not implemented.");
                    exit;
               end
            else % If running in MATLAB
                obj.Gz = getGz(obj);
                obj.numDen = getNumDen(obj);
                numDen = obj.numDen;
                save('model.mat', 'numDen');
            end
        end
        
        %% getGz
        % Returns discrete transmittance
        % Due to lack of implementation in octave of c2d method, this can
        % be run only in MATLAB
        function Gz = getGz(obj)
            I = eye(size(obj.C, 1));
            syms s; % Create symbolic variable
            symEq = obj.C*((s*I - obj.A)^-1)*obj.B + obj.D;
            Gs = sym2tf(symEq);
            Gz = c2d(Gs, obj.st);
        end
        
        %% getNumDen
        % Returns numerators and denumerators cell for every transmittance 
        % for every combination of output and input
        % numDen{current y, current u}{1 for nominator / 2 for denominator}
        function numDen = getNumDen(obj)
            numDen = cell(obj.ny, obj.nu);
            for i=1:obj.ny
                for j=1:obj.nu
                    num = obj.Gz(i,j).Num{1}(1:end);
                    % value in front of y(k) is always 1
                    % therefore it is not needed
                    den = obj.Gz(i,j).Den{1}(2:end); 
                    numDen{i, j} = {num; den};
                end
            end
        end
        
        %% getobjectdata
        % Returns values of inputs and outputs used in differential
        % equations
        function [uCell, yCell] = getObjectData(obj, UU, YY, k, ukmin,...
                                                ukmax, ykmin, ykmax)
            % Determines how many u values the object requires
            nuk = ukmax - ukmin + 1;
            % Determines how many y values the object requires
            nyk = ykmax - ykmin + 1; 

            %% Variable allocation and initialisation
            obj.ny = size(YY, 2);
            obj.nu = size(UU, 2);
            upp = 0;
            ypp = 0;

            yCell = cell(obj.ny, 1);
            uCell = cell(obj.nu, 1);

            %% Initialise vectors of zeros
            for i=1:obj.ny
                yCell{i, 1} = zeros(nyk, 1);
            end
            for i=1:obj.nu
                uCell{i, 1} = zeros(nuk, 1);
            end

            %% Assign past or current control values based on current k
            for i=1:obj.nu
                for ck = ukmin:ukmax
                    if k <= ck
                        uCell{i}(ck+1) = upp;
                    else
                        uCell{i}(ck+1) = UU(k-ck, i);
                    end
                end
            end

            %% Assign past output values
            for i=1:obj.ny
                for ck=ykmin:ykmax
                    if k <= ck
                        yCell{i}(ck) = ypp;
                    else
                        yCell{i}(ck) = YY(k-ck, i);
                    end
                end
            end
        end

        %% getOutput
        % Calculate output of a MIMO object
        % @param    numDen    numerators and denominators for every 
        %                     transmittance (every combination of input
        %                     and output)
        % @return   y         vector of output values
        function y = getOutput(obj, uCell, yCell, numDen)
            y = zeros(obj.ny, 1); % output values

            for i=1:obj.ny % for every output
                for j=1:obj.nu % for every input
                    num = numDen{i,j}{1};
                    den = numDen{i,j}{2};
                    % Numerator changes in every input and output
                    % combination
                    y(i,1) = y(i,1) + num*uCell{j, 1};
                end
                % Denominator is the same across one output
                y(i, 1) = y(i,1) - den*yCell{i, 1};
            end    
        end
    end
end