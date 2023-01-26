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
            addParameter(p, 'N1', v.c.defaultN1,...
                v.validScalarIntGreaterThan0Num);
            addParameter(p, 'mi', v.c.defaultMi, v.validNum);
            addParameter(p, 'lambda', v.c.defaultLambda, v.validNum);

            addParameter(p, 'uMin', v.c.defaultuMin, v.validNum);
            addParameter(p, 'uMax', v.c.defaultuMax, v.validNum);

            addParameter(p, 'duMin', v.c.defaultduMin, v.validNumLessThan0);
            addParameter(p, 'duMax', v.c.defaultduMax, v.validNumGreaterThan0);

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
            obj.N1 = p.Results.N1;
            obj.mi = v.validateArray('mi', p.Results.mi, obj.ny);
            obj.lambda = v.validateLambda('lambda', p.Results.lambda, obj.nu);
            obj.uMin = v.validateArray('uMin', p.Results.uMin, obj.nu);
            obj.uMax = v.validateArray('uMax', p.Results.uMax, obj.nu);
            obj.duMin = v.validateArray('duMin', p.Results.duMin, obj.nu);
            obj.duMax = v.validateArray('duMax',p.Results.duMax, obj.nu);
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
            addParameter(p, 'N1', v.c.defaultN1,...
                v.validScalarIntGreaterThan0Num);
            addParameter(p, 'mi', v.c.defaultMi, v.validNum);
            addParameter(p, 'lambda', v.c.defaultLambda, v.validNum);

            addParameter(p, 'uMin', v.c.defaultuMin, v.validNum);
            addParameter(p, 'uMax', v.c.defaultuMax, v.validNum);

            addParameter(p, 'duMin', v.c.defaultduMin, v.validNumLessThan0);
            addParameter(p, 'duMax', v.c.defaultduMax, v.validNumGreaterThan0);

            addParameter(p, 'yMin', v.c.defaultyMin, v.validNum);
            addParameter(p, 'yMax', v.c.defaultyMax, v.validNum);

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
            obj.N1 = p.Results.N1;
            obj.mi = v.validateArray('mi', p.Results.mi, obj.ny);
            obj.lambda = v.validateLambda('lambda', p.Results.lambda, obj.nu);
            obj.uMin = v.validateArray('uMin', p.Results.uMin, obj.nu);
            obj.uMax = v.validateArray('uMax', p.Results.uMax, obj.nu);
            obj.duMin = v.validateArray('duMin', p.Results.duMin, obj.nu);
            obj.duMax = v.validateArray('duMax',p.Results.duMax, obj.nu);
            obj.yMin = v.validateArray('yMin', p.Results.yMin, obj.ny);
            obj.yMax = v.validateArray('yMax', p.Results.yMax, obj.ny);
            % algType is not saved as a class property
        end
    end
end
