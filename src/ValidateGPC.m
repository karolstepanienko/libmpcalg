%% ValidateGPC
% Abstract class responsible for validation of GPC parameters
classdef (Abstract) ValidateGPC
    properties (Access = protected, Constant)
        v = Validation();  % Validation object with data validation functions
        c = Constants();  % Constant values
    end

    methods (Access = protected)
        function obj = validateGPCParams(obj, N, Nu, ny, nu, A, B, varargin_)
            % Runs Analytical and Fast GPC algorithm parameter validation

            %% Input parser settings
            p = inputParser;
            p.CaseSensitive = true(1);
            p.FunctionName = 'GPC';

            % Required parameters
            addRequired(p, 'N', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'Nu', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfOutputs',...
                obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfInputs',...
                obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'A', obj.v.validCell)
            addRequired(p, 'B', obj.v.validCell)

            % Optional parameters
            addParameter(p, 'InputDelay', obj.c.defaultInputDelay,...
                obj.v.validNum);
            addParameter(p, 'mi', obj.c.defaultMi, obj.v.validNum);
            addParameter(p, 'lambda', obj.c.defaultLambda, obj.v.validNum);

            addParameter(p, 'ypp', obj.c.testYInitVal,...
                obj.v.validScalarDoubleNum);
            addParameter(p, 'upp', obj.c.testUInitVal,...
                obj.v.validScalarDoubleNum);

            addParameter(p, 'uMin', obj.c.defaultuMin,...
                obj.v.validScalarDoubleNum);
            addParameter(p, 'uMax', obj.c.defaultuMax,...
                obj.v.validScalarDoubleNum);

            addParameter(p, 'duMin', obj.c.defaultduMin,...
                obj.v.validScalarDoubleLessThan0Num);
            addParameter(p, 'duMax', obj.c.defaultduMax,...
                obj.v.validScalarDoubleGreaterThan0Num);

            addParameter(p, 'k', obj.c.defaultK,...
                obj.v.validScalarIntGreaterThan0Num);
            addParameter(p, 'YY', obj.c.defaultEmptyMatrix, obj.v.validNum);
            addParameter(p, 'UU', obj.c.defaultEmptyMatrix, obj.v.validNum);

            addParameter(p, 'algType', obj.c.analyticalAlgType,...
                obj.v.validAlgType);

            % Parsing values
            parse(p, N, Nu, ny, nu, A, B, varargin_{:});

            % Assign required parameters
            obj.N = p.Results.N;
            obj.Nu = p.Results.Nu;
            obj.ny = p.Results.numberOfOutputs;
            obj.nu = p.Results.numberOfInputs;
            obj.A = obj.v.validateA(p.Results.A, obj.ny);
            obj.B = obj.v.validateB(p.Results.B, obj.ny, obj.nu);

            % Assign optional parameters
            obj.InputDelay = obj.v.validateArraySize('InputDelay',...
                p.Results.InputDelay, obj.nu);
            obj.mi = obj.v.validateArray('mi', p.Results.mi, obj.ny);
            obj.lambda = obj.v.validateArray('lambda', p.Results.lambda,...
                obj.nu);
            obj.ypp = p.Results.ypp;
            obj.upp = p.Results.upp;
            obj.uMin = p.Results.uMin;
            obj.uMax = p.Results.uMax;
            obj.duMin = p.Results.duMin;
            obj.duMax = p.Results.duMax;
            obj.k = p.Results.k;
            % Y(k) is calculated in loop based on given Y(k-1) value, so values
            % Y(k-2),Y(k-3)... need to be already initialised
            obj.YY = obj.v.validateInitialisationMatrix(p.Results.YY, 'YY',...
                obj.k - 2, obj.ny);
            obj.UU = obj.v.validateInitialisationMatrix(p.Results.UU, 'UU',...
                obj.k - 2, obj.nu);
            % algType is not saved as a class property
        end

        function obj = validateNumericalGPCParams(obj, N, Nu, ny, nu, A, B,...
            varargin_)
            % Runs Numerical GPC algorithm parameter validation

            %% Input parser settings
            p = inputParser;
            p.CaseSensitive = true(1);
            p.FunctionName = 'GPC';

            % Required parameters
            addRequired(p, 'N', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'Nu', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfOutputs',...
                obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfInputs',...
                obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'A', obj.v.validCell)
            addRequired(p, 'B', obj.v.validCell)

            % Optional parameters
            addParameter(p, 'InputDelay', obj.c.defaultInputDelay,...
                obj.v.validNum);
            addParameter(p, 'mi', obj.c.defaultMi, obj.v.validNum);
            addParameter(p, 'lambda', obj.c.defaultLambda, obj.v.validNum);

            addParameter(p, 'ypp', obj.c.testYInitVal,...
                obj.v.validScalarDoubleNum);
            addParameter(p, 'upp', obj.c.testUInitVal,...
                obj.v.validScalarDoubleNum);

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

            addParameter(p, 'k', obj.c.defaultK,...
                obj.v.validScalarIntGreaterThan0Num);
            addParameter(p, 'YY', obj.c.defaultEmptyMatrix, obj.v.validNum);
            addParameter(p, 'UU', obj.c.defaultEmptyMatrix, obj.v.validNum);

            addParameter(p, 'algType', obj.c.analyticalAlgType,...
                obj.v.validAlgType);

            % Parsing values
            parse(p, N, Nu, ny, nu, A, B, varargin_{:});

            % Assign required parameters
            obj.N = p.Results.N;
            obj.Nu = p.Results.Nu;
            obj.ny = p.Results.numberOfOutputs;
            obj.nu = p.Results.numberOfInputs;
            obj.A = obj.v.validateA(p.Results.A, obj.ny);
            obj.B = obj.v.validateB(p.Results.B, obj.ny, obj.nu);

            % Assign optional parameters
            obj.InputDelay = obj.v.validateArraySize('InputDelay',...
                p.Results.InputDelay, obj.nu);
            obj.mi = obj.v.validateArray('mi', p.Results.mi, obj.ny);
            obj.lambda = obj.v.validateArray('lambda', p.Results.lambda,...
                obj.nu);
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
            obj.YY = obj.v.validateInitialisationMatrix(p.Results.YY, 'YY',...
                obj.k - 2, obj.ny);
            obj.UU = obj.v.validateInitialisationMatrix(p.Results.UU, 'UU',...
                obj.k - 2, obj.nu);
            % algType is not saved as a class property
        end
    end
end
