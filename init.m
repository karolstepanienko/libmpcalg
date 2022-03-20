%% init
% Initialises all necessary paths used by the library.
% Run before using scripts.
function init()
    clear all;
    addpath('./src');
    u = Utilities();
    u.addAllPaths();
end
