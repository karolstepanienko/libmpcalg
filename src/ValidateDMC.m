%% ValidateDMC
% Abstract class responsible for validation of DMC parameters
classdef (Abstract) ValidateDMC
    methods (Static)
        function obj = validateDMCParams(obj, D, N, Nu, ny, nu,...
            stepResponses, varargin_)
            % Runs Analytical and Fast DMC algorithm parameter validation
            v = Validation();

            %% Input parser settings
            p = inputParser;
            p.CaseSensitive = true(1);
            p.FunctionName = 'DMC';

            % Required parameters
            addRequired(p, 'D', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'N', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'Nu', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'stepResponses', v.validCell);
            addRequired(p, 'numberOfOutputs',...
                v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfInputs',...
                v.validScalarIntGreaterThan0Num);

            % Optional parameters
            addParameter(p, 'mi', v.c.defaultMi, v.validNum);
            addParameter(p, 'lambda', v.c.defaultLambda, v.validNum);

            addParameter(p, 'uMin', v.c.defaultuMin,...
                v.validScalarDoubleNum);

            addParameter(p, 'uMax', v.c.defaultuMax,...
                v.validScalarDoubleNum);

            addParameter(p, 'duMin', v.c.defaultduMin,...
                v.validScalarDoubleLessThan0Num);

            addParameter(p, 'duMax', v.c.defaultduMax,...
                v.validScalarDoubleGreaterThan0Num);

            addParameter(p, 'algType', v.c.analyticalAlgType,...
                v.validAlgType);

            % Parsing values
            parse(p, D, N, Nu, stepResponses, ny, nu, varargin_{:});

            % Assign required parameters
            obj.D = p.Results.D;
            obj.N = p.Results.N;
            obj.Nu = p.Results.Nu;
            obj.ny = p.Results.numberOfOutputs;
            obj.nu = p.Results.numberOfInputs;
            obj.stepResponses = v.validateStepResponses(...
                p.Results.stepResponses, obj.ny, obj.nu, obj.D);

            % Assign optional parameters
            obj.mi = v.validateArray('mi', p.Results.mi, obj.ny);
            obj.lambda = v.validateArray('lambda', p.Results.lambda, obj.nu);
            obj.uMin = p.Results.uMin;
            obj.uMax = p.Results.uMax;
            obj.duMin = p.Results.duMin;
            obj.duMax = p.Results.duMax;
            % algType is not saved as a class property
        end

        function obj = validateNumericalDMCParams(obj, D, N, Nu, ny, nu,...
            stepResponses, varargin_)
            % Runs Numerical DMC algorithm parameter validation
            v = Validation();

            %% Input parser settings
            p = inputParser;
            p.CaseSensitive = true(1);
            p.FunctionName = 'DMC';

            % Required parameters
            addRequired(p, 'D', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'N', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'Nu', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'stepResponses', v.validCell);
            addRequired(p, 'numberOfOutputs',...
                v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfInputs',...
                v.validScalarIntGreaterThan0Num);

            % Optional parameters
            addParameter(p, 'mi', v.c.defaultMi, v.validNum);
            addParameter(p, 'lambda', v.c.defaultLambda, v.validNum);

            addParameter(p, 'uMin', v.c.defaultuMin,...
                v.validScalarDoubleNum);

            addParameter(p, 'uMax', v.c.defaultuMax,...
                v.validScalarDoubleNum);

            addParameter(p, 'duMin', v.c.defaultduMin,...
                v.validScalarDoubleLessThan0Num);

            addParameter(p, 'duMax', v.c.defaultduMax,...
                v.validScalarDoubleGreaterThan0Num);

            addParameter(p, 'yMin', v.c.defaultyMin,...
                v.validScalarDoubleNum);

            addParameter(p, 'yMax', v.c.defaultyMax,...
                v.validScalarDoubleNum);

            addParameter(p, 'algType', v.c.analyticalAlgType,...
                v.validAlgType);

            % Parsing values
            parse(p, D, N, Nu, stepResponses, ny, nu, varargin_{:});

            % Assign required parameters
            obj.D = p.Results.D;
            obj.N = p.Results.N;
            obj.Nu = p.Results.Nu;
            obj.ny = p.Results.numberOfOutputs;
            obj.nu = p.Results.numberOfInputs;
            obj.stepResponses = v.validateStepResponses(...
                p.Results.stepResponses, obj.ny, obj.nu, obj.D);

            % Assign optional parameters
            obj.mi = v.validateArray('mi', p.Results.mi, obj.ny);
            obj.lambda = v.validateArray('lambda', p.Results.lambda, obj.nu);
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
