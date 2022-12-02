%% runAllMPCS
% Runs all MPCS algorithm combinations of test object and algorithm type
function runAllMPCS(varargin)
    if size(varargin, 1) == 0 isPlotting = false;
    else isPlotting = varargin{1}; end

    runAlg('1x1', @MPCS, 'analytical', isPlotting);
    runAlg('1x1', @MPCS, 'fast', isPlotting);
    runAlg('1x1', @MPCS, 'numerical', isPlotting);

    runAlg('1x1RelativeTest', @MPCS, 'analytical', isPlotting);
    runAlg('1x1RelativeTest', @MPCS, 'fast', isPlotting);
    runAlg('1x1RelativeTest', @MPCS, 'numerical', isPlotting);

    runAlg('1x2', @MPCS, 'analytical', isPlotting);
    runAlg('1x2', @MPCS, 'fast', isPlotting);
    runAlg('1x2', @MPCS, 'numerical', isPlotting);

    runAlg('2x2', @MPCS, 'analytical', isPlotting);
    runAlg('2x2', @MPCS, 'fast', isPlotting);
    runAlg('2x2', @MPCS, 'numerical', isPlotting);
end
