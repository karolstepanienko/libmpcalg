function [regDMC, Y, U, debug] = getDebugLibmpcalgDMC(isPlotting, po)
    % Regulator parameters
    mi = ones(1, po.ny);  % Output importance

    % Regulator
    regDMC = DMC(po.D, po.N, po.Nu, po.ny, po.nu, po.stepResponse,...
        'mi', mi, 'lambda', po.lambda,...
        'uMin', po.uMin, 'uMax', -po.uMin,...
        'duMin', po.duMin, 'duMax', -po.duMin,'algType', po.algType);

    % Variable initialisation
    X = ones(po.kk, po.nx) * po.xpp;
    Y = ones(po.kk, po.ny) * po.ypp;
    U = ones(po.kk, po.nu) * po.upp;
    Y_k_1 = ones(1, po.ny) * po.ypp;

    for k=1:po.kk
        U(k, :) = regDMC.calculateControl(Y_k_1, po.Yzad(k, :));
        [X(k + 1, :), Y(k, :)] = getObjectOutputState(po.dA, po.dB,...
            po.dC, po.dD, X, po.xpp, po.nx, U, po.upp, po.nu, po.ny,...
            po.InputDelay, po.OutputDelay, k);
        Y_k_1 = Y(k, :);
    end

    if isPlotting
        plotRun(Y, po.Yzad, U, po.st, po.ny, po.nu, 'DMC', po.algType);
    end
end
