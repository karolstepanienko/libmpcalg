% Runs step response relative/comparison tests

%!assert(compareDMC(false, 1.0, 'analytical') < [40, 40])
%!assert(compareDMC(false, 1.0, 'numerical') < [40, 40])
%!assert(compareDMC(false, 0.0, 'analytical') < [131, 131])
%!assert(compareDMC(false, 0.0, 'numerical') < [131, 131])


function [controlErrRef, controlErrDMC] = compareDMC(isPlotting, lambda,...
    algType)
    po = prepareObject(lambda, algType);

    % Reference DMC
    [regRef, YDMC, U] = getReferenceDMC(isPlotting, po);
    controlErrRef = Utilities.calMatrixError(YDMC, po.Yzad);

    % libmpcalg DMC
    [regDMC, YRef, U] = getDMC(isPlotting, po);
    controlErrDMC = Utilities.calMatrixError(YRef, po.Yzad);

    % Error difference
    errDiff = (controlErrRef - controlErrDMC)^2;
    assert(errDiff < Constants.getAllowedNumericLimit());

    % Difference between control results
    controlDiff = Utilities.calMatrixError(YDMC, YRef);
    assert(controlDiff < Constants.getAllowedNumericLimit());
    fprintf('Reference error: %s, DMC error: %s\n', num2str(controlErrRef),...
        num2str(controlErrDMC));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% libmpcalg DMC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [regDMC, Y, U] = getDMC(isPlotting, po)
    % Regulator parameters
    D = po.D;  % Dynamic horizon
    N = po.N;  % Prediction horizon
    Nu = po.Nu;  % Moving horizon
    mi = ones(1, po.ny);  % Output importance
    lambda = po.lambda;  % Control weight
    uMin = po.uMin;
    uMax = -uMin;
    duMin = po.duMin;
    duMax = -duMin;
    algType = po.algType;

    % Regulator
    regDMC = DMC(D, N, Nu, po.ny, po.nu, po.stepResponse, 'mi', mi,...
        'lambda', lambda, 'uMin', uMin, 'uMax', uMax, 'duMin', duMin,...
        'duMax', duMax,'algType', algType);

    % Variable initialisation
    X = zeros(po.kk, po.nx);
    Y = zeros(po.kk, po.ny);
    U = zeros(po.kk, po.nu);

    for k=2:po.kk
        regDMC = regDMC.calculateControl(Y(k-1, :), po.Yzad(k-1, :));
        U(k, :) = regDMC.getControl();
        [X(k + 1, :), Y(k, :)] = getObjectOutputState(po.dA, po.dB, po.dC,...
            po.dD, X, po.xpp, po.nx, U, po.upp, po.nu, po.ny, po.InputDelay, k);
    end

    if isPlotting
        plotRun(Y, po.Yzad, U, po.st, po.ny, po.nu, 'DMC', algType);
    end
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
        U(k, :) = regRef.calc();
        [X(k + 1, :), Y(k, :)] = getObjectOutputState(po.dA, po.dB, po.dC,...
            po.dD, X, po.xpp, po.nx, U, po.upp, po.nu, po.ny, po.InputDelay, k);
        regRef.Ypv = Y(k, :);
        regRef.Ysp = po.Yzad(k, :);
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


% Repetitive object work
function po = prepareObject(lambda, algType)
    % Structure (before load)
    po.lambda = lambda;
    po.duMin = -1000;
    po.uMin = -1000;

    % Object
    Utilities.loadPkgControlInOctave();
    Utilities.loadPkgOptimInOctave();
    object = '1x1';
    load(Utilities.getObjBinFilePath(Utilities.joinText(object, '.mat')));
    % Trajectory
    [Yzad, kk, ypp, upp, xpp] = getY1Trajectory();

    % Step response
    stepResponse = getStepResponsesEq(ny, nu, InputDelay, A, B, D);

    % Structure
    po.algType = algType;
    po.Yzad = Yzad;
    po.kk = kk;
    po.st = st;
    po.InputDelay = InputDelay;
    po.ypp = ypp;
    po.upp = upp;
    po.xpp = xpp;
    po.stepResponse = stepResponse;
    po.ny = ny;
    po.nu = nu;
    po.nx = nx;
    po.D = D;
    po.N = N;
    po.Nu = Nu;
    po.A = A;
    po.B = B;
    po.dA = dA;
    po.dB = dB;
    po.dC = dC;
    po.dD = dD;
end
