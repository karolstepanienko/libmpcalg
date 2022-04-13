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
    end

    methods
        %--------------------------- int > 0 -----------------------------------

        %% get.validScalarIntGreaterThan0Num
        % Returns function for validating integers
        function validScalarIntGreaterThan0Num = get.validScalarIntGreaterThan0Num(obj)
            validScalarIntGreaterThan0Num = @(x) isnumeric(x) && isscalar(x) &&...
                (mod(x, 1) == 0) && (x > 0);
        end
        
        %--------------------------- double ------------------------------------
        
        %% get.validScalarDoubleNum
        % Returns function for validating doubles
        function validScalarDoubleNum = get.validScalarDoubleNum(obj)
            validScalarDoubleNum = @(x) isnumeric(x) && isscalar(x) &&...
                isa(x, 'double');
        end

        %--------------------------- double < 0 --------------------------------

        %% get.validScalarDoubleLessThan0Num
        % Returns function for validating doubles smaller or equal to zero
        function validScalarDoubleLessThan0Num = get.validScalarDoubleLessThan0Num(obj)
            validScalarDoubleLessThan0Num = @(x) isnumeric(x) && isscalar(x) &&...
                isa(x, 'double') && (x <= 0);
        end

        %--------------------------- double > 0 --------------------------------

        %% get.validScalarDoubleGreaterThan0Num
        % Returns function for validating doubles bigger or equal to zero
        function validScalarDoubleGreaterThan0Num = get.validScalarDoubleGreaterThan0Num(obj)
            validScalarDoubleGreaterThan0Num = @(x) isnumeric(x) && isscalar(x) &&...
                isa(x, 'double') && (x >= 0);
        end

        %--------------------------- cell --------------------------------------
        function stepResponses = validateStepResponses(obj, stepResponses, ny, nu, D)
            % Check number of inputs
            if size(stepResponses, 1) ~= nu  
                error('stepResponses:InvalidNumberOfInputs',...
                    sprintf("Malformed step responses cell. Number of inputs (%s) doesn't match the number of inputs (%s) in provided step responses cell.",...
                    num2str(nu), num2str(size(stepResponses, 1)) ));
            end

            % Check number of outputs
            for i=1:nu
                if size(stepResponses{i}, 2) ~= ny
                    error('stepResponses:InvalidNumberOfOutputs',...
                        sprintf("Malformed step responses cell. Number of outputs (%s) doesn't match the number of outputs (%s) in provided step responses cell.",...
                        num2str(ny), num2str(size(stepResponses{i}, 2))));
                end
            end

            % Warn if step response is shorter than dynamic horizon D
            for cu=1:nu
                for cy=1:ny
                    if size(stepResponses{cu}(:, cy), 1) < D
                        warning(sprintf('Step response for combination of input (%s) and output (%s) is shorter (%s) than dynamic horizon D=%s. Assumed constant step response equal to last known element.',...
                        num2str(cu), num2str(cy),...
                        num2str(size(stepResponses{cu}(:, cy), 1)),...
                        num2str(D)));
                    end
                end
            end
        end

        function validCell = get.validCell(obj)
            validCell = @(x) iscell(x) && ~isempty(x);
        end

        %--------------------------- vector ------------------------------------
        function validNum = get.validNum(obj)
            validNum = @isnumeric;
        end

        function value = validateArray(obj, arrayName, array, n)
            if size(array, 1) == 1 && size(array, 2) == 1 && n ~= 1
                % Stretch the number to required array 
                value = zeros(1, n) + array;
            elseif size(array, 1) ~= 1 || size(array, 2) ~= n
                error('array:ArrayInvalidSize',...
                sprintf('Array %s should be horizontal and have (%s) elements.',...
                arrayName, num2str(n)));
            else
                value = array;
            end
        end
    end
end
