%!assert(lambda0MPCS(false, 0, '1x1', 'analytical') < 8)
%!assert(lambda0MPCS(false, 0, '1x1', 'fast') < 8)
%!assert(lambda0MPCS(false, 0, '1x1', 'numerical') < 8)

%!assert(lambda0MPCS(false, 0, '1x1RelativeTest', 'analytical') < 8)
%!assert(lambda0MPCS(false, 0, '1x1RelativeTest', 'fast') < 8)
%!assert(lambda0MPCS(false, 0, '1x1RelativeTest', 'numerical') < 8)

function controlErrMPCS = lambda0MPCS(isPlotting, lambda, object, algType)
    po = Utilities.prepareObjectStruct(lambda, object, algType);

    %% libmpcalg MPCS
    [regMPCS, YMPCS, UMPCS] = getMPCS(isPlotting, po);
    controlErrMPCS = Utilities.calMatrixError(YMPCS, po.Yzad);

    fprintf('Lambda0 MPCS, (%s), control error: %s\n', object,...
        num2str(controlErrMPCS));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% libmpcalg MPCS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [regMPCS, Y, U] = getMPCS(isPlotting, po)
    % Regulator parameters
    mi = ones(1, po.ny);  % Output importance

    % Regulator
    regMPCS = MPCS(po.N, po.Nu, po.ny, po.nu, po.nx, po.dA, po.dB, po.dC, po.dD,...
        'mi', mi, 'lambda', po.lambda, 'uMin', po.uMin, 'uMax', -po.uMin,...
        'duMin', po.duMin, 'duMax', -po.duMin, 'algType', po.algType);

    % Variable initialisation
    X = zeros(po.kk, po.nx) * po.xpp;
    Y = zeros(po.kk, po.ny) * po.ypp;
    U = zeros(po.kk, po.nu) * po.upp;

    for k=1:po.kk
        regMPCS = regMPCS.calculateControl(X(k, :), po.Yzad(k, :));
        U(k, :) = regMPCS.getControl();
        [X(k + 1, :), Y(k, :)] = getObjectOutputState(po.dA, po.dB, po.dC,...
            po.dD, X, po.xpp, po.nx, U, po.upp, po.nu, po.ny, po.InputDelay, k);
    end

    if isPlotting
        plotRun(Y, po.Yzad, U, po.st, po.ny, po.nu, 'MPCS', po.algType);
    end
end
