%!test(testYzadVecNl(false))


function testYzadVecNl(varargin)
    if size(varargin, 1) == 0 isPlotting = false;
    else isPlotting = varargin{1}; end

    c = Constants();

    % Object
    obj = get2x2Compare();

    [YYzad, kk] = getY2Trajectory(0.2);
    dataMPCNO.ypp = c.testYInitVal; dataMPCNO.upp = c.testUInitVal;
    dataMPCNOTr.ypp = c.testYInitVal; dataMPCNOTr.upp = c.testUInitVal;
    dataMPCNOTrFull.ypp = c.testYInitVal; dataMPCNOTrFull.upp =...
        c.testUInitVal;

    % Regulator
    reg = MPCNO(obj.N, obj.Nu, obj.ny, obj.nu, obj.getOutput, 'mi', obj.mi,...
        'lambda', obj.lambda, 'ypp', dataMPCNO.ypp, 'upp', dataMPCNO.upp,...
        'uMin', obj.uMin, 'uMax', -obj.uMin);

    regTr = MPCNO(obj.N, obj.Nu, obj.ny, obj.nu, obj.getOutput, 'mi', obj.mi,...
        'lambda', obj.lambda, 'ypp', dataMPCNO.ypp, 'upp', dataMPCNO.upp,...
        'uMin', obj.uMin, 'uMax', -obj.uMin);

    regTrFull = MPCNO(obj.N, obj.Nu, obj.ny, obj.nu, obj.getOutput,...
        'mi', obj.mi, 'lambda', obj.lambda, 'ypp', dataMPCNO.ypp,...
        'upp', dataMPCNO.upp, 'uMin', obj.uMin, 'uMax', -obj.uMin);

    % Variable initialisation
    dataMPCNO.data = struct;
    dataMPCNO.YY = ones(kk, obj.ny) * dataMPCNO.ypp;
    dataMPCNO.UU = ones(kk, obj.nu) * dataMPCNO.upp;
    YY_k_1_MPCNO = ones(1, obj.ny) * dataMPCNO.ypp;

    dataMPCNOTr.data = struct;
    dataMPCNOTr.YY = ones(kk, obj.ny) * dataMPCNOTr.ypp;
    dataMPCNOTr.UU = ones(kk, obj.nu) * dataMPCNOTr.upp;
    YY_k_1_MPCNOTr = ones(1, obj.ny) * dataMPCNOTr.ypp;

    dataMPCNOTrFull.data = struct;
    dataMPCNOTrFull.YY = ones(kk, obj.ny) * dataMPCNOTrFull.ypp;
    dataMPCNOTrFull.UU = ones(kk, obj.nu) * dataMPCNOTrFull.upp;
    YY_k_1_MPCNOTrFull = ones(1, obj.ny) * dataMPCNOTrFull.ypp;

    % Control loop
    for k=1:kk
        dataMPCNO.UU(k, :) = reg.calculateControl(YY_k_1_MPCNO, YYzad(k, :));
        dataMPCNO.YY(k, :) = obj.getOutput(dataMPCNO, k);
        YY_k_1_MPCNO = dataMPCNO.YY(k, :);

        if k + 5 <= kk
            trLen = 5;
        else
            trLen = 0;
        end

        dataMPCNOTr.UU(k, :) = regTr.calculateControl(YY_k_1_MPCNOTr,...
            YYzad(k:k + trLen, :));
        dataMPCNOTr.YY(k, :) = obj.getOutput(dataMPCNOTr, k);
        YY_k_1_MPCNOTr = dataMPCNOTr.YY(k, :);

        dataMPCNOTrFull.UU(k, :) = regTrFull.calculateControl(...
            YY_k_1_MPCNOTrFull, YYzad(k:end, :));
        dataMPCNOTrFull.YY(k, :) = obj.getOutput(dataMPCNOTrFull, k);
        YY_k_1_MPCNOTrFull = dataMPCNOTrFull.YY(k, :);
    end

    errMPCNO = Utilities.calculateError(dataMPCNO.YY(k, :), YYzad);
    errMPCNO_Tr = Utilities.calculateError(dataMPCNOTr.YY(k, :), YYzad);
    fprintf('Multi-element Yzad test errMPCNO = %2.4f, errMPCNO_Tr = %2.4f\n',...
        errMPCNO, errMPCNO_Tr);

    errMPCNO_TrFull = Utilities.calculateError(dataMPCNOTrFull.YY(k, :), YYzad);
    fprintf('Multi-element Yzad test errMPCNO = %2.4f, errMPCNO_TrFull = %2.4f\n',...
        errMPCNO, errMPCNO_TrFull);
    assert(errMPCNO > errMPCNO_Tr)
    assert(errMPCNO > errMPCNO_TrFull)
    assert(errMPCNO_Tr > errMPCNO_TrFull)

    if isPlotting
        plotRun(dataMPCNO.YY, YYzad, dataMPCNO.UU, obj.st, obj.ny,...
            obj.nu, 'MPCNO', 'YzadVec NoTr');
        plotRun(dataMPCNOTr.YY, YYzad, dataMPCNOTr.UU, obj.st, obj.ny,...
            obj.nu, 'MPCNO', 'YzadVec Tr');
        plotRun(dataMPCNOTrFull.YY, YYzad, dataMPCNOTrFull.UU, obj.st,...
            obj.ny, obj.nu, 'MPCNO', 'YzadVec TrFull');
    end
end
