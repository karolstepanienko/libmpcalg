%!assert(compareAllLinear('1x1', false) < [10^-10, 10^-10, 10^-10, 10^-10, 10^-10, 10^-10])
%!assert(compareAllLinear('1x1SingleInertial', false) < [10^-20, 10^-20, 10^-20, 10^-20, 10^-20, 10^-20])


function [err_YY_DMC_GPC, err_YY_DMC_MPCS, err_YY_GPC_MPCS,...
    err_UU_DMC_GPC, err_UU_DMC_MPCS, err_UU_GPC_MPCS] =...
    compareAllLinear(object, isPlotting)
    load(Utilities.getObjBinFilePath([object, '.mat']));
    algType = 'analytical';

    % Lack of limits needed
    uMin = -Inf;
    uMax = -uMin;
    duMin = -Inf;
    duMax = -duMin;
    N = 25;
    D = 100;

    stepResponses = getStepResponsesEq(ny, nu, InputDelay, A, B, D);

    [YYzad, kk, ypp, upp, xpp] = getY1CompareTrajectory(osf);

    regDMC = DMC(D, N, Nu, ny, nu, stepResponses, 'mi', mi, 'lambda', lambda,...
        'uMin', uMin, 'uMax', uMax, 'duMin', duMin, 'duMax', duMax,...
        'algType', algType);

    regGPC = GPC(N, Nu, ny, nu, A, B, 'mi', mi, 'lambda', lambda,...
        'InputDelay', InputDelay, 'uMin', uMin, 'uMax', uMax,...
        'duMin', duMin, 'duMax', duMax, 'algType', algType);

    regMPCS = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
        'mi', mi, 'lambda', lambda, 'uMin', uMin, 'uMax', uMax,...
        'duMin', duMin, 'duMax', duMax, 'algType', algType);

    YY_DMC = ones(kk, ny) * ypp;
    UU_DMC = ones(kk, nu) * upp;
    YY_DMC_k_1 = ones(1, ny) * ypp;

    YY_GPC = ones(kk, ny) * ypp;
    UU_GPC = ones(kk, nu) * upp;
    YY_GPC_k_1 = ones(1, ny) * ypp;

    XX = ones(kk, nx) * xpp;
    YY_MPCS = ones(kk, ny) * ypp;
    UU_MPCS = ones(kk, nu) * upp;

    for k=1:kk
        regDMC = regDMC.calculateControl(YY_DMC_k_1, YYzad(k, :));
        UU_DMC(k, :) = regDMC.getControl();
        YY_DMC(k, :) = getObjectOutputEq(A, B, YY_DMC, ypp, UU_DMC, upp,...
            ny, nu, InputDelay, k);
        YY_DMC_k_1 = YY_DMC(k, :);

        regGPC = regGPC.calculateControl(YY_GPC_k_1, YYzad(k, :));
        UU_GPC(k, :) = regGPC.getControl();
        YY_GPC(k, :) = getObjectOutputEq(A, B, YY_GPC, ypp, UU_GPC, upp,...
            ny, nu, InputDelay, k);
        YY_GPC_k_1 = YY_GPC(k, :);

        regMPCS = regMPCS.calculateControl(XX(k, :), YYzad(k, :));
        UU_MPCS(k, :) = regMPCS.getControl();
        [XX(k + 1, :), YY_MPCS(k, :)] = getObjectOutputState(dA, dB, dC,...
            dD, XX, xpp, nx, UU_MPCS, upp, nu, ny, InputDelay, k);
    end

    err_YY_DMC_GPC = Utilities.calMatrixError(YY_DMC, YY_GPC);
    err_YY_DMC_MPCS = Utilities.calMatrixError(YY_DMC, YY_MPCS);
    err_YY_GPC_MPCS = Utilities.calMatrixError(YY_GPC, YY_MPCS);

    err_UU_DMC_GPC = Utilities.calMatrixError(UU_DMC, UU_GPC);
    err_UU_DMC_MPCS = Utilities.calMatrixError(UU_DMC, UU_MPCS);
    err_UU_GPC_MPCS = Utilities.calMatrixError(UU_GPC, UU_MPCS);

    % Plotting
    if isPlotting
        f = figure;
        subplot(1,2,1);
        hold on
            plot(YYzad);
            plot(YY_DMC);
            plot(YY_GPC);
            plot(YY_MPCS);
        hold off
        legend({'Y^{zad}', 'DMC', 'GPC', 'MPCS'});

        subplot(1,2,2);
        hold on
            stairs(UU_DMC);
            stairs(UU_GPC);
            stairs(UU_MPCS);
        hold off
        legend({'DMC', 'GPC', 'MPCS'});
    end
end
