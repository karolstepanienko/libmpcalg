%% testAllDMC
% Runs all DMC algorithm tests
function testAllDMC()    
    test1x1DMC(@analyticalDMC);
    test1x1DMC(@fastDMC);
    test1x1DMC(@numericalDMC);

    test1x2DMC(@analyticalDMC);
    test1x2DMC(@fastDMC);
    test1x2DMC(@numericalDMC);
    
    test2x2DMC(@analyticalDMC);
    test2x2DMC(@fastDMC);
    test2x2DMC(@numericalDMC);
end
