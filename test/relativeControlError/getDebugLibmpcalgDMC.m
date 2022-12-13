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
    Y_0 = ones(po.kk, po.N * po.ny) * po.ypp;
    U = ones(po.kk, po.nu) * po.upp;

    Y_k = ones(1, po.ny) * po.ypp;
    for k=1:po.kk
        regDMC = regDMC.calculateControl(Y_k, po.Yzad(k, :));
        U(k, :) = regDMC.getControl();
        [X(k + 1, :), Y(k, :)] = getObjectOutputState(po.dA, po.dB,...
            po.dC, po.dD, X, po.xpp, po.nx, U, po.upp, po.nu, po.ny,...
            po.InputDelay, k);
        Y_k = Y(k, :);
        % Debugging
        Y_0(k, :) = regDMC.YY_0;
    end

    % Save debugging variables
    debug.Y_0 = Y_0;

    if isPlotting
        plotRun(Y, po.Yzad, U, po.st, po.ny, po.nu, 'DMC', po.algType);
    end
end
