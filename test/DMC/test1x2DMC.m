function test1x2DMC(funcDMC)
    %% Object
    % Setting sampling time -> ../../obj/get1x2.m
    load(Utilities.getObjBinFilePath('1x2.mat'));

    %% Trajectory
    [Yzad, kk, ypp, upp] = getY1Trajectory();

    %% Test loop
    testSingleDMC(funcDMC, ny, nu, st, numDen, ypp, upp, Yzad, kk);
end
