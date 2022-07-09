function run2x2(algName, algType)
    %% Object
    % Setting sampling time -> ../../obj/get2x2.m
    load(Utilities.getObjBinFilePath('2x2.mat'));
    
    %% Trajectory
    [Yzad, kk, ypp, upp] = getY2Trajectory();

    %% Test loop
    if strcmp(algName, 'DMC')
        runSingleDMC(algType, ny, nu, st, A, B, ypp, upp, Yzad, kk);
    else
        disp(Utilities.joinText('Unknown algorithm : ', algName));
    end;
end