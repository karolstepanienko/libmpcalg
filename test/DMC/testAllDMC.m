%% testAllDMC
% Runs all DMC algorithm tests
function testAllDMC()    
    test1x1('DMC', 'analytical');
    test1x1('DMC', 'fast');
    test1x1('DMC', 'numerical');

    test1x2('DMC', 'analytical');
    test1x2('DMC', 'fast');
    test1x2('DMC', 'numerical');

    test2x2('DMC', 'analytical');
    test2x2('DMC', 'fast');
    test2x2('DMC', 'numerical');
end
