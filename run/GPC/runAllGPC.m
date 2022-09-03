%% runAllGPC
% Runs all GPC algorithm combinations of test object and algorithm type
function runAllGPC()    
    runAlg('1x1', @GPC, 'analytical');
    runAlg('1x1', @GPC, 'fast');
    runAlg('1x1', @GPC, 'numerical');

    runAlg('1x2', @GPC, 'analytical');
    runAlg('1x2', @GPC, 'fast');
    runAlg('1x2', @GPC, 'numerical');

    runAlg('2x2', @GPC, 'analytical');
    runAlg('2x2', @GPC, 'fast');
    runAlg('2x2', @GPC, 'numerical');
end
