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
            addParameter(p, 'nz', v.c.defaultnz,...
                v.validScalarIntGreaterThan0Num);
            addParameter(p, 'nxz', v.c.defaultnz,...
                v.validScalarIntGreaterThan0Num);
            addParameter(p, 'dAz', v.c.defaultEmptyMatrix, v.validSquareMatrix);
            addParameter(p, 'dBz', v.c.defaultEmptyMatrix, v.validMatrix);
            addParameter(p, 'dCz', v.c.defaultEmptyMatrix, v.validMatrix);
            addParameter(p, 'dDz', v.c.defaultEmptyMatrix, v.validMatrix);

            addParameter(p, 'mi', v.c.defaultMi, v.validNum);
            addParameter(p, 'lambda', v.c.defaultLambda, v.validNum);

            addParameter(p, 'uMin', v.c.defaultuMin, v.validNum);
            addParameter(p, 'uMax', v.c.defaultuMax, v.validNum);

            addParameter(p, 'duMin', v.c.defaultduMin, v.validNum);
            addParameter(p, 'duMax', v.c.defaultduMax, v.validNum);

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
            obj.dB = v.validateMatrixSize(p.Results.dB, 'dB', obj.nx,...
                obj.nu);
            obj.dC = v.validateMatrixSize(p.Results.dC, 'dC', obj.ny,...
                obj.nx);
            obj.dD = v.validateMatrixSize(p.Results.dD, 'dD', obj.ny,...
                obj.nu);

            % Assign optional parameters
            obj.nz = p.Results.nz;
            obj.nxz = p.Results.nxz;
            obj.dAz = p.Results.dAz;
            obj.dBz = p.Results.dBz;
            obj.dCz = p.Results.dCz;
            obj.dDz = p.Results.dDz;
            obj.mi = v.validateArray('mi', p.Results.mi, obj.ny);
            obj.lambda = v.validateLambda('lambda', p.Results.lambda, obj.nu);
            obj.uMin = v.validateArray('uMin', p.Results.uMin, obj.nu);
            obj.uMax = v.validateArray('uMax', p.Results.uMax, obj.nu);
            obj.duMin = v.validateArray('duMin', p.Results.duMin, obj.nu);
            obj.duMax = v.validateArray('duMax',p.Results.duMax, obj.nu);
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
            addParameter(p, 'nz', v.c.defaultnz,...
                v.validScalarIntGreaterThan0Num);
            addParameter(p, 'nxz', v.c.defaultnz,...
                v.validScalarIntGreaterThan0Num);
            addParameter(p, 'dAz', v.c.defaultEmptyMatrix, v.validSquareMatrix);
            addParameter(p, 'dBz', v.c.defaultEmptyMatrix, v.validMatrix);
            addParameter(p, 'dCz', v.c.defaultEmptyMatrix, v.validMatrix);
            addParameter(p, 'dDz', v.c.defaultEmptyMatrix, v.validMatrix);

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
            parse(p, N, Nu, ny, nu, nx, dA, dB, dC, dD, varargin_{:});

            % Assign required parameters
            obj.N = p.Results.N;
            obj.Nu = p.Results.Nu;
            obj.ny = p.Results.numberOfOutputs;
            obj.nu = p.Results.numberOfInputs;
            obj.nx = p.Results.numberOfStateVariables;
            obj.dA = v.validateAStateMatrix(p.Results.dA, obj.nx);
            obj.dB = v.validateMatrixSize(p.Results.dB, 'dB', obj.nx,...
                obj.nu);
            obj.dC = v.validateMatrixSize(p.Results.dC, 'dC', obj.ny,...
                obj.nx);
            obj.dD = v.validateMatrixSize(p.Results.dD, 'dD', obj.ny,...
                obj.nu);

            % Assign optional parameters
            obj.nz = p.Results.nz;
            obj.nxz = p.Results.nxz;
            obj.dAz = p.Results.dAz;
            obj.dBz = p.Results.dBz;
            obj.dCz = p.Results.dCz;
            obj.dDz = p.Results.dDz;
            obj.mi = v.validateArray('mi', p.Results.mi, obj.ny);
            obj.lambda = v.validateLambda('lambda', p.Results.lambda,...
                obj.nu);
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
