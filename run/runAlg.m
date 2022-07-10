function e = runAlg(object, algName, algType, varargin)
    %% Load object
    load(Utilities.getObjBinFilePath(Utilities.joinText(object, '.mat')));

    %% Trajectory
    trajectoryGetterFunc = getTrajectory(object);
    [Yzad, kk, ypp, upp] = trajectoryGetterFunc();

    %% Check for plotting being turned off
    if length(varargin) >= 1
        isPlotting = varargin{1};
    else
        isPlotting = true;
    end

    %% Test loop
    if strcmp(algName, 'DMC')
        e = runSingleDMC(D, N, Nu, mi, lambda, uMin, uMax, duMin, duMax,...
        yMin, yMax, algType, ny, nu, st, A, B, ypp, upp, Yzad, kk, isPlotting);
    else
        disp(Utilities.joinText('Unknown algorithm : ', algName));
    end
end
