%% ValidateMPCS
% Abstract class responsible for validation of MPCS parameters
classdef (Abstract) ValidateMPCS
    methods (Static)
        function obj = validateMPCSParams(obj, N, Nu, ny, nu, nx, dA, dB, dC,...
            dD, varargin_)
            % Runs Analytical and Fast MPCS algorithm parameter validation
            v = Validation();

            %% Input parser settings
            p = inputParser;
            p.CaseSensitive = true(1);
            p.FunctionName = 'MPCS';

            % Required parameters
            addRequired(p, 'N', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'Nu', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfOutputs',...
                v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfInputs',...
                v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfStateVariables',...
                v.validScalarIntGreaterThan0Num);
            addRequired(p, 'dA', v.validSquareMatrix);
            addRequired(p, 'dB', v.validMatrix);
            addRequired(p, 'dC', v.validMatrix);
            addRequired(p, 'dD', v.validMatrix);

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
            parse(p, N, Nu, ny, nu, nx, dA, dB, dC, dD, varargin_{:});

            % Assign required parameters
            obj.N = p.Results.N;
            obj.Nu = p.Results.Nu;
            obj.ny = p.Results.numberOfOutputs;
            obj.nu = p.Results.numberOfInputs;
            obj.nx = p.Results.numberOfStateVariables;
            obj.dA = v.validateAStateMatrix(p.Results.dA, obj.nx);
            obj.dB = v.validateStateMatrix(p.Results.dB, 'dB', obj.nx,...
                obj.nu);
            obj.dC = v.validateStateMatrix(p.Results.dC, 'dC', obj.ny,...
                obj.nx);
            obj.dD = v.validateStateMatrix(p.Results.dD, 'dD', obj.ny,...
                obj.nu);

            % Assign optional parameters
            obj.mi = v.validateArray('mi', p.Results.mi, obj.ny);
            obj.lambda = v.validateArray('lambda', p.Results.lambda, obj.nu);
            obj.uMin = p.Results.uMin;
            obj.uMax = p.Results.uMax;
            obj.duMin = p.Results.duMin;
            obj.duMax = p.Results.duMax;
            % algType is not saved as a class property
        end

        function obj = validateNumericalMPCSParams(obj, N, Nu, ny, nu, nx, dA, dB, dC,...
            dD, varargin_)
            % Runs Numerical MPCS algorithm parameter validation
            v = Validation();

            %% Input parser settings
            p = inputParser;
            p.CaseSensitive = true(1);
            p.FunctionName = 'MPCS';

            % Required parameters
            addRequired(p, 'N', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'Nu', v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfOutputs',...
                v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfInputs',...
                v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfStateVariables',...
                v.validScalarIntGreaterThan0Num);
            addRequired(p, 'dA', v.validSquareMatrix);
            addRequired(p, 'dB', v.validMatrix);
            addRequired(p, 'dC', v.validMatrix);
            addRequired(p, 'dD', v.validMatrix);

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
            parse(p, N, Nu, ny, nu, nx, dA, dB, dC, dD, varargin_{:});

            % Assign required parameters
            obj.N = p.Results.N;
            obj.Nu = p.Results.Nu;
            obj.ny = p.Results.numberOfOutputs;
            obj.nu = p.Results.numberOfInputs;
            obj.nx = p.Results.numberOfStateVariables;
            obj.dA = v.validateAStateMatrix(p.Results.dA, obj.nx);
            obj.dB = v.validateStateMatrix(p.Results.dB, 'dB', obj.nx,...
                obj.nu);
            obj.dC = v.validateStateMatrix(p.Results.dC, 'dC', obj.ny,...
                obj.nx);
            obj.dD = v.validateStateMatrix(p.Results.dD, 'dD', obj.ny,...
                obj.nu);

            % Assign optional parameters
            obj.mi = v.validateArray('mi', p.Results.mi, obj.ny);
            obj.lambda = v.validateArray('lambda', p.Results.lambda,...
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
