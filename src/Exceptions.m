%% Exceptions
% Contains exception throwing functions used in the library
% Compatible with Octave
classdef Exceptions
    methods (Access = public, Static = true)
        %------------------------- step response -------------------------------
        function throwStepResponsesInvalidNumberOfInputs(nu, s_nu)
            error('stepResponses:InvalidNumberOfInputs',...
                sprintf("Malformed step responses cell. Number of inputs (%s) doesn't match the number of inputs (%s) in provided step responses cell",...
                num2str(nu), num2str(s_nu)));
        end
        
        function throwStepResponsesInvalidNumberOfOutputs(ny, s_ny)
            error('stepResponses:InvalidNumberOfOutputs',...
                sprintf("Malformed step responses cell. Number of outputs (%s) doesn't match the number of outputs (%s) in provided step responses cell",...
                num2str(ny), num2str(s_ny)));
        end

        %---------------------------- array ------------------------------------
        function throwArrayInvalidSize(arrayName, n)
            error('array:ArrayInvalidSize',...
                sprintf('Array %s should have (%s) elements',...
                arrayName, num2str(n)));
        end
    
        function throwArrayNotHorizontal(arrayName)
            error('array:ArrayInvalidSize',...
                sprintf('Array %s should be horizontal', arrayName));
        end

        %---------------------------- matrix -----------------------------------
        function throwMatrixNotSquare(matrixName)
            error('matrix:MatrixNotSquare', ...
                sprintf('%s should be a square matrix', matrixName));
        end

        function throwMatrixInvalidSize(matrixName, nRow, nColumn)
            error('matrix:MatrixInvalidSize', ...
                sprintf('Matrix %s should have %s rows and %s columns',...
                matrixName, num2str(nRow), num2str(nColumn)));
        end
    end
end
