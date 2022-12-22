%% ValidateMPCNO
% Abstract class responsible for validation of MPCNO parameters
classdef (Abstract) ValidateMPCNO
    properties (Access = protected, Constant)
        v = Validation();  % Validation object with data validation functions
        c = Constants();  % Constant values
    end

    methods (Access = protected)
        function obj = validateMPCNOParams(obj, N, Nu, ny, nu,...
            getOutput, varargin_)
            % Runs MPCNO algorithm parameter validation

            %% Input parser settings
            p = inputParser;
            p.CaseSensitive = true(1);
            p.FunctionName = 'MPCNO';

            % Required parameters
            addRequired(p, 'N', obj.v.validScalarIntGreaterThan0Num); % TODO
            addRequired(p, 'Nu', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfOutputs',...
                obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfInputs',...
                obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'getOutput', obj.v.validFunctionHandle);


            % Optional parameters
            addParameter(p, 'lambda', obj.c.defaultLambda, obj.v.validNum);

            addParameter(p, 'ypp', obj.c.testYInitVal,...
                obj.v.validScalarDoubleNum);
            addParameter(p, 'upp', obj.c.testUInitVal,...
                obj.v.validScalarDoubleNum);

            addParameter(p, 'uMin', obj.c.defaultuMin,...
                obj.v.validScalarDoubleNum);
            addParameter(p, 'uMax', obj.c.defaultuMax,...
                obj.v.validScalarDoubleNum);

            addParameter(p, 'k', obj.c.defaultK,...
                obj.v.validScalarIntGreaterThan0Num);
            addParameter(p, 'YY', obj.c.defaultEmptyMatrix, obj.v.validNum);
            addParameter(p, 'UU', obj.c.defaultEmptyMatrix, obj.v.validNum);

            % Parsing values
            parse(p, N, Nu, ny, nu, getOutput, varargin_{:});

            % Assign required parameters
            obj.N = p.Results.N;
            obj.Nu = p.Results.Nu;
            obj.ny = p.Results.numberOfOutputs;
            obj.nu = p.Results.numberOfInputs;
            obj.getOutput = p.Results.getOutput;

            % Assign optional parameters
            obj.lambda = obj.v.validateArray('lambda', p.Results.lambda,...
                obj.nu);
            obj.ypp = p.Results.ypp;
            obj.upp = p.Results.upp;
            obj.uMin = p.Results.uMin;
            obj.uMax = p.Results.uMax;
            obj.k = p.Results.k;
            % Y(k) is calculated in loop based on given Y(k-1) value, so values
            % Y(k-2),Y(k-3)... need to be already initialised
            obj.YY = obj.v.validateInitialisationMatrix(p.Results.YY, 'YY',...
                obj.k - 2, obj.ny);
            obj.UU = obj.v.validateInitialisationMatrix(p.Results.UU, 'UU',...
                obj.k - 2, obj.nu);
        end
    end
end
