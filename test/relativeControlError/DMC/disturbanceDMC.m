%!assert(disturbanceDMC() < 0)


function err = disturbanceDMC(varargin)
    if size(varargin, 1) == 0 isPlotting = false;
    else isPlotting = varargin{1}; end

    load(Utilities.getObjBinFilePath('1x1Disturbance.mat'));
    %% Disturbance
    % Get D + 1 elements of object step response, because this method does not
    % remove the first step response element
    Dz = D; Az = A; Bz = B; IODelayZ = IODelay;
    stepResponsesZ = getStepResponsesEq(ny, nu, IODelay, Az, Bz, Dz + 1);
    [UUz, kkz] = getU1DisturbanceControl();

    %% Object
    % [YYzad, kk, ypp, upp, xpp] = getY1Trajectory();
    [YYzad, kk, ypp, upp, xpp] = getY1DisturbanceTrajectory();
    YYzad = zeros(kk, 1);

    load(Utilities.getObjBinFilePath('1x1.mat'));
    stepResponses = getStepResponsesEq(ny, nu, IODelay, A, B, D + 1);
    algType = 'analytical';

    regDMC = DMC(D, N, Nu, ny, nu, stepResponses, 'mi', mi, 'lambda', lambda,...
        'uMin', uMin, 'uMax', uMax, 'duMin', duMin, 'duMax', duMax,...
        'algType', algType);

    regDMCz = DMC(D, N, Nu, ny, nu, stepResponses, 'mi', mi, 'lambda', lambda,...
        'uMin', uMin, 'uMax', uMax, 'duMin', duMin, 'duMax', duMax,...
        'nz', nz, 'Dz', Dz, 'stepResponsesZ', stepResponsesZ,...
        'algType', algType);

    YY_DMC = ones(kk, ny) * ypp;
    UU_DMC = ones(kk, nu) * upp;
    YY_DMC_k_1 = ones(1, ny) * ypp;

    YYz_DMC = ones(kk, ny) * ypp;
    UUz_DMC = ones(kk, nu) * upp;
    YYz_DMC_k_1 = ones(1, ny) * ypp;

    YYz = ones(kk, ny) * ypp;

    for k=1:kk
        YYz(k, :) = getObjectOutputEq(Az, Bz, YYz, ypp, UUz, upp,...
            ny, nu, IODelayZ, k);

        % Not including measured disturbance
        UU_DMC(k, :) = regDMC.calculateControl(YY_DMC_k_1, YYzad(k, :));
        YY_DMC(k, :) = getObjectOutputEq(A, B, YY_DMC, ypp, UU_DMC, upp,...
            ny, nu, IODelay, k);
        YY_DMC(k, :) = YY_DMC(k, :) + YYz(k, :);
        YY_DMC_k_1 = YY_DMC(k, :);

        % Including measured disturbance
        UUz_DMC(k, :) = regDMCz.calculateControl(YYz_DMC_k_1, YYzad(k, :),...
            UUz(k, :));
        YYz_DMC(k, :) = getObjectOutputEq(A, B, YYz_DMC, ypp, UUz_DMC, upp,...
            ny, nu, IODelay, k);
        YYz_DMC(k, :) = YYz_DMC(k, :) + YYz(k, :);
        YYz_DMC_k_1 = YYz_DMC(k, :);
    end

    errDMCNoCompDisturbance = Utilities.calMatrixError(YY_DMC, YYzad)
    errDMCCompDisturbance = Utilities.calMatrixError(YYz_DMC, YYzad)
    err = errDMCCompDisturbance - errDMCNoCompDisturbance;

    % Plotting
    if isPlotting
        plotRun(YY_DMC, YYzad, UU_DMC, st, ny, nu, 'DMC', algType);
        plotRun(YYz_DMC, YYzad, UUz_DMC, st, ny, nu, 'DMC', algType);
        figure;
        hold on
            plot(YY_DMC)
            plot(YYz_DMC)
        hold off
        legend({'Y without disturbance compensation',...
            'Y with disturbance compensation'});
    end
end
