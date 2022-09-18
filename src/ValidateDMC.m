%% ValidateDMC
% Abstract class responsible for validation of DMC parameters
classdef (Abstract) ValidateDMC
    properties (Access = protected, Constant)
        v = Validation();  % Validation object with data validation functions
        c = Constants();  % Constant values
    end

    methods (Access = protected)
        function obj = validateDMCParams(obj, D, N, Nu, ny, nu,...
            stepResponses, varargin_)
            % Runs Analytical and Fast DMC algorithm parameter validation

            %% Input parser settings
            p = inputParser;
            p.CaseSensitive = true(1);
            p.FunctionName = 'DMC';

            % Required parameters
            addRequired(p, 'D', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'N', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'Nu', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'stepResponses', obj.v.validCell);
            addRequired(p, 'numberOfOutputs',...
                obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfInputs',...
                obj.v.validScalarIntGreaterThan0Num);

            % Optional parameters
            addParameter(p, 'mi', obj.c.defaultMi, obj.v.validNum);
            addParameter(p, 'lambda', obj.c.defaultLambda, obj.v.validNum);
            
            addParameter(p, 'uMin', obj.c.defaultuMin,...
                obj.v.validScalarDoubleNum);
            
            addParameter(p, 'uMax', obj.c.defaultuMax,...
                obj.v.validScalarDoubleNum);
            
            addParameter(p, 'duMin', obj.c.defaultduMin,...
                obj.v.validScalarDoubleLessThan0Num);
            
            addParameter(p, 'duMax', obj.c.defaultduMax,...
                obj.v.validScalarDoubleGreaterThan0Num);
            
            addParameter(p, 'algType', obj.c.analyticalAlgType,...
                obj.v.validAlgType);

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
            obj.lambda = obj.v.validateArray('lambda', p.Results.lambda,...
                obj.nu);
            obj.uMin = p.Results.uMin;
            obj.uMax = p.Results.uMax;
            obj.duMin = p.Results.duMin;
            obj.duMax = p.Results.duMax;
            % algType is not saved as a class property
        end

        function obj = validateNumericalDMCParams(obj, D, N, Nu, ny, nu,...
            stepResponses, varargin_)
            % Runs Numerical DMC algorithm parameter validation

            %% Input parser settings
            p = inputParser;
            p.CaseSensitive = true(1);
            p.FunctionName = 'DMC';

            % Required parameters
            addRequired(p, 'D', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'N', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'Nu', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'stepResponses', obj.v.validCell);
            addRequired(p, 'numberOfOutputs',...
                obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfInputs',...
                obj.v.validScalarIntGreaterThan0Num);

            % Optional parameters
            addParameter(p, 'mi', obj.c.defaultMi, obj.v.validNum);
            addParameter(p, 'lambda', obj.c.defaultLambda, obj.v.validNum);

            addParameter(p, 'uMin', obj.c.defaultuMin,...
                obj.v.validScalarDoubleNum);

            addParameter(p, 'uMax', obj.c.defaultuMax,...
                obj.v.validScalarDoubleNum);

            addParameter(p, 'duMin', obj.c.defaultduMin,...
                obj.v.validScalarDoubleLessThan0Num);

            addParameter(p, 'duMax', obj.c.defaultduMax,...
                obj.v.validScalarDoubleGreaterThan0Num);

            addParameter(p, 'yMin', obj.c.defaultyMin,...
                obj.v.validScalarDoubleNum);

            addParameter(p, 'yMax', obj.c.defaultyMax,...
                obj.v.validScalarDoubleNum);

            addParameter(p, 'algType', obj.c.analyticalAlgType,...
                obj.v.validAlgType);

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
            obj.lambda = obj.v.validateArray('lambda', p.Results.lambda,...
                obj.nu);
            obj.uMin = p.Results.uMin;
            obj.uMax = p.Results.uMax;
            obj.duMin = p.Results.duMin;
            obj.duMax = p.Results.duMax;
            obj.yMin = p.Results.yMin;
            obj.yMax = p.Results.yMax;
            % algType is not saved as a class property
        end
    end
end
