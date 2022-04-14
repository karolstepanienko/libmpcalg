%% Exceptions
% Contains exception throwing functions used in the library
% Compatible with Octave
classdef Exceptions
    methods (Access = public, Static = true)
        function throwStepResponsesInvalidNumberOfInputs(nu, s_nu)
            error('stepResponses:InvalidNumberOfInputs',...
                sprintf("Malformed step responses cell. Number of inputs (%s) doesn't match the number of inputs (%s) in provided step responses cell.",...
                num2str(nu), num2str(s_nu)));
        end
        
        function throwStepResponsesInvalidNumberOfOutputs(ny, s_ny)
            error('stepResponses:InvalidNumberOfOutputs',...
                sprintf("Malformed step responses cell. Number of outputs (%s) doesn't match the number of outputs (%s) in provided step responses cell.",...
                num2str(ny), num2str(s_ny)));
        end

        function throwArrayInvalidSize(arrayName, n)
            error('array:ArrayInvalidSize',...
                sprintf('Array %s should be horizontal and have (%s) elements.',...
                arrayName, num2str(n)));
        end
    end
end
