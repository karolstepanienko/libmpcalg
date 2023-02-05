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
            addRequired(p, 'A', v.validCell);
            addRequired(p, 'B', v.validCell);

            % Optional parameters
            addParameter(p, 'nz', v.c.defaultnz,...
                v.validScalarIntGreaterThan0Num);
            addParameter(p, 'Az', v.c.defaultCell, v.validCell);
            addParameter(p, 'Bz', v.c.defaultCell, v.validCell);
            addParameter(p, 'IODelayZ', v.c.defaultIODelayZ, v.validNum);

            addParameter(p, 'N1', v.c.defaultN1,...
                v.validScalarIntGreaterThan0Num);
            addParameter(p, 'IODelay', v.c.defaultIODelay, v.validNum);
            addParameter(p, 'mi', v.c.defaultMi, v.validNum);
            addParameter(p, 'lambda', v.c.defaultLambda, v.validNum);

            addParameter(p, 'ypp', v.c.testYInitVal, v.validScalarDoubleNum);
            addParameter(p, 'upp', v.c.testUInitVal, v.validScalarDoubleNum);

            addParameter(p, 'uMin', v.c.defaultuMin, v.validNum);
            addParameter(p, 'uMax', v.c.defaultuMax, v.validNum);

            addParameter(p, 'duMin', v.c.defaultduMin, v.validNumLessThan0);
            addParameter(p, 'duMax', v.c.defaultduMax, v.validNumGreaterThan0);

            addParameter(p, 'k', v.c.defaultK, v.validScalarIntGreaterThan0Num);
            addParameter(p, 'YY', v.c.defaultEmptyMatrix, v.validNum);
            addParameter(p, 'YYz', v.c.defaultEmptyMatrix, v.validNum);
            addParameter(p, 'UU', v.c.defaultEmptyMatrix, v.validNum);
            addParameter(p, 'UUz', v.c.defaultEmptyMatrix, v.validNum);

            addParameter(p, 'algType', v.c.analyticalAlgType, v.validAlgType);

            % Parsing values
            parse(p, N, Nu, ny, nu, A, B, varargin_{:});

            % Assign required parameters
            obj.N = p.Results.N;
            obj.Nu = p.Results.Nu;
            obj.ny = p.Results.numberOfOutputs;
            obj.nu = p.Results.numberOfInputs;
            obj.A = v.validateCellSize('A', p.Results.A, obj.ny, obj.ny);
            obj.B = v.validateCellSize('B', p.Results.B, obj.ny, obj.nu);

            % Assign optional parameters
            v.validateAllDisturbanceParametersAssignedGPC(p.Results.nz,...
                p.Results.Az, p.Results.Bz, p.Results.IODelayZ);
            obj.nz = p.Results.nz;
            if obj.nz > 0
                obj.Az = v.validateCellSize('Az', p.Results.Az, obj.ny, obj.ny);
                obj.Bz = v.validateCellSize('Bz', p.Results.Bz, obj.ny, obj.nz);
                obj.IODelayZ = v.validateIODelay(p.Results.IODelayZ, 'IODelayZ',...
                obj.ny, obj.nz);
            else
                obj.Az = p.Results.Az;
                obj.Bz = p.Results.Bz;
                obj.IODelayZ = p.Results.IODelayZ;
            end
            obj.N1 = p.Results.N1;
            obj.IODelay = v.validateIODelay(p.Results.IODelay, 'IODelay',...
                obj.ny, obj.nu);
            obj.mi = v.validateArray('mi', p.Results.mi, obj.ny);
            obj.lambda = v.validateLambda('lambda', p.Results.lambda, obj.nu);
            obj.ypp = p.Results.ypp;
            obj.upp = p.Results.upp;
            obj.uMin = v.validateArray('uMin', p.Results.uMin, obj.nu);
            obj.uMax = v.validateArray('uMax', p.Results.uMax, obj.nu);
            obj.duMin = v.validateArray('duMin', p.Results.duMin, obj.nu);
            obj.duMax = v.validateArray('duMax',p.Results.duMax, obj.nu);
            obj.k = p.Results.k;
            % Y(k) is calculated in loop based on given Y(k-1) value, so values
            % Y(k-2),Y(k-3)... need to be already initialised
            obj.YY = v.validateInitialisationMatrix(p.Results.YY, 'YY',...
                obj.k - 2, obj.ny);
            obj.YYz = v.validateInitialisationMatrix(p.Results.YYz, 'YYz',...
                obj.k - 2, obj.ny);
            obj.UU = v.validateInitialisationMatrix(p.Results.UU, 'UU',...
                obj.k - 2, obj.nu);
            obj.UUz = v.validateInitialisationMatrix(p.Results.UUz, 'UUz',...
                obj.k - 2, obj.nz);
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
            addRequired(p, 'A', v.validCell);
            addRequired(p, 'B', v.validCell);

            % Optional parameters
            addParameter(p, 'nz', v.c.defaultnz,...
                v.validScalarIntGreaterThan0Num);
            addParameter(p, 'Az', v.c.defaultCell, v.validCell);
            addParameter(p, 'Bz', v.c.defaultCell, v.validCell);
            addParameter(p, 'IODelayZ', v.c.defaultIODelayZ, v.validNum);

            addParameter(p, 'N1', v.c.defaultN1,...
                v.validScalarIntGreaterThan0Num);
            addParameter(p, 'IODelay', v.c.defaultIODelay, v.validNum);
            addParameter(p, 'mi', v.c.defaultMi, v.validNum);
            addParameter(p, 'lambda', v.c.defaultLambda, v.validNum);

            addParameter(p, 'ypp', v.c.testYInitVal, v.validScalarDoubleNum);
            addParameter(p, 'upp', v.c.testUInitVal, v.validScalarDoubleNum);

            addParameter(p, 'uMin', v.c.defaultuMin, v.validNum);
            addParameter(p, 'uMax', v.c.defaultuMax, v.validNum);

            addParameter(p, 'duMin', v.c.defaultduMin, v.validNumLessThan0);
            addParameter(p, 'duMax', v.c.defaultduMax, v.validNumGreaterThan0);

            addParameter(p, 'yMin', v.c.defaultyMin, v.validNum);
            addParameter(p, 'yMax', v.c.defaultyMax, v.validNum);

            addParameter(p, 'k', v.c.defaultK, v.validScalarIntGreaterThan0Num);
            addParameter(p, 'YY', v.c.defaultEmptyMatrix, v.validNum);
            addParameter(p, 'YYz', v.c.defaultEmptyMatrix, v.validNum);
            addParameter(p, 'UU', v.c.defaultEmptyMatrix, v.validNum);
            addParameter(p, 'UUz', v.c.defaultEmptyMatrix, v.validNum);

            addParameter(p, 'algType', v.c.analyticalAlgType, v.validAlgType);

            % Parsing values
            parse(p, N, Nu, ny, nu, A, B, varargin_{:});

            % Assign required parameters
            obj.N = p.Results.N;
            obj.Nu = p.Results.Nu;
            obj.ny = p.Results.numberOfOutputs;
            obj.nu = p.Results.numberOfInputs;
            obj.A = v.validateCellSize('A', p.Results.A, obj.ny, obj.ny);
            obj.B = v.validateCellSize('B', p.Results.B, obj.ny, obj.nu);

            % Assign optional parameters
            v.validateAllDisturbanceParametersAssignedGPC(p.Results.nz,...
                p.Results.Az, p.Results.Bz, p.Results.IODelayZ);
            obj.nz = p.Results.nz;
            if obj.nz > 0
                obj.Az = v.validateCellSize('Az', p.Results.Az, obj.ny, obj.ny);
                obj.Bz = v.validateCellSize('Bz', p.Results.Bz, obj.ny, obj.nz);
                obj.IODelayZ = v.validateIODelay(p.Results.IODelayZ, 'IODelayZ',...
                obj.ny, obj.nz);
            else
                obj.Az = p.Results.Az;
                obj.Bz = p.Results.Bz;
                obj.IODelayZ = p.Results.IODelayZ;
            end
            obj.N1 = p.Results.N1;
            obj.IODelay = v.validateIODelay(p.Results.IODelay, 'IODelay',...
                obj.ny, obj.nu);
            obj.mi = v.validateArray('mi', p.Results.mi, obj.ny);
            obj.lambda = v.validateLambda('lambda', p.Results.lambda, obj.nu);
            obj.ypp = p.Results.ypp;
            obj.upp = p.Results.upp;
            obj.uMin = v.validateArray('uMin', p.Results.uMin, obj.nu);
            obj.uMax = v.validateArray('uMax', p.Results.uMax, obj.nu);
            obj.duMin = v.validateArray('duMin', p.Results.duMin, obj.nu);
            obj.duMax = v.validateArray('duMax',p.Results.duMax, obj.nu);
            obj.yMin = v.validateArray('yMin', p.Results.yMin, obj.ny);
            obj.yMax = v.validateArray('yMax', p.Results.yMax, obj.ny);
            obj.k = p.Results.k;
            % Y(k) is calculated in loop based on given Y(k-1) value, so values
            % Y(k-2),Y(k-3)... need to be already initialised
            obj.YY = v.validateInitialisationMatrix(p.Results.YY, 'YY',...
                obj.k - 2, obj.ny);
            obj.YYz = v.validateInitialisationMatrix(p.Results.YYz, 'YYz',...
                obj.k - 2, obj.ny);
            obj.UU = v.validateInitialisationMatrix(p.Results.UU, 'UU',...
                obj.k - 2, obj.nu);
            obj.UUz = v.validateInitialisationMatrix(p.Results.UUz, 'UUz',...
                obj.k - 2, obj.nz);
            % algType is not saved as a class property
        end
    end
end
