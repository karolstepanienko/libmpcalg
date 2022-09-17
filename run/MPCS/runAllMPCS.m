%% runAllMPCS
% Runs all MPCS algorithm combinations of test object and algorithm type
function runAllMPCS()    
    runAlg('1x1', @MPCS, 'analytical');

    runAlg('1x2', @MPCS, 'analytical');

    runAlg('2x2', @MPCS, 'analytical');
end
