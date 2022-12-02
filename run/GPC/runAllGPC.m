%% runAllGPC
% Runs all GPC algorithm combinations of test object and algorithm type
function runAllGPC(varargin)
    if size(varargin, 1) == 0 isPlotting = false;
    else isPlotting = varargin{1}; end

    runAlg('1x1', @GPC, 'analytical', isPlotting);
    runAlg('1x1', @GPC, 'fast', isPlotting);
    runAlg('1x1', @GPC, 'numerical', isPlotting);

    runAlg('1x1RelativeTest', @GPC, 'analytical', isPlotting);
    runAlg('1x1RelativeTest', @GPC, 'fast', isPlotting);
    runAlg('1x1RelativeTest', @GPC, 'numerical', isPlotting);

    runAlg('1x2', @GPC, 'analytical', isPlotting);
    runAlg('1x2', @GPC, 'fast', isPlotting);
    runAlg('1x2', @GPC, 'numerical', isPlotting);

    runAlg('2x2', @GPC, 'analytical', isPlotting);
    runAlg('2x2', @GPC, 'fast', isPlotting);
    runAlg('2x2', @GPC, 'numerical', isPlotting);
end
