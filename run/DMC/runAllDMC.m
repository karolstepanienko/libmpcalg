%% runAllDMC
% Runs all DMC algorithm combinations of test object and algorithm type
function runAllDMC()    
    runAlg('1x1', @DMC, 'analytical');
    runAlg('1x1', @DMC, 'fast');
    runAlg('1x1', @DMC, 'numerical');

    runAlg('1x2', @DMC, 'analytical');
    runAlg('1x2', @DMC, 'fast');
    runAlg('1x2', @DMC, 'numerical');

    runAlg('2x2', @DMC, 'analytical');
    runAlg('2x2', @DMC, 'fast');
    runAlg('2x2', @DMC, 'numerical');
end
