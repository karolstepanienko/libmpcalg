%% testAllDMC
% Runs all DMC algorithm tests
function testAllDMC()    
    test1x1DMC(@AnalyticalDMC, AnalyticalDMC.getPlotTitle());
    test1x1DMC(@FastDMC, FastDMC.getPlotTitle());
    test1x1DMC(@NumericalDMC, NumericalDMC.getPlotTitle());

    test1x2DMC(@AnalyticalDMC, AnalyticalDMC.getPlotTitle());
    test1x2DMC(@FastDMC, FastDMC.getPlotTitle());
    test1x2DMC(@NumericalDMC, NumericalDMC.getPlotTitle());
    
    test2x2DMC(@AnalyticalDMC, AnalyticalDMC.getPlotTitle());
    test2x2DMC(@FastDMC, FastDMC.getPlotTitle());
    test2x2DMC(@NumericalDMC, NumericalDMC.getPlotTitle());
end
