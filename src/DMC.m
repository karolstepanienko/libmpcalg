%% DMC
% Analytical DMC also called classicDMC
classdef DMC < MPC
    properties

    end

    methods
        function obj = DMC(D, N, Nu, ny, nu, stepResponses, varargin)
            % Arguments:
            % D, N, Nu, stepResponses, ny, nu, mi, lambda, uMin, uMax, duMin,
            % duMax
            
            %% Parameter validation
            p = inputParser;
            p.CaseSensitive = true(1);
            p.FunctionName = 'DMC';

            % Requred parameters
            addRequired(p, 'D', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'N', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'Nu', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'stepResponses', obj.v.validCell);
            addRequired(p, 'numberOfOutputs', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfInputs', obj.v.validScalarIntGreaterThan0Num);

            % Optional parameter values
            defaultMi = 1;
            defaultLambda = 1;
            defaultuMin = -Inf;
            defaultuMax = Inf;
            defaultduMin = -Inf;
            defaultduMax = Inf;

            % Optional parameters
            addParameter(p, 'mi', defaultMi, obj.v.validNum);
            addParameter(p, 'lambda', defaultLambda, obj.v.validNum);
            addParameter(p, 'uMin', defaultuMin, obj.v.validScalarDoubleNum);
            addParameter(p, 'uMax', defaultuMax, obj.v.validScalarDoubleNum);
            addParameter(p, 'duMin', defaultduMin,...
                obj.v.validScalarDoubleLessThan0Num);
            addParameter(p, 'duMax', defaultduMax,...
                obj.v.validScalarDoubleGreaterThan0Num);

            % Parsing values
            parse(p, D, N, Nu, stepResponses, ny, nu, varargin{:});            
            
            % Assign required parameters
            obj.D = p.Results.D;
            obj.N = p.Results.N;
            obj.Nu = p.Results.Nu;
            obj.ny = p.Results.numberOfOutputs;
            obj.nu = p.Results.numberOfInputs;
            obj.stepResponses = obj.v.validateStepResponses(...
                p.Results.stepResponses, obj.ny, obj.nu, obj.D);

            % Assign optional parameters
            obj.mi = obj.v.validateArray('mi', p.Results.mi, obj.ny);
            obj.lambda = obj.v.validateArray('lambda', p.Results.lambda, obj.nu);
            obj.uMin = p.Results.uMin;
            obj.uMax = p.Results.uMax;
            obj.duMin = p.Results.duMin;
            obj.duMax = p.Results.duMax;

            obj = obj.initDMC();
            obj = obj.initMPC();
        end

        %% calculateControl
        % Calculates new, current object control values
        % Should be run in a loop
        % @param Y_k        horizontal vector of current output values
        % @param Yzad_k     horizontal vector of target trajectory values
        function obj = calculateControl(obj, Y_k, Yzad_k)
            YY_k = obj.getYY_k(Y_k');
            YYzad_k = obj.getYYzad_k(Yzad_k');
            
            % Get YY_0
            YY_0 = YY_k + obj.Mp * obj.dUUp_k;
            
            % Get new control change value
            obj.dUU_k = obj.K * (YYzad_k - YY_0);
            
            % Limit control change values
            dU_k = obj.limitdU_k(obj.dUU_k(1:obj.nu));
            
            % Shift dUUp values
            obj.dUUp_k = [dU_k;...
                obj.dUUp_k(1:(length(obj.dUUp_k)-obj.nu), 1)];

            % Get new control value
            % Here U_k = U_k_1 and is updated
            obj.U_k = obj.limitU_k(obj.U_k + obj.dUU_k(1:obj.nu, 1));
        end
        
        %% getControl
        % Returns horizontal vector of new control values
        function U_k = getControl(obj)
            U_k = obj.U_k';
        end
    end

    methods (Access = private)
        %% initDMC
        % Prepares neccessary vectors used by DMC algorithms
        function obj = initDMC(obj)
            obj.dUU_k = obj.initdUU_k();
            obj.dUUp_k = obj.initdUUp_k();
            obj.U_k = obj.initU_k();
        end

        %% getYYzad_k
        function YYzad_k = getYYzad_k(obj, Yzad_k)
            % Check if vector has improper number of elements
            if size(Yzad_k, 1) ~= obj.ny || size(Yzad_k, 2) ~= 1
                ME = getImproperVectorSizeException(Yzad_k);
                throw(ME);
            else
                YYzad_k = Utilities.stackVector(Yzad_k, obj.N);
            end
        end
        
        %% getYY_k
        function YY_k = getYY_k(obj, Y_k)
            % Check if vector has improper number of elements
            if size(Y_k, 1) ~= obj.ny || size(Y_k, 2) ~= 1
                ME = getImproperVectorSizeException(Y_k);
                throw(ME);
            else
                YY_k = Utilities.stackVector(Y_k, obj.N);
            end
        end
        
        %% initdUUp
        function dUUp_k = initdUUp_k(obj)
            dUUp_k = zeros(obj.nu*(obj.D - 1), 1);
        end
        
        %% initdUU
        function dUU_k = initdUU_k(obj)
            dUU_k = zeros(obj.nu*obj.Nu, 1);
        end
        
        %% getUU_k
        function U_k = initU_k(obj)
            U_k = zeros(obj.nu, 1);
        end
        
        %% limitU_k
        function U_k = limitU_k(obj, U_k)
            for i=1:obj.nu
                if U_k(i, 1) < obj.uMin
                    U_k(i, 1) = obj.uMin;
                elseif U_k(i, 1) > obj.uMax
                    U_k(i, 1) = obj.uMax;
                end
            end
        end

        %% limitdU_k
        function dU_k = limitdU_k(obj, dU_k)
            for i=1:obj.nu
                if dU_k(i, 1) < obj.duMin
                    dU_k(i, 1) = obj.duMin;
                elseif dU_k(i, 1) > obj.duMax
                    dU_k(i, 1) = obj.duMax;
                end
            end
        end
    end
end


%% getImproperVectorSizeException
function ME = getImproperVectorSizeException(V)
    ME = MException('MyComponent:improperVectorSize',...
    'Vector %s has improper size.', mat2str(V));
end
