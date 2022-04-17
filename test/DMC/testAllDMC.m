%% testAllDMC
% Runs all DMC algorithm tests
function testAllDMC()    
    test1x1DMC(@classicDMC);
    test1x1DMC(@fastDMC);
    
    test1x2DMC(@classicDMC);
    test1x2DMC(@fastDMC);
    
    test2x2DMC(@classicDMC);
    test2x2DMC(@fastDMC);
end
