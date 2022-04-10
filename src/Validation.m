classdef Validation
    properties (Access = private)
        validScalarIntB0Num
        validScalarDoubleNum
        validScalarDoubleS0Num
        validScalarDoubleB0Num
    end

    methods
        %--------------------------- int < 0 -----------------------------------

        %% get.validScalarIntB0Num
        % Returns function for validating integers
        function validScalarIntB0Num = get.validScalarIntB0Num(obj)
            validScalarIntB0Num = @(x) isnumeric(x) && isscalar(x) &&...
                (mod(x, 1) == 0) && (x > 0);
        end

        %% validateIntegerB0
        % Runs validation for an integer value larger than zero
        function value = validateIntegerB0(obj, value, variableName)
            value = obj.validate(value, variableName, obj.validScalarIntB0Num);
        end
        
        %--------------------------- double ------------------------------------
        
        %% get.validScalarDoubleNum
        % Returns function for validating doubles
        function validScalarDoubleNum = get.validScalarDoubleNum(obj)
            validScalarDoubleNum = @(x) isnumeric(x) && isscalar(x) &&...
                isa(x, 'double');
        end

        %% validateDouble
        % Runs validation for a double value
        function value = validateDouble(obj, value, variableName)
            value = obj.validate(value, variableName, obj.validScalarDoubleNum);
        end

        %--------------------------- double < 0 --------------------------------

        %% get.validScalarDoubleS0Num
        % Returns function for validating doubles smaller or equal to zero
        function validScalarDoubleS0Num = get.validScalarDoubleS0Num(obj)
            validScalarDoubleS0Num = @(x) isnumeric(x) && isscalar(x) &&...
                isa(x, 'double') && (x <= 0);
        end

        %% validateDoubleS0
        % Runs validation for a double value smaller or equal to zero
        function value = validateDoubleS0(obj, value, variableName)
            value = ...
                obj.validate(value, variableName, obj.validScalarDoubleS0Num);
        end

        %--------------------------- double > 0 --------------------------------

        %% get.validScalarDoubleB0Num
        % Returns function for validating doubles bigger or equal to zero
        function validScalarDoubleB0Num = get.validScalarDoubleB0Num(obj)
            validScalarDoubleB0Num = @(x) isnumeric(x) && isscalar(x) &&...
                isa(x, 'double') && (x >= 0);
        end

        %% validateDoubleB0
        % Runs validation for a double value bigger or equal to zero
        function value = validateDoubleB0(obj, value, variableName)
            value = ...
                obj.validate(value, variableName, obj.validScalarDoubleB0Num);
        end

        %--------------------------- cell --------------------------------------
        % TODO

        %--------------------------- vector ------------------------------------
        % TODO
        
        %-----------------------------------------------------------------------

        %% validate
        % General validation function
        function value = validate(obj, value, variableName, validationFunc)
            p = inputParser;
            addRequired(p, variableName, validationFunc);
            parse(p, value);
        end
    end
end
