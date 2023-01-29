%!assert(disturbanceGPC('analytical') < 0)
%!assert(disturbanceGPC('fast') < 0)
%!assert(disturbanceGPC('numerical') < 0)


function err = disturbanceGPC(varargin)
    if size(varargin, 1) == 0 algType = 'analytical'; isPlotting = false;
    elseif size(varargin, 1) == 1 algType = varargin{1}; isPlotting = false;
    else algType = varargin{1}; isPlotting = varargin{2}; end

    load(Utilities.getObjBinFilePath('1x1Disturbance.mat'));
    %% Disturbance
    Az = A; Bz = B; IODelayZ = IODelay;
    [UUz, kkz] = getU1DisturbanceControl();

    %% Object
    [YYzad, kk, ypp, upp, xpp] = getY1DisturbanceTrajectory();

    lambda = 0;
    w = warning('off', 'all');
    regGPC = GPC(N, Nu, ny, nu, A, B,...
        'N1', N1, 'mi', mi, 'lambda', lambda, 'IODelay', IODelay,...
        'uMin', uMin, 'uMax', uMax, 'duMin', duMin, 'duMax', duMax,...
        'algType', algType);

    regGPCz = GPC(N, Nu, ny, nu, A, B,...
        'N1', N1, 'mi', mi, 'lambda', lambda, 'IODelay', IODelay,...
        'uMin', uMin, 'uMax', uMax, 'duMin', duMin, 'duMax', duMax,...
        'nz', nz, 'Az', Az, 'Bz', Bz, 'IODelayZ', IODelayZ,...
        'algType', algType);
    warning(w);

    YY_GPC = ones(kk, ny) * ypp;
    UU_GPC = ones(kk, nu) * upp;
    YY_GPC_k_1 = ones(1, ny) * ypp;

    YYz_GPC = ones(kk, ny) * ypp;
    UUz_GPC = ones(kk, nu) * upp;
    YYz_GPC_k_1 = ones(1, ny) * ypp;

    YYo_GPC = ones(kk, ny) * ypp;
    YYoz_GPC = ones(kk, ny) * ypp;

    YYz = ones(kk, ny) * ypp;

    for k=1:kk
        YYz(k, :) = getObjectOutputEq(Az, Bz, YYz, ypp, UUz, upp,...
            ny, nu, IODelayZ, k);

        % Not including measured disturbance
        UU_GPC(k, :) = regGPC.calculateControl(YY_GPC_k_1, YYzad(k, :));
        YY_GPC(k, :) = getObjectOutputEq(A, B, YY_GPC, ypp, UU_GPC, upp,...
            ny, nu, IODelay, k);
        YYo_GPC(k, :) = YY_GPC(k, :) + YYz(k, :);
        YY_GPC_k_1 = YYo_GPC(k, :);

        % Including measured disturbance
        UUz_GPC(k, :) = regGPCz.calculateControl(YYz_GPC_k_1, YYzad(k, :),...
            UUz(k, :));
        YYz_GPC(k, :) = getObjectOutputEq(A, B, YYz_GPC, ypp, UUz_GPC, upp,...
            ny, nu, IODelay, k);
        YYoz_GPC(k, :) = YYz_GPC(k, :) + YYz(k, :);
        YYz_GPC_k_1 = YYoz_GPC(k, :);
    end

    errGPCNoCompDisturbance = Utilities.calMatrixError(YYo_GPC, YYzad);
    errGPCCompDisturbance = Utilities.calMatrixError(YYoz_GPC, YYzad);
    err = errGPCCompDisturbance - errGPCNoCompDisturbance;

    fprintf('GPC disturbance: No compensation: %f, Compensation: %f, diff: %f\n',...
        errGPCNoCompDisturbance, errGPCCompDisturbance, err);

    % Plotting
    if isPlotting
        plotRun(YYo_GPC, YYzad, UU_GPC, st, ny, nu, 'GPC', algType);
        plotRun(YYoz_GPC, YYzad, UUz_GPC, st, ny, nu, 'GPC', algType);
        figure;
        hold on
            plot(YYo_GPC)
            plot(YYoz_GPC)
        hold off
        legend({'Y without disturbance compensation',...
            'Y with disturbance compensation'});
    end
end
