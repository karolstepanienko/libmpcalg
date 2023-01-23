%!assert(testDelayN1('1x2Delay', false) < [10^-20, 10^-20, 10^-20, 10^-20])


function [err_YY_DMC_GPC, err_UU_DMC_GPC, err_YY_DMC_DMC_Delay,...
    err_YY_GPC_GPC_Delay] = testDelayN1(object, isPlotting)
    load(Utilities.getObjBinFilePath(Utilities.joinText(object, '.mat')));

    % Get D + 1 elements of object step response, because this method does not
    % remove the first step response element
    stepResponses = getStepResponsesEq(ny, nu, IODelay, A, B, D + 1);

    algType = 'fast';

    [YYzad, kk, ypp, upp, xpp] = getY1CompareTrajectory(osf);

    regDMC = DMC(D, N, Nu, ny, nu, stepResponses, 'mi', mi,...
        'lambda', lambda, 'uMin', uMin, 'uMax', uMax, 'duMin', duMin,...
        'duMax', duMax, 'algType', algType);

    regDMCDelay = DMC(D, N, Nu, ny, nu, stepResponses, 'N1', N1, 'mi', mi,...
        'lambda', lambda, 'uMin', uMin, 'uMax', uMax, 'duMin', duMin,...
        'duMax', duMax, 'algType', algType);

    regGPC = GPC(N, Nu, ny, nu, A, B, 'mi', mi, 'lambda', lambda,...
        'IODelay', IODelay, 'uMin', uMin, 'uMax', uMax,...
        'duMin', duMin, 'duMax', duMax, 'algType', algType);

    regGPCDelay = GPC(N, Nu, ny, nu, A, B, 'N1', N1, 'mi', mi, 'lambda', lambda,...
        'IODelay', IODelay, 'uMin', uMin, 'uMax', uMax,...
        'duMin', duMin, 'duMax', duMax, 'algType', algType);

    YY_DMC = ones(kk, ny) * ypp;
    UU_DMC = ones(kk, nu) * upp;
    YY_DMC_k_1 = ones(1, ny) * ypp;

    YY_DMC_Delay = ones(kk, ny) * ypp;
    UU_DMC_Delay = ones(kk, nu) * upp;
    YY_DMC_Delay_k_1 = ones(1, ny) * ypp;

    YY_GPC = ones(kk, ny) * ypp;
    UU_GPC = ones(kk, nu) * upp;
    YY_GPC_k_1 = ones(1, ny) * ypp;

    YY_GPC_Delay = ones(kk, ny) * ypp;
    UU_GPC_Delay = ones(kk, nu) * upp;
    YY_GPC_Delay_k_1 = ones(1, ny) * ypp;

    for k=1:kk
        UU_DMC(k, :) = regDMC.calculateControl(YY_DMC_k_1, YYzad(k, :));
        YY_DMC(k, :) = getObjectOutputEq(A, B, YY_DMC, ypp, UU_DMC, upp,...
            ny, nu, IODelay, k);
        YY_DMC_k_1 = YY_DMC(k, :);

        UU_DMC_Delay(k, :) = regDMCDelay.calculateControl(YY_DMC_Delay_k_1,...
            YYzad(k, :));
        YY_DMC_Delay(k, :) = getObjectOutputEq(A, B, YY_DMC_Delay, ypp,...
            UU_DMC_Delay, upp, ny, nu, IODelay, k);
        YY_DMC_Delay_k_1 = YY_DMC_Delay(k, :);

        UU_GPC(k, :) = regGPC.calculateControl(YY_GPC_k_1, YYzad(k, :));
        YY_GPC(k, :) = getObjectOutputEq(A, B, YY_GPC, ypp, UU_GPC, upp,...
            ny, nu, IODelay, k);
        YY_GPC_k_1 = YY_GPC(k, :);

        UU_GPC_Delay(k, :) = regGPCDelay.calculateControl(YY_GPC_Delay_k_1,...
            YYzad(k, :));
        YY_GPC_Delay(k, :) = getObjectOutputEq(A, B, YY_GPC_Delay, ypp,...
            UU_GPC_Delay, upp, ny, nu, IODelay, k);
        YY_GPC_Delay_k_1 = YY_GPC_Delay(k, :);
    end

    err_YY_DMC_GPC = Utilities.calMatrixError(YY_DMC, YY_GPC);
    err_UU_DMC_GPC = Utilities.calMatrixError(UU_DMC, UU_GPC);
    err_YY_DMC_DMC_Delay =  Utilities.calMatrixError(YY_DMC, YY_DMC_Delay);
    err_YY_GPC_GPC_Delay =  Utilities.calMatrixError(YY_GPC, YY_GPC_Delay);

    fprintf('N1 = %d test for DMC and GPC algorithm.\n', N1);
    fprintf('err_YY_DMC_GPC = %s\n', num2str(err_YY_DMC_GPC));
    fprintf('err_UU_DMC_GPC = %s\n', num2str(err_UU_DMC_GPC));
    fprintf('err_YY_DMC_DMC_Delay = %s\n', num2str(err_YY_DMC_DMC_Delay));
    fprintf('err_YY_GPC_GPC_Delay = %s\n', num2str(err_YY_GPC_GPC_Delay));

    if isPlotting
        figure;
        hold on
            stairs(YYzad(:, 1));
            plot(YY_DMC(:, 1));
            plot(YY_GPC(:, 1));
        hold off
        legend({'DMC', 'GPC'});
    end
end
