%!assert(compareGPC('1x1Unstable', false) < [10^-19, 10^-19])
%!assert(compareGPC('2x3', false) < [10^-20, 10^-20])


%% compareGPC
% Comparison of GPC and MPCS algorithms from libmpcalg library
function [errorYY_GPC_MPCS, errorUU_GPC_MPCS] = compareGPC(object, varargin)
    if size(varargin, 1) == 0 isPlotting = false;
    else isPlotting = varargin{1}; end

    % Object
    load(Utilities.getObjBinFilePath(Utilities.joinText(object, '.mat')));
    trajectoryGetterFunc = getTrajectory(object);
    [YYzad, kk, ypp, upp, xpp] = trajectoryGetterFunc(osf);

    % Regulator GPC
    algType = 'analytical';

    regMPCS = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
        'uMin', uMin, 'uMax', uMax, 'duMin', duMin, 'duMax', duMax,...
        'mi', mi, 'lambda', lambda, 'algType', algType);

    regGPC = AnalyticalGPC(N, Nu, ny, nu, A, B, 'mi', mi,...
        'lambda', lambda, 'IODelay', IODelay,...
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
        UU_MPCS(k, :) = regMPCS.calculateControl(XX_MPCS(k, :), YYzad(k, :));
        [XX_MPCS(k + 1, :), YY_MPCS(k, :)] = getObjectOutputState(dA, dB,...
            dC, dD, XX_MPCS, xpp, nx, UU_MPCS, upp, nu, ny, InputDelay,...
            OutputDelay, k);

        UU_GPC(k, :) = regGPC.calculateControl(YY_k_1_GPC, YYzad(k, :));
        YY_GPC(k, :) = getObjectOutputEq(A, B, YY_GPC, ypp,...
            UU_GPC, upp, ny, nu, IODelay, k);
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
