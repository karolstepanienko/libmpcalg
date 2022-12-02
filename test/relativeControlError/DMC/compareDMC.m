% Runs DMC relative/comparison tests and DMC lambda0 relative/comparison tests

%!assert(compareDMC(false, 1.0, '1x1', 'analytical') < [40, 40])
%!assert(compareDMC(false, 1.0, '1x1', 'numerical') < [40, 40])
%!assert(compareDMC(false, 0, '1x1', 'analytical') < [130, 130])
%!assert(compareDMC(false, 0, '1x1', 'numerical') < [130, 130])

%!assert(compareDMC(false, 1.0, '1x1RelativeTest', 'analytical') < [135, 135])
%!assert(compareDMC(false, 1.0, '1x1RelativeTest', 'numerical') < [135, 135])
%!assert(compareDMC(false, 0, '1x1RelativeTest', 'analytical') < [30000, 30000])
%!assert(compareDMC(false, 0, '1x1RelativeTest', 'numerical') < [30000, 30000])


function [controlErrRef, controlErrDMC] = compareDMC(isPlotting, lambda,...
    object, algType)
    po = Utilities.prepareObjectStruct(lambda, object, algType);

    %% Reference DMC
    [regRef, YRef, URef] = getReferenceDMC(isPlotting, po);
    controlErrRef = Utilities.calMatrixError(YRef, po.Yzad);

    %% libmpcalg DMC
    [regDMC, YDMC, UDMC] = Utilities.getDMC(isPlotting, po);
    controlErrDMC = Utilities.calMatrixError(YDMC, po.Yzad);
    % Error difference DMC
    errDiffDMC = (controlErrRef - controlErrDMC)^2;
    % Difference between control results DMC
    controlDiffDMC = Utilities.calMatrixError(YRef, YDMC);

    if strcmp(object, '1x1')
        assert(errDiffDMC < Constants.getAllowedNumericLimit);
        assert(controlDiffDMC < Constants.getAllowedNumericLimit);
    else
        assert(errDiffDMC < power(10, -4));
        assert(controlDiffDMC < power(10, -4));
    end

    fprintf('Reference error: %s, DMC error: %s\n',...
        num2str(controlErrRef), num2str(controlErrDMC));
end


%%%%%%%%%%%%%%%%%%%%%%%%%% Reference classDMCa %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [regRef, Y, U] = getReferenceDMC(isPlotting, po)
    %% Reference DMC algorithm
    regRef = classDMCa(po.ny, po.nu);  % DMC 1x1
    regRef.D = po.D;
    regRef.N = po.N;
    regRef.Nu = po.Nu;
    regRef.lambda = po.lambda;;
    regRef.u_start = po.upp;
    regRef.Ysp = po.ypp;
    regRef.settings.limitsOn = 1;
    regRef.settings.type = po.algType;
            regRef.du_min = po.duMin;
            regRef.du_max = -po.duMin;
            regRef.u_min = po.uMin;
            regRef.u_max = -po.uMin;

    S = getS(po.ny, po.nu, Utilities.stepResponseCell2Matrix(po.stepResponse,...
        po.D, po.ny, po.nu));

    regRef.S = S;
    regRef.Ypv = po.ypp;
    regRef.u_k = po.upp;
    regRef.init();

    % Variable initialisation
    X = zeros(po.kk, po.nx);
    Y = zeros(po.kk, po.ny);
    U = zeros(po.kk, po.nu);

    for k=1:po.kk
        regRef.Ysp = po.Yzad(k, :);
        U(k, :) = regRef.calc();
        [X(k + 1, :), Y(k, :)] = getObjectOutputState(po.dA, po.dB, po.dC,...
            po.dD, X, po.xpp, po.nx, U, po.upp, po.nu, po.ny, po.InputDelay, k);
        regRef.Ypv = Y(k, :);
    end

    if isPlotting
        plotRun(Y, po.Yzad, U, po.st, po.ny, po.nu, 'classDMCa',...
            regRef.settings.type);
    end
end

function S = getS(ny, nu, Y)
    S = zeros(ny, nu, size(Y, 1));
    for i=1:ny
        for j=1:nu
            S(i,j,:) = Y(:,i,j);
        end
    end
end
