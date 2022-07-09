classdef Validation
    properties  %(Access = public)
        % Int
        validScalarIntGreaterThan0Num
        % Double
        validScalarDoubleNum
        validScalarDoubleLessThan0Num
        validScalarDoubleGreaterThan0Num
        % Cell
        validCell
        % Double or array
        validNum
        % Algorithm type
        validAlgType
    end

    properties (Access = private)
        c = Constants();  % Constant values
    end

    methods
        %--------------------------- int > 0 -----------------------------------

        %% get.validScalarIntGreaterThan0Num
        % Returns function for validating integers
        function validScalarIntGreaterThan0Num = get.validScalarIntGreaterThan0Num(obj)
            validScalarIntGreaterThan0Num = @(x) isnumeric(x) && isscalar(x)...
            && x == round(x) && mod(x, 1) == 0 && obj.isPositive(x);
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

        %--------------------------- cell --------------------------------------
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

        function validCell = get.validCell(obj)
            validCell = @(x) iscell(x) && ~isempty(x);
        end

        %---------------------------- vector -----------------------------------
        function validNum = get.validNum(obj)
            validNum = @isnumeric;
        end

        function value = validateArray(obj, arrayName, array, n)
            if obj.validateArraySize(arrayName, array, n)...
                && obj.validateArrayIsHorizontal(arrayName, array)
                value = array;
            end
        end

        function isValid = validateArraySize(obj, arrayName, array, n)
            isValid = false;
            if size(array, 1) == 1 && size(array, 2) ~= n
                Exceptions.throwArrayInvalidSize(arrayName, n);
            else
                isValid = true;
            end
        end

        function isValid = validateArrayIsHorizontal(obj, arrayName, array)
            isValid = false;
            if size(array, 1) ~= 1
                Exceptions.throwArrayNotHorizontal(arrayName);
            else
                isValid = true;
            end
        end

        %---------------------------- algType ----------------------------------
        function validAlgType = get.validAlgType(obj)
            validAlgType = @(x) any(validatestring(x, obj.c.algTypes));
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
    end
end
