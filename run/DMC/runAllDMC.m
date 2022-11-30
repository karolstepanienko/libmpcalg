%% runAllDMC
% Runs all DMC algorithm combinations of test object and algorithm type
function runAllDMC(varargin)
    if size(varargin, 1) == 0 isPlotting = false;
    else isPlotting = varargin{1}; end

    runAlg('1x1', @DMC, 'analytical', isPlotting);
    runAlg('1x1', @DMC, 'fast', isPlotting);
    runAlg('1x1', @DMC, 'numerical', isPlotting);

    runAlg('1x2', @DMC, 'analytical', isPlotting);
    runAlg('1x2', @DMC, 'fast', isPlotting);
    runAlg('1x2', @DMC, 'numerical', isPlotting);

    runAlg('2x2', @DMC, 'analytical', isPlotting);
    runAlg('2x2', @DMC, 'fast', isPlotting);
    runAlg('2x2', @DMC, 'numerical', isPlotting);
end
