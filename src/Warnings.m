%% Warnings
% Contains warning throwing functions used in the library
% Compatible with Octave
classdef Warnings
    methods (Access = public, Static = true)
        function showStepResponseToShort(cu, cy, s_len, D)
            warning(sprintf('Step response for combination of input (%s) and output (%s) is shorter (%s) than dynamic horizon D=%s. Assumed constant step response equal to last known element.',...
                num2str(cu), num2str(cy),...
                num2str(s_len),...
                num2str(D)));
        end

        function showValueStretchedToArray(arrayName, value, n)
            warning(sprintf('Assumed array %s consists of %s elements with a value of %s',...
                arrayName, num2str(n), num2str(value)));
        end

        function showValueStretchedToMatrix(matrixName, value, nRows, nColumns)
            warning(sprintf('Assumed (%s x %s) %s matrix consists entirely of elements with a value of %s',...
                num2str(nRows), num2str(nColumns), matrixName, num2str(value)));
        end

        function showLambda0()
            warning('Lambda value set to 0. Regulator might be unstable.');
        end

        function removedYConstraints()
            warning('Provided output (yMin, yMax) limits removed, because optimisation could not find solutions.');
        end

        function removedDUConstraints()
            warning('Provided control change (duMin, duMax) limits removed, because optimisation could not find solutions.');
        end

        function removedUConstraints()
            warning('Provided control (uMin, uMax) limits removed, because optimisation could not find solutions.');
        end
    end
end
