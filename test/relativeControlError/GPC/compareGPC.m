%!assert(compareGPC(false) < [10^-9, 10^-7])


%% compareGPC
% Comparison of GPC and MPCS algorithms from libmpcalg library
function [errorYY_GPC_MPCS, errorUU_GPC_MPCS] = compareGPC(varargin)
    if size(varargin, 1) == 0 isPlotting = false;
    else isPlotting = varargin{1}; end

    % Object
    object = '2x3';
    load(Utilities.getObjBinFilePath(Utilities.joinText(object, '.mat')));
    [YYzad, kk, ypp, upp, xpp] = getY2Trajectory(osf);

    % Regulator GPC
    algType = 'analytical';

    regMPCS = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
        'uMin', uMin, 'uMax', uMax, 'duMin', duMin, 'duMax', duMax,...
        'mi', mi, 'lambda', lambda, 'algType', algType);

    regGPC = AnalyticalGPC(N, Nu, ny, nu, A, B, 'mi', mi,...
        'lambda', lambda, 'InputDelay', InputDelay,...
        'uMin', uMin, 'uMax', -uMin,...
        'duMin', duMin, 'duMax', -duMin, 'ypp', ypp, 'upp', upp,...
        'algType', algType);

    XX_MPCS = ones(kk, nx) * xpp;
    YY_MPCS = ones(kk, ny) * ypp;
    UU_MPCS = ones(kk, nu) * upp;
    YY_k_1_MPCS = ones(1, ny) * ypp;

    YY_GPC = ones(kk, ny) * ypp;
    UU_GPC = ones(kk, nu) * upp;
    YY_k_1_GPC = ones(1, ny) * ypp;

    % GPC control loop
    for k=1:kk
        regMPCS = regMPCS.calculateControl(XX_MPCS(k, :), YYzad(k, :));
        UU_MPCS(k, :) = regMPCS.getControl();
        [XX_MPCS(k + 1, :), YY_MPCS(k, :)] = getObjectOutputState(dA, dB,...
            dC, dD, XX_MPCS, xpp, nx, UU_MPCS, upp, nu, ny, InputDelay, k);

        regGPC = regGPC.calculateControl(YY_k_1_GPC, YYzad(k, :));
        UU_GPC(k, :) = regGPC.getControl();
        YY_GPC(k, :) = getObjectOutputEq(A, B, YY_GPC, ypp,...
            UU_GPC, upp, ny, nu, InputDelay, k);
        YY_k_1_GPC = YY_GPC(k, :);
    end

    errorYY_GPC_MPCS = Utilities.calMatrixError(YY_GPC, YY_MPCS);
    errorUU_GPC_MPCS = Utilities.calMatrixError(UU_GPC, UU_MPCS);
    fprintf("Output difference for libmpcalg GPC and MPCS: %s\n",...
        num2str(errorYY_GPC_MPCS));
    fprintf("Control difference for libmpcalg GPC and MPCS: %s\n",...
        num2str(errorUU_GPC_MPCS));

    if isPlotting
        plotRun(YY_GPC, YY_MPCS, UU_GPC, st, ny, nu, 'Comparison of GPC',...
            algType);
    end
end
