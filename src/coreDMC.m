%% coreDMC
% Abstract class containing DMC specific elements
classdef (Abstract) coreDMC
    methods
        %% getControl
        % Returns horizontal vector of new control values
        function U_k = getControl(obj)
            U_k = obj.U_k';
        end
    end

    properties (Access = protected, Constant)
        v = Validation();  % Validation object that stores data validation 
                           % functions
    end

    methods (Access = protected)
        %% validateDMCParams
        % Runs DMC algorithm parameter validation
        function obj = validateDMCParams(obj, D, N, Nu, ny, nu, stepResponses, varargin_)
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
            parse(p, D, N, Nu, stepResponses, ny, nu, varargin_{:});            
            
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
        end
    end
end
