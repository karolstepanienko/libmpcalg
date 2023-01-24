%!assert(compareMPCNO(false) < [10^-8, 10^-7])


%% compareMPCNO
% Comparison of MPCNO algorithm from libmpcalg library and MPCS algorithm from
% JMatlab library
function [errorYY_MPCNO_JMatlab, errorUU_MPCNO_JMatlab] = compareMPCNO(varargin)
    if size(varargin, 1) == 0 isPlotting = false;
    else isPlotting = varargin{1}; end

    c = Constants();
    % Object
    obj = get2x2Compare();

    [YYzad, kk, dataMPCNO.ypp, dataMPCNO.upp, ~] = getY2CompareTrajectory(obj.osf);

    % Regulator
    reg = MPCNO(obj.N+1, obj.Nu, obj.ny, obj.nu, obj.getOutput, 'mi', obj.mi,...
        'lambda', obj.lambda, 'ypp', dataMPCNO.ypp, 'upp', dataMPCNO.upp,...
        'uMin', obj.uMin, 'uMax', -obj.uMin);

    % Variable initialisation
    dataMPCNO.data = struct;
    dataMPCNO.YY = ones(kk, obj.ny) * dataMPCNO.ypp;
    dataMPCNO.UU = ones(kk, obj.nu) * dataMPCNO.upp;
    YY_k_1_MPCNO = ones(1, obj.ny) * dataMPCNO.ypp;

    % Control loop
    for k=1:kk
        dataMPCNO.UU(k, :) = reg.calculateControl(YY_k_1_MPCNO, YYzad(k, :));
        dataMPCNO.YY(k, :) = obj.getOutput(dataMPCNO, k);
        YY_k_1_MPCNO = dataMPCNO.YY(k, :);
    end

    MPCSOutputJMatlab;  % Get variables from JMatlab library
    errorYY_MPCNO_JMatlab = Utilities.calMatrixError(dataMPCNO.YY, YY_JMatlab);
    errorUU_MPCNO_JMatlab = Utilities.calMatrixError(dataMPCNO.UU, UU_JMatlab);

    fprintf("Output difference for JMatlab MPCS and libmpcalg MPCNO: %s\n",...
        num2str(errorYY_MPCNO_JMatlab));
    fprintf("Control difference for JMatlab MPCS and libmpcalg MPCNO: %s\n",...
        num2str(errorUU_MPCNO_JMatlab));

    assert(errorYY_MPCNO_JMatlab < c.allowedNumericLimit);
    assert(errorUU_MPCNO_JMatlab < c.allowedNumericLimit);

    if isPlotting
        algType = '';
        plotRun(dataMPCNO.YY, YY_JMatlab, dataMPCNO.UU, obj.st, obj.ny,...
        obj.nu, 'Comparison of MPCNO', algType);
    end
end
