function test2x2DMC(classDMC, plotTitle)
    %% Object
    % Setting sampling time -> ../../obj/get2x2.m
    load(Utilities.getObjBinFilePath('2x2.mat'));
    
    %% Trajectory
    [Yzad, kk, ypp, upp] = getY2Trajectory();

    %% Test loop
    testSingleDMC(classDMC, plotTitle, ny, nu, st, numDen, ypp, upp, Yzad, kk);
end
