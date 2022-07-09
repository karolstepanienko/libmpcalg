%% runAllDMC
% Runs all DMC algorithm combinations of test object and algorithm type
function runAllDMC()    
    run1x1('DMC', 'analytical');
    run1x1('DMC', 'fast');
    run1x1('DMC', 'numerical');

    run1x2('DMC', 'analytical');
    run1x2('DMC', 'fast');
    run1x2('DMC', 'numerical');

    run2x2('DMC', 'analytical');
    run2x2('DMC', 'fast');
    run2x2('DMC', 'numerical');
end
