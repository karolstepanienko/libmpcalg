function test1x1(algName, algType)
    %% Object
    % Setting sampling time -> ../../obj/get1x1.m
    load(Utilities.getObjBinFilePath('1x1.mat'));

    %% Trajectory
    [Yzad, kk, ypp, upp] = getY1Trajectory();

    %% Test loop
    if strcmp(algName, 'DMC')
        testSingleDMC(algType, ny, nu, st, numDen, ypp, upp, Yzad, kk);
    else
        disp(Utilities.joinText('Unknown algorithm : ', algName));
    end
end
