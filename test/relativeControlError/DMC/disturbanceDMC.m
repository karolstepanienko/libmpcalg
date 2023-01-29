%!assert(disturbanceDMC('analytical') < 0)
%!assert(disturbanceDMC('fast') < 0)
%!assert(disturbanceDMC('numerical') < 0)


function err = disturbanceDMC(varargin)
    if size(varargin, 1) == 0 algType = 'analytical'; isPlotting = false;
    elseif size(varargin, 1) == 1 algType = varargin{1}; isPlotting = false;
    else algType = varargin{1}; isPlotting = varargin{2}; end

    load(Utilities.getObjBinFilePath('1x1Disturbance.mat'));
    %% Disturbance
    % Get D + 1 elements of object step response, because this method does not
    % remove the first step response element
    Dz = D; Az = A; Bz = B; IODelayZ = IODelay;
    stepResponsesZ = getStepResponsesEq(ny, nu, IODelay, Az, Bz, Dz + 1);
    [UUz, kkz] = getU1DisturbanceControl();

    %% Object
    [YYzad, kk, ypp, upp, xpp] = getY1DisturbanceTrajectory();

    stepResponses = getStepResponsesEq(ny, nu, IODelay, A, B, D + 1);
    lambda = 0;
    w = warning('off', 'all');
    regDMC = DMC(D, N, Nu, ny, nu, stepResponses, 'mi', mi, 'lambda', lambda,...
        'uMin', uMin, 'uMax', uMax, 'duMin', duMin, 'duMax', duMax,...
        'algType', algType);

    regDMCz = DMC(D, N, Nu, ny, nu, stepResponses, 'mi', mi, 'lambda', lambda,...
        'uMin', uMin, 'uMax', uMax, 'duMin', duMin, 'duMax', duMax,...
        'nz', nz, 'Dz', Dz, 'stepResponsesZ', stepResponsesZ,...
        'algType', algType);
    warning(w);

    YY_DMC = ones(kk, ny) * ypp;
    UU_DMC = ones(kk, nu) * upp;
    YY_DMC_k_1 = ones(1, ny) * ypp;

    YYz_DMC = ones(kk, ny) * ypp;
    UUz_DMC = ones(kk, nu) * upp;
    YYz_DMC_k_1 = ones(1, ny) * ypp;

    YYo_DMC = ones(kk, ny) * ypp;
    YYoz_DMC = ones(kk, ny) * ypp;

    YYz = ones(kk, ny) * ypp;

    for k=1:kk
        YYz(k, :) = getObjectOutputEq(Az, Bz, YYz, ypp, UUz, upp,...
            ny, nu, IODelayZ, k);

        % Not including measured disturbance
        UU_DMC(k, :) = regDMC.calculateControl(YY_DMC_k_1, YYzad(k, :));
        YY_DMC(k, :) = getObjectOutputEq(A, B, YY_DMC, ypp, UU_DMC, upp,...
            ny, nu, IODelay, k);
        YYo_DMC(k, :) = YY_DMC(k, :) + YYz(k, :);
        YY_DMC_k_1 = YYo_DMC(k, :);

        % Including measured disturbance
        UUz_DMC(k, :) = regDMCz.calculateControl(YYz_DMC_k_1, YYzad(k, :),...
            UUz(k, :));
        YYz_DMC(k, :) = getObjectOutputEq(A, B, YYz_DMC, ypp, UUz_DMC, upp,...
            ny, nu, IODelay, k);
        YYoz_DMC(k, :) = YYz_DMC(k, :) + YYz(k, :);
        YYz_DMC_k_1 = YYoz_DMC(k, :);
    end

    errDMCNoCompDisturbance = Utilities.calMatrixError(YYo_DMC, YYzad);
    errDMCCompDisturbance = Utilities.calMatrixError(YYoz_DMC, YYzad);
    err = errDMCCompDisturbance - errDMCNoCompDisturbance;

    fprintf('DMC disturbance: No compensation: %f, Compensation: %f, diff: %f\n',...
        errDMCNoCompDisturbance, errDMCCompDisturbance, err);


    % Plotting
    if isPlotting
        plotRun(YYo_DMC, YYzad, UU_DMC, st, ny, nu, 'DMC', algType);
        plotRun(YYoz_DMC, YYzad, UUz_DMC, st, ny, nu, 'DMC', algType);
        figure;
        hold on
            plot(YYo_DMC)
            plot(YYoz_DMC)
        hold off
        legend({'Y without disturbance compensation',...
            'Y with disturbance compensation'});
    end
end
