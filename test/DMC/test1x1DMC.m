function test1x1DMC(funcDMC)
    %% Object
    % Setting sampling time -> ../../obj/get1x1.m
    load(Utilities.getObjBinFilePath('1x1.mat'));

    %% Trajectory
    [Yzad, kk, ypp, upp] = getY1Trajectory();
    
    %% Test loop
    testSingleDMC(funcDMC, ny, nu, st, numDen, ypp, upp, Yzad, kk);
end
