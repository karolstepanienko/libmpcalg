classdef Validation
    properties
        % Int
        validScalarIntGreaterThan0Num
        validScalarIntGreaterThan1Num
        % Double
        validScalarDoubleNum
        validScalarDoubleLessThan0Num
        validScalarDoubleGreaterThan0Num
        % Double or array
        validNum
        % Matrix
        validMatrix
        validSquareMatrix
        % Cell
        validCell
        % Struct
        validStruct
        % Algorithm type
        validAlgType
        % Function handle
        validFunctionHandle
    end

    properties (Constant)
        c = Constants()  % Constant values
    end

    methods
        %--------------------------- int > 0 -----------------------------------

        %% get.validScalarIntGreaterThan0Num
        % Returns function for validating integers
        function validScalarIntGreaterThan0Num = get.validScalarIntGreaterThan0Num(obj)
            validScalarIntGreaterThan0Num = @(x) isnumeric(x) && isscalar(x)...
            && x == round(x) && mod(x, 1) == 0 && obj.isPositive(x);
        end

        %% get.validScalarIntGreaterThan1Num
        % Returns function for validating integers
        function validScalarIntGreaterThan1Num = get.validScalarIntGreaterThan1Num(obj)
            validScalarIntGreaterThan1Num = @(x) isnumeric(x) && isscalar(x)...
            && x == round(x) && mod(x, 1) == 0 && obj.isMoreOrEqualTo2(x);
        end

        %--------------------------- double ------------------------------------

        %% get.validScalarDoubleNum
        % Returns function for validating doubles
        function validScalarDoubleNum = get.validScalarDoubleNum(obj)
            validScalarDoubleNum = @(x) isnumeric(x) && isscalar(x)...
                && isa(x, 'double');
        end

        %--------------------------- double < 0 --------------------------------

        %% get.validScalarDoubleLessThan0Num
        % Returns function for validating doubles smaller or equal to zero
        function validScalarDoubleLessThan0Num = get.validScalarDoubleLessThan0Num(obj)
            validScalarDoubleLessThan0Num = @(x) isnumeric(x) && isscalar(x) &&...
                isa(x, 'double') && obj.isNegativeOrEqualToZero(x);
        end

        %--------------------------- double > 0 --------------------------------

        %% get.validScalarDoubleGreaterThan0Num
        % Returns function for validating doubles bigger or equal to zero
        function validScalarDoubleGreaterThan0Num = get.validScalarDoubleGreaterThan0Num(obj)
            validScalarDoubleGreaterThan0Num = @(x) isnumeric(x) && isscalar(x) &&...
                isa(x, 'double') && obj.isPositiveOrEqualToZero(x);
        end

        %---------------------------- vector -----------------------------------
        function validNum = get.validNum(obj)
            validNum = @isnumeric;
        end

        function value = validateLambda(obj, arrayName, array, n)
            if ismember(0, array)
                Warnings.showLambda0();
            end
            value = obj.validateArray(arrayName, array, n);
        end

        function value = validateArray(obj, arrayName, array, n)
            value = obj.stretchValueToArray(arrayName, array, n);
            value = obj.validateArraySize(arrayName, value, n);
            value = obj.validateArrayIsHorizontal(arrayName, value);
        end

        function stretchedArray = stretchValueToArray(obj, arrayName, array, n)
            % length(x) returns the length of the largest array dimension in x
            if length(array) == 1 && n ~= 1
                stretchedArray = array * ones(1, n);
                Warnings.showValueStretchedToArray(arrayName, array, n);
            else
                stretchedArray = array;
            end
        end

        function value = validateArraySize(obj, arrayName, array, n)
            if length(array) ~= n
                Exceptions.throwArrayInvalidSize(arrayName, n);
            else
                value = array;
            end
        end

        function value = validateArrayIsHorizontal(obj, arrayName, array)
            if size(array, 1) ~= 1
                Exceptions.throwArrayNotHorizontal(arrayName);
            else
                value = array;
            end
        end

        %---------------------------- matrix -----------------------------------
        function validSquareMatrix = get.validSquareMatrix(obj)
            validSquareMatrix = @(x) isnumeric(x) && isa(x, 'double') &&...
                ismatrix(x) && size(x, 1) == size(x, 2);
        end

        % Not tested
        function validMatrix = get.validMatrix(obj)
            validMatrix = @(x) isnumeric(x) && isa(x, 'double') && ismatrix(x);
        end

        function isValid = validateSquareMatrix(obj, matrix, matrixName, n)
            isValid = false;
            if size(matrix, 1) ~= n || size(matrix, 2) ~= n
                Exceptions.throwMatrixNotSquare(matrixName);
            else
                isValid = true;
            end
        end

        function value = validateAStateMatrix(obj, dA, nx)
            if obj.validateSquareMatrix(dA, 'dA', nx)
                value = dA;
            end
        end

        function value = validateMatrixSize(obj, matrix, matrixName, nRows,...
            nColumns)
            if ~(size(matrix, 1) == nRows && size(matrix, 2) == nColumns)
                Exceptions.throwMatrixInvalidSize(matrixName, nRows, nColumns);
            else
                value = matrix;
            end
        end

        function value = validateInitialisationMatrix(obj, matrix,...
            matrixName, nRows, nColumns)
            % Matrix has more or equal rows than nRows and nColumns or matrix is
            % empty
            if isempty(matrix)
                value = matrix;
            elseif ~(size(matrix, 1) >= nRows && size(matrix, 2) == nColumns)
                Exceptions.throwInvalidInitialisationMatrix(matrixName,...
                nRows, nColumns);
            else
                value = matrix;
            end
        end

        function value = validateIODelay(obj, matrix, matrixName, nRows,...
            nColumns)
            value = obj.stretchValueToMatrix(matrix, matrixName, nRows,...
                nColumns);
            value = obj.validateMatrixSize(value, matrixName, nRows, nColumns);
        end

        function stretchedMatrix = stretchValueToMatrix(obj, matrix,...
            matrixName, nRows, nColumns)
            % length(x) returns the length of the largest dimension in x
            if length(matrix) == 1 && (nRows ~= 1 || nColumns ~= 1)
                stretchedMatrix= matrix * ones(nRows, nColumns);
                Warnings.showValueStretchedToMatrix(matrixName, matrix,...
                nRows, nColumns);
            else
                stretchedMatrix = matrix;
            end
        end

        %--------------------------- cell --------------------------------------
        function validCell = get.validCell(obj)
            validCell = @(x) iscell(x) && ~isempty(x);
        end

        function stepResponses = validateStepResponses(obj, stepResponses,...
            ny, nu, D)
            % Check number of inputs
            if size(stepResponses, 1) ~= nu
                Exceptions.throwStepResponsesInvalidNumberOfInputs(...
                    nu, size(stepResponses, 1));
            end

            % Check number of outputs
            for i=1:nu
                if size(stepResponses{i}, 2) ~= ny
                    Exceptions.throwStepResponsesInvalidNumberOfOutputs(...
                    ny, size(stepResponses{i}, 2));
                end
            end

            % Warn if step response is shorter than dynamic horizon D
            for cu=1:nu
                for cy=1:ny
                    if size(stepResponses{cu}(:, cy), 1) < D
                        Warnings.showStepResponseToShort(cu, cy,...
                        size(stepResponses{cu}(:, cy), 1), D);
                    end
                end
            end
        end

        function A = validateA(obj, A, ny)
            if size(A, 1) == ny && size(A, 2) == ny
                A = A;
            else
                Exceptions.throwCellInvalidSize('A', ny, ny);
            end
        end

        function B = validateB(obj, B, ny, nu)
            if size(B, 1) == ny && size(B, 2) == nu
                B = B;
            else
                Exceptions.throwCellInvalidSize('B', ny, nu);
            end
        end

        %---------------------------- struct -----------------------------------
        function validStruct = get.validStruct(obj)
            validStruct = @(x) isstruct(x);
        end

        %---------------------------- algType ----------------------------------
        function validAlgType = get.validAlgType(obj)
            validAlgType = @(x) any(validatestring(x, obj.c.algTypes));
        end

        %------------------------ function handle ------------------------------
        function validFunctionHandle = get.validFunctionHandle(obj)
            validFunctionHandle = @(x) isa(x, 'function_handle');
        end
    end

    methods (Static)
        % Those methods were implemented for the purpose of Octave tests

        function r = isPositive(x)
            if x > 0
                r = 1;
            else
                r = 0;
            end
        end

        function r = isNegativeOrEqualToZero(x)
            if x <= 0
                r = 1;
            else
                r = 0;
            end
        end

        function r = isPositiveOrEqualToZero(x)
            if x >= 0
                r = 1;
            else
                r = 0;
            end
        end

        function r = isMoreOrEqualTo2(x)
            if x >= 2 r = 1; else r = 0; end
        end
    end
end
