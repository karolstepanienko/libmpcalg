%!assert(compareMPCNO(false) < [10^-8, 10^-7])


%% compareMPCNO
% Comparison of MPCNO algorithm from libmpcalg library and MPCS algorithm from
% JMatlab library
function [errorYY_MPCNO_JMatlab, errorUU_MPCNO_JMatlab] = compareMPCNO(varargin)
    if size(varargin, 1) == 0 isPlotting = false;
    else isPlotting = varargin{1}; end

    % Object
    obj = get2x2Compare();

    [YYzad, kk, ypp, upp, ~] = getY2CompareTrajectory(obj.osf);

    % Regulator
    reg = MPCNO(obj.N+1, obj.Nu, obj.ny, obj.nu, obj.getOutput, 'lambda', obj.lambda,...
        'ypp', ypp, 'upp', upp, 'uMin', obj.uMin, 'uMax', -obj.uMin);

    % Variable initialisation
    YY_MPCNO = ones(kk, obj.ny) * ypp;
    UU_MPCNO = ones(kk, obj.nu) * upp;
    YY_k_1_MPCNO = ones(1, obj.ny) * ypp;

    % Control loop
    for k=1:kk
        reg = reg.calculateControl(YY_k_1_MPCNO, YYzad(k, :));
        UU_MPCNO(k, :) = reg.getControl();
        YY_MPCNO(k, :) = obj.getOutput(ypp, YY_MPCNO, upp, UU_MPCNO, k);
        YY_k_1_MPCNO = YY_MPCNO(k, :);
    end

    MPCSOutputJMatlab;  % Get variables from JMatlab library
    errorYY_MPCNO_JMatlab = Utilities.calMatrixError(YY_MPCNO, YY_JMatlab);
    errorUU_MPCNO_JMatlab = Utilities.calMatrixError(UU_MPCNO, UU_JMatlab);

    fprintf("Output difference for JMatlab MPCS and libmpcalg MPCNO: %s\n",...
        num2str(errorYY_MPCNO_JMatlab));
    fprintf("Control difference for JMatlab MPCS and libmpcalg MPCNO: %s\n",...
        num2str(errorUU_MPCNO_JMatlab));

    assert(errorYY_MPCNO_JMatlab < Constants.getAllowedNumericLimit());
    assert(errorUU_MPCNO_JMatlab < Constants.getAllowedNumericLimit());

    if isPlotting
        algType = '';
        plotRun(YY_MPCNO, YY_JMatlab, UU_MPCNO, obj.st, obj.ny, obj.nu,...
        'Comparison of MPCNO', algType);
    end
end
