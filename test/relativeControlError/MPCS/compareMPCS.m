%!assert(compareMPCS(false) < [10^-20, 10^-20])


%% compareMPCS
% Comparison of MPCS algorithms from libmpcalg and JMatlab libraries
function [errorYY_MPCS_JMatlab, errorUU_MPCS_JMatlab] =...
    compareMPCS(varargin)
    if size(varargin, 1) == 0 isPlotting = false;
    else isPlotting = varargin{1}; end

    % Object
    obj = get2x2Compare();

    [YYzad, kk, ypp, upp, xpp] = getY2CompareTrajectory(obj.osf);

    % Regulator MPCS
    algType = 'analytical';
    regMPCS = MPCS(obj.N, obj.Nu, obj.ny, obj.nu, obj.nx, obj.dA, obj.dB,...
        obj.dC, obj.dD, 'mi', obj.mi, 'lambda', obj.lambda,...
        'uMin', obj.uMin, 'uMax', -obj.uMin,...
        'duMin', obj.duMin, 'duMax', -obj.duMin, 'algType', algType);

    XX_MPCS = ones(kk, obj.nx) * xpp;
    YY_MPCS = ones(kk, obj.ny) * ypp;
    UU_MPCS = ones(kk, obj.nu) * upp;

    % MPCS control loop
    for k=1:kk
        UU_MPCS(k, :) = regMPCS.calculateControl(XX_MPCS(k, :), YYzad(k, :));
        [XX_MPCS(k + 1, :), YY_MPCS(k, :)] = getObjectOutputState(...
            obj.dA, obj.dB, obj.dC, obj.dD, XX_MPCS, xpp, obj.nx, UU_MPCS,...
            upp, obj.nu, obj.ny, obj.InputDelay, obj.OutputDelay, k);
    end

    % According to this test both implementations are the same
    MPCSOutputJMatlab;  % Get variables from JMatlab library
    errorYY_MPCS_JMatlab = Utilities.calMatrixError(YY_MPCS, YY_JMatlab);
    errorUU_MPCS_JMatlab = Utilities.calMatrixError(UU_MPCS, UU_JMatlab);
    fprintf("Output difference for JMatlab and libmpcalg MPCS: %s\n",...
        num2str(errorYY_MPCS_JMatlab));
    fprintf("Control difference for JMatlab and libmpcalg MPCS: %s\n",...
        num2str(errorUU_MPCS_JMatlab));

    if isPlotting
        plotRun(YY_MPCS, YY_JMatlab, UU_MPCS, obj.st, obj.ny, obj.nu,...
        'Comparison of MPCS', algType);
    end
end
