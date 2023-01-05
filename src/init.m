%% init
% Initialises all necessary paths used by the library and removes unnecessary
% paths added by the user to avoid Octave path warnings.
% Run before using scripts.
function init()
    clear all;
    Utilities.addAllPaths();
    if Utilities.isOctave()
        w = warning('off', 'all');
        Utilities.removeNeedlesPaths();
        warning(w);
    end
end
