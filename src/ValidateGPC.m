%% ValidateGPC
% Abstract class responsible for validation of GPC parameters
classdef (Abstract) ValidateGPC
    methods (Static)
        function obj = validateGPCParams(obj, N, Nu, ny, nu, A, B, varargin_)
            % Runs Analytical and Fast GPC algorithm parameter validation
            v = Validation();

            %% Input parser settings
            p = inputParser;
            p.CaseSensitive = true(1);
            p.FunctionName = 'GPC';

            % Required parameters
            addRequired(p, 'N', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'Nu', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfOutputs', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfInputs', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'A', v.validCell)
            addRequired(p, 'B', v.validCell)

            % Optional parameters
            addParameter(p, 'IODelay', v.c.defaultIODelay, v.validNum);
            addParameter(p, 'mi', v.c.defaultMi, v.validNum);
            addParameter(p, 'lambda', v.c.defaultLambda, v.validNum);

            addParameter(p, 'ypp', v.c.testYInitVal, v.validScalarDoubleNum);
            addParameter(p, 'upp', v.c.testUInitVal, v.validScalarDoubleNum);

            addParameter(p, 'uMin', v.c.defaultuMin, v.validScalarDoubleNum);
            addParameter(p, 'uMax', v.c.defaultuMax, v.validScalarDoubleNum);

            addParameter(p, 'duMin', v.c.defaultduMin,...
                v.validScalarDoubleLessThan0Num);
            addParameter(p, 'duMax', v.c.defaultduMax,...
                v.validScalarDoubleGreaterThan0Num);

            addParameter(p, 'k', v.c.defaultK, v.validScalarIntGreaterThan0Num);
            addParameter(p, 'YY', v.c.defaultEmptyMatrix, v.validNum);
            addParameter(p, 'UU', v.c.defaultEmptyMatrix, v.validNum);

            addParameter(p, 'algType', v.c.analyticalAlgType, v.validAlgType);

            % Parsing values
            parse(p, N, Nu, ny, nu, A, B, varargin_{:});

            % Assign required parameters
            obj.N = p.Results.N;
            obj.Nu = p.Results.Nu;
            obj.ny = p.Results.numberOfOutputs;
            obj.nu = p.Results.numberOfInputs;
            obj.A = v.validateA(p.Results.A, obj.ny);
            obj.B = v.validateB(p.Results.B, obj.ny, obj.nu);

            % Assign optional parameters
            obj.IODelay = v.validateIODelay(p.Results.IODelay, 'IODelay',...
                obj.ny, obj.nu);
            obj.mi = v.validateArray('mi', p.Results.mi, obj.ny);
            obj.lambda = v.validateLambda('lambda', p.Results.lambda, obj.nu);
            obj.ypp = p.Results.ypp;
            obj.upp = p.Results.upp;
            obj.uMin = p.Results.uMin;
            obj.uMax = p.Results.uMax;
            obj.duMin = p.Results.duMin;
            obj.duMax = p.Results.duMax;
            obj.k = p.Results.k;
            % Y(k) is calculated in loop based on given Y(k-1) value, so values
            % Y(k-2),Y(k-3)... need to be already initialised
            obj.YY = v.validateInitialisationMatrix(p.Results.YY, 'YY',...
                obj.k - 2, obj.ny);
            obj.UU = v.validateInitialisationMatrix(p.Results.UU, 'UU',...
                obj.k - 2, obj.nu);
            % algType is not saved as a class property
        end

        function obj = validateNumericalGPCParams(obj, N, Nu, ny, nu, A, B,...
            varargin_)
            % Runs Numerical GPC algorithm parameter validation
            v = Validation();

            %% Input parser settings
            p = inputParser;
            p.CaseSensitive = true(1);
            p.FunctionName = 'GPC';

            % Required parameters
            addRequired(p, 'N', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'Nu', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfOutputs', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfInputs', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'A', v.validCell)
            addRequired(p, 'B', v.validCell)

            % Optional parameters
            addParameter(p, 'IODelay', v.c.defaultIODelay, v.validNum);
            addParameter(p, 'mi', v.c.defaultMi, v.validNum);
            addParameter(p, 'lambda', v.c.defaultLambda, v.validNum);

            addParameter(p, 'ypp', v.c.testYInitVal, v.validScalarDoubleNum);
            addParameter(p, 'upp', v.c.testUInitVal, v.validScalarDoubleNum);

            addParameter(p, 'uMin', v.c.defaultuMin, v.validScalarDoubleNum);
            addParameter(p, 'uMax', v.c.defaultuMax, v.validScalarDoubleNum);

            addParameter(p, 'duMin', v.c.defaultduMin,...
                v.validScalarDoubleLessThan0Num);
            addParameter(p, 'duMax', v.c.defaultduMax,...
                v.validScalarDoubleGreaterThan0Num);

            addParameter(p, 'yMin', v.c.defaultyMin, v.validScalarDoubleNum);
            addParameter(p, 'yMax', v.c.defaultyMax, v.validScalarDoubleNum);

            addParameter(p, 'k', v.c.defaultK, v.validScalarIntGreaterThan0Num);
            addParameter(p, 'YY', v.c.defaultEmptyMatrix, v.validNum);
            addParameter(p, 'UU', v.c.defaultEmptyMatrix, v.validNum);

            addParameter(p, 'algType', v.c.analyticalAlgType, v.validAlgType);

            % Parsing values
            parse(p, N, Nu, ny, nu, A, B, varargin_{:});

            % Assign required parameters
            obj.N = p.Results.N;
            obj.Nu = p.Results.Nu;
            obj.ny = p.Results.numberOfOutputs;
            obj.nu = p.Results.numberOfInputs;
            obj.A = v.validateA(p.Results.A, obj.ny);
            obj.B = v.validateB(p.Results.B, obj.ny, obj.nu);

            % Assign optional parameters
            obj.IODelay = v.validateIODelay(p.Results.IODelay, 'IODelay',...
                obj.ny, obj.nu);
            obj.mi = v.validateArray('mi', p.Results.mi, obj.ny);
            obj.lambda = v.validateLambda('lambda', p.Results.lambda, obj.nu);
            obj.ypp = p.Results.ypp;
            obj.upp = p.Results.upp;
            obj.uMin = p.Results.uMin;
            obj.uMax = p.Results.uMax;
            obj.duMin = p.Results.duMin;
            obj.duMax = p.Results.duMax;
            obj.yMin = p.Results.yMin;
            obj.yMax = p.Results.yMax;
            obj.k = p.Results.k;
            % Y(k) is calculated in loop based on given Y(k-1) value, so values
            % Y(k-2),Y(k-3)... need to be already initialised
            obj.YY = v.validateInitialisationMatrix(p.Results.YY, 'YY',...
                obj.k - 2, obj.ny);
            obj.UU = v.validateInitialisationMatrix(p.Results.UU, 'UU',...
                obj.k - 2, obj.nu);
            % algType is not saved as a class property
        end
    end
end
