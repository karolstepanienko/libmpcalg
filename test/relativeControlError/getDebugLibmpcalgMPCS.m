function [regMPCS, Y, U, debug] = getDebugLibmpcalgMPCS(isPlotting, po)
    % Regulator parameters
    mi = ones(1, po.ny);  % Output importance

    % Regulator
    regMPCS = MPCS(po.N, po.Nu, po.ny, po.nu, po.nx,...
        po.dA, po.dB, po.dC, po.dD,...
        'mi', mi, 'lambda', po.lambda, 'uMin', po.uMin, 'uMax', -po.uMin,...
        'duMin', po.duMin, 'duMax', -po.duMin, 'algType', po.algType);

    % Variable initialisation
    X = ones(po.kk, po.nx) * po.xpp;
    Y = ones(po.kk, po.ny) * po.ypp;
    Y_0 = ones(po.kk, po.N * po.ny) * po.ypp;
    U = ones(po.kk, po.nu) * po.upp;

    for k=1:po.kk
        regMPCS = regMPCS.calculateControl(X(k, :), po.Yzad(k, :));
        U(k, :) = regMPCS.getControl();
        [X(k + 1, :), Y(k, :)] = getObjectOutputState(po.dA, po.dB, po.dC,...
            po.dD, X, po.xpp, po.nx, U, po.upp, po.nu, po.ny, po.InputDelay, k);
        % Debugging
        Y_0(k, :) = regMPCS.YY_0;
    end

    % Save debugging variables
    debug.Y_0 = Y_0;

    if isPlotting
        plotRun(Y, po.Yzad, U, po.st, po.ny, po.nu, 'MPCS', po.algType);
    end
end