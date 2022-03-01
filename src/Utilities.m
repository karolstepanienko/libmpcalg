%% Utilities
% Class providing universal utilities
classdef Utilities
%     methods (Access = public)
%         function obj = Utilities()
%         end
%     end

    methods (Access = public, Static = true)
        %% isOctave
        % Checks if script is run in octave
        function r = isOctave()
            persistent x;
            if (isempty (x))
                x = exist ('OCTAVE_VERSION', 'builtin');
            end
            r = x;
        end
    end
end
