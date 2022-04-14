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
    end
end
