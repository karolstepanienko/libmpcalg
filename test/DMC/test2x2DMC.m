function test2x2DMC(funcDMC)
    %% Object
    % Setting sampling time -> ../../obj/get2x2.m
    load(Utilities.getObjBinFilePath('2x2.mat'));
    
    %% Trajectory
    [Yzad, kk, ypp, upp] = getY2Trajectory();

    %% Test loop
    testSingleDMC(funcDMC, ny, nu, st, numDen, ypp, upp, Yzad, kk);
end
