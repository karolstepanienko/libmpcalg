%% ValidateMPCNO
% Abstract class responsible for validation of MPCNO parameters
classdef (Abstract) ValidateMPCNO
    methods (Static)
        function obj = validateMPCNOParams(obj, N, Nu, ny, nu,...
            getOutput, varargin_)
            % Runs MPCNO algorithm parameter validation
            v = Validation();

            %% Input parser settings
            p = inputParser;
            p.CaseSensitive = true(1);
            p.FunctionName = 'MPCNO';

            % Required parameters
            addRequired(p, 'N', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'Nu', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfOutputs', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfInputs', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'getOutput', v.validFunctionHandle);

            % Optional parameters
            addParameter(p, 'lambda', v.c.defaultLambda, v.validNum);

            addParameter(p, 'ypp', v.c.testYInitVal, v.validScalarDoubleNum);
            addParameter(p, 'upp', v.c.testUInitVal, v.validScalarDoubleNum);

            addParameter(p, 'uMin', v.c.defaultuMin, v.validScalarDoubleNum);
            addParameter(p, 'uMax', v.c.defaultuMax, v.validScalarDoubleNum);

            addParameter(p, 'duMin', v.c.defaultMPCNOduMin,...
                v.validScalarDoubleLessThan0Num);
            addParameter(p, 'duMax', v.c.defaultMPCNOduMax,...
                v.validScalarDoubleGreaterThan0Num);

            addParameter(p, 'yMin', v.c.defaultMPCNOyMin,...
                v.validScalarDoubleNum);
            addParameter(p, 'yMax', v.c.defaultMPCNOyMax,...
                v.validScalarDoubleNum);

            addParameter(p, 'k', v.c.defaultK, v.validScalarIntGreaterThan1Num);
            addParameter(p, 'YY', v.c.defaultEmptyMatrix, v.validNum);
            addParameter(p, 'UU', v.c.defaultEmptyMatrix, v.validNum);

            addParameter(p, 'data', v.c.defaultEmptyMatrix, v.validStruct);

            % Parsing values
            parse(p, N, Nu, ny, nu, getOutput, varargin_{:});

            % Assign required parameters
            obj.N = p.Results.N;
            obj.Nu = p.Results.Nu;
            obj.ny = p.Results.numberOfOutputs;
            obj.nu = p.Results.numberOfInputs;
            obj.getOutput = p.Results.getOutput;

            % Assign optional parameters
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
            obj.data = p.Results.data;
        end
    end
end
