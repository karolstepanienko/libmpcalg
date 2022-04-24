function test1x1DMC(classDMC, plotTitle)
    %% Object
    % Setting sampling time -> ../../obj/get1x1.m
    load(Utilities.getObjBinFilePath('1x1.mat'));

    %% Trajectory
    [Yzad, kk, ypp, upp] = getY1Trajectory();
    
    %% Test loop
    testSingleDMC(classDMC, plotTitle, ny, nu, st, numDen, ypp, upp, Yzad, kk);
end
