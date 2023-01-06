%% ValidateMPCNO
% Abstract class responsible for validation of MPCNO parameters
classdef (Abstract) ValidateMPCNO
    methods (Static)
        function obj = validateMPCNOParams(obj, N, Nu, ny, nu,...
            getOutput, varargin_)
            % Runs MPCNO algorithm parameter validation
            v = Validation();
            c = Constants();

            %% Input parser settings
            p = inputParser;
            p.CaseSensitive = true(1);
            p.FunctionName = 'MPCNO';

            % Required parameters
            addRequired(p, 'N', v.validScalarIntGreaterThan0Num); % TODO
            addRequired(p, 'Nu', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfOutputs',...
                v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfInputs',...
                v.validScalarIntGreaterThan0Num);
            addRequired(p, 'getOutput', v.validFunctionHandle);


            % Optional parameters
            addParameter(p, 'lambda', c.defaultLambda, v.validNum);

            addParameter(p, 'ypp', c.testYInitVal,...
                v.validScalarDoubleNum);
            addParameter(p, 'upp', c.testUInitVal,...
                v.validScalarDoubleNum);

            addParameter(p, 'uMin', c.defaultuMin,...
                v.validScalarDoubleNum);
            addParameter(p, 'uMax', c.defaultuMax,...
                v.validScalarDoubleNum);

            addParameter(p, 'k', c.defaultK,...
                v.validScalarIntGreaterThan0Num);
            addParameter(p, 'YY', c.defaultEmptyMatrix, v.validNum);
            addParameter(p, 'UU', c.defaultEmptyMatrix, v.validNum);

            % Parsing values
            parse(p, N, Nu, ny, nu, getOutput, varargin_{:});

            % Assign required parameters
            obj.N = p.Results.N;
            obj.Nu = p.Results.Nu;
            obj.ny = p.Results.numberOfOutputs;
            obj.nu = p.Results.numberOfInputs;
            obj.getOutput = p.Results.getOutput;

            % Assign optional parameters
            obj.lambda = v.validateArray('lambda', p.Results.lambda,...
                obj.nu);
            obj.ypp = p.Results.ypp;
            obj.upp = p.Results.upp;
            obj.uMin = p.Results.uMin;
            obj.uMax = p.Results.uMax;
            obj.k = p.Results.k;
            % Y(k) is calculated in loop based on given Y(k-1) value, so values
            % Y(k-2),Y(k-3)... need to be already initialised
            obj.YY = v.validateInitialisationMatrix(p.Results.YY, 'YY',...
                obj.k - 2, obj.ny);
            obj.UU = v.validateInitialisationMatrix(p.Results.UU, 'UU',...
                obj.k - 2, obj.nu);
        end
    end
end
