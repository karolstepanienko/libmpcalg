%!assert(disturbanceMPCS() < 0)


function err = disturbanceMPCS(varargin)
    if size(varargin, 1) == 0 isPlotting = false;
    else isPlotting = varargin{1}; end

    load(Utilities.getObjBinFilePath('1x1Disturbance.mat'));
    %% Disturbance
    nxz = nx; dAz = dA; dBz = dB; dCz = dC; dDz = dD;
    InputDelayZ = InputDelay; OutputDelayZ = OutputDelay;
    [UUz, kkz] = getU1DisturbanceControl();

    %% Object
    [YYzad, kk, ypp, upp, xpp] = getY1DisturbanceTrajectory();

    load(Utilities.getObjBinFilePath('1x1.mat'));
    algType = 'analytical';

    regMPCS = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
        'mi', mi, 'lambda', lambda, 'uMin', uMin, 'uMax', uMax,...
        'duMin', duMin, 'duMax', duMax, 'algType', algType);

    regMPCSz = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
        'mi', mi, 'lambda', lambda, 'uMin', uMin, 'uMax', uMax,...
        'nz', nz, 'nxz', nxz, 'dAz', dAz, 'dBz', dBz, 'dCz', dCz, 'dDz', dDz,...
        'duMin', duMin, 'duMax', duMax, 'algType', algType);

    XX_MPCS = ones(kk, nx) * xpp;
    YY_MPCS = ones(kk, ny) * ypp;
    UU_MPCS = ones(kk, nu) * upp;
    YY_MPCS_k_1 = ones(1, ny) * ypp;

    XXz_MPCS = ones(kk, nx) * xpp;
    YYz_MPCS = ones(kk, ny) * ypp;
    UUz_MPCS = ones(kk, nu) * upp;
    YYz_MPCS_k_1 = ones(1, ny) * ypp;

    XXz = ones(kk, nxz) * xpp;
    YYz = ones(kk, ny) * ypp;

    for k=1:kk
        [XXz(k + 1, :), YYz(k, :)] = getObjectOutputState(...
            dAz, dBz, dCz, dDz, XXz, xpp, nxz, UUz, upp, nz, ny,...
            InputDelayZ, OutputDelayZ, k);

        % Not including measured disturbance
        UU_MPCS(k, :) = regMPCS.calculateControl(XX_MPCS(k, :), YY_MPCS_k_1,...
            YYzad(k, :));
        [XX_MPCS(k + 1, :), YY_MPCS(k, :)] = getObjectOutputState(...
            dA, dB, dC, dD, XX_MPCS, xpp, nx, UU_MPCS, upp, nu, ny,...
            InputDelay, OutputDelay, k);
        % Add disturbance
        YY_MPCS(k, :) = YY_MPCS(k, :) + YYz(k, :);
        YY_MPCS_k_1 = YY_MPCS(k, :);

        % Including measured disturbance
        UUz_MPCS(k, :) = regMPCSz.calculateControl(XXz_MPCS(k, :),...
            YYz_MPCS_k_1, YYzad(k, :), XXz(k + 1, :), UUz(k, :));

        [XXz_MPCS(k + 1, :), YYz_MPCS(k, :)] = getObjectOutputState(...
            dA, dB, dC, dD, XXz_MPCS, xpp, nx, UUz_MPCS, upp, nu, ny,...
            InputDelay, OutputDelay, k);
        % Add disturbance
        YYz_MPCS(k, :) = YYz_MPCS(k, :) + YYz(k, :);
        YYz_MPCS_k_1 = YYz_MPCS(k, :);
    end

    errMPCSNoCompDisturbance = Utilities.calMatrixError(YY_MPCS, YYzad)
    errMPCSCompDisturbance = Utilities.calMatrixError(YYz_MPCS, YYzad)
    err = errMPCSCompDisturbance - errMPCSNoCompDisturbance;

    % Plotting
    if isPlotting
        plotRun(YY_MPCS, YYzad, UU_MPCS, st, ny, nu, 'MPCS', algType);
        plotRun(YYz_MPCS, YYzad, UUz_MPCS, st, ny, nu, 'MPCS', algType);
        figure;
        hold on
            plot(YY_MPCS)
            plot(YYz_MPCS)
        hold off
        legend({'Y without disturbance compensation',...
            'Y with disturbance compensation'});
    end
end
