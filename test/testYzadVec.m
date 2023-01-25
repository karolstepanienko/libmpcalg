%!test(testYzadVec('2x3', false))

function testYzadVec(object, isPlotting)
    load(Utilities.getObjBinFilePath(Utilities.joinText(object, '.mat')));

    % Get D + 1 elements of object step response, because this method does not
    % remove the first step response element
    stepResponses = getStepResponsesEq(ny, nu, IODelay, A, B, D + 1);

    algType = 'fast';

    [YYzad, kk, ypp, upp, xpp] = getY2Trajectory(0.5);

    regDMC = DMC(D, N, Nu, ny, nu, stepResponses, 'N1', N1, 'mi', mi,...
        'lambda', lambda, 'uMin', uMin, 'uMax', uMax, 'duMin', duMin,...
        'duMax', duMax, 'algType', algType);

    regDMCTr = DMC(D, N, Nu, ny, nu, stepResponses, 'N1', N1, 'mi', mi,...
        'lambda', lambda, 'uMin', uMin, 'uMax', uMax, 'duMin', duMin,...
        'duMax', duMax, 'algType', algType);

    regGPC = GPC(N, Nu, ny, nu, A, B, 'N1', N1, 'mi', mi, 'lambda', lambda,...
        'IODelay', IODelay, 'uMin', uMin, 'uMax', uMax,...
        'duMin', duMin, 'duMax', duMax, 'algType', algType);

    regGPCTr = GPC(N, Nu, ny, nu, A, B, 'N1', N1, 'mi', mi, 'lambda', lambda,...
        'IODelay', IODelay, 'uMin', uMin, 'uMax', uMax,...
        'duMin', duMin, 'duMax', duMax, 'algType', algType);

    YY_DMC = ones(kk, ny) * ypp;
    UU_DMC = ones(kk, nu) * upp;
    YY_DMC_k_1 = ones(1, ny) * ypp;

    YY_DMC_Tr = ones(kk, ny) * ypp;
    UU_DMC_Tr = ones(kk, nu) * upp;
    YY_DMC_k_1_Tr = ones(1, ny) * ypp;

    YY_GPC = ones(kk, ny) * ypp;
    UU_GPC = ones(kk, nu) * upp;
    YY_GPC_k_1 = ones(1, ny) * ypp;

    YY_GPC_Tr = ones(kk, ny) * ypp;
    UU_GPC_Tr = ones(kk, nu) * upp;
    YY_GPC_k_1_Tr = ones(1, ny) * ypp;

    for k=1:kk
        UU_DMC(k, :) = regDMC.calculateControl(YY_DMC_k_1, YYzad(k, :));
        YY_DMC(k, :) = getObjectOutputEq(A, B, YY_DMC, ypp, UU_DMC, upp,...
            ny, nu, IODelay, k);
        YY_DMC_k_1 = YY_DMC(k, :);

        UU_DMC_Tr(k, :) = regDMCTr.calculateControl(YY_DMC_k_1_Tr,...
            YYzad(k:end, :));
        YY_DMC_Tr(k, :) = getObjectOutputEq(A, B, YY_DMC_Tr, ypp, UU_DMC_Tr,...
            upp, ny, nu, IODelay, k);
        YY_DMC_k_1_Tr = YY_DMC_Tr(k, :);

        UU_GPC(k, :) = regGPC.calculateControl(YY_GPC_k_1, YYzad(k, :));
        YY_GPC(k, :) = getObjectOutputEq(A, B, YY_GPC, ypp, UU_GPC, upp,...
            ny, nu, IODelay, k);
        YY_GPC_k_1 = YY_GPC(k, :);

        if k + 10 <= kk
            trLen = 10;
        else
            trLen = 0;
        end

        UU_GPC_Tr(k, :) = regGPCTr.calculateControl(YY_GPC_k_1_Tr,...
            YYzad(k:k + trLen, :));
        YY_GPC_Tr(k, :) = getObjectOutputEq(A, B, YY_GPC_Tr, ypp, UU_GPC_Tr,...
            upp, ny, nu, IODelay, k);
        YY_GPC_k_1_Tr = YY_GPC_Tr(k, :);
    end

    % Control error
    errDMC = Utilities.calculateError(YY_DMC, YYzad);
    errDMC_Tr = Utilities.calculateError(YY_DMC_Tr, YYzad);
    assert(errDMC > errDMC_Tr)
    fprintf('Multi-element Yzad test errDMC = %2.4f, errDMC_Tr = %2.4f\n',...
        errDMC, errDMC_Tr);

    errGPC = Utilities.calculateError(YY_GPC, YYzad);
    errGPC_Tr = Utilities.calculateError(YY_GPC_Tr, YYzad);
    assert(errGPC > errGPC_Tr)
    fprintf('Multi-element Yzad test errGPC = %2.4f, errGPC_Tr = %2.4f\n',...
        errGPC, errGPC_Tr);

    if isPlotting
        plotRun(YY_DMC, YYzad, UU_DMC, 0.1, ny, nu, 'DMC',...
            ['YzadVec NoTr', algType]);
        plotRun(YY_DMC_Tr, YYzad, UU_DMC_Tr, 0.1, ny, nu, 'DMC',...
            ['YzadVec Tr', algType]);
        plotRun(YY_GPC, YYzad, UU_GPC, 0.1, ny, nu, 'GPC',...
            ['YzadVec NoTr', algType]);
        plotRun(YY_GPC_Tr, YYzad, UU_GPC_Tr, 0.1, ny, nu, 'GPC',...
            ['YzadVec Tr', algType]);
    end
end
