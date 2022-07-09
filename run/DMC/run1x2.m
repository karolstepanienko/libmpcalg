function run1x2(algName, algType)
    %% Object
    % Setting sampling time -> ../../obj/get1x2.m
    load(Utilities.getObjBinFilePath('1x2.mat'));

    %% Trajectory
    [Yzad, kk, ypp, upp] = getY1Trajectory();

    %% Test loop
    if strcmp(algName, 'DMC')
        runSingleDMC(algType, ny, nu, st, A, B, ypp, upp, Yzad, kk);
    else
        disp(Utilities.joinText('Unknown algorithm : ', algName));
    end;
end
