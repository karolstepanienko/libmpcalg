function e = runAlg(object, alg, algType, varargin)
    %% Loads optim package for octave
    Utilities.loadPkgOptimInOctave();
    %% Load object
    load(Utilities.getObjBinFilePath(Utilities.joinText(object, '.mat')));
    c = Constants();

    %% Trajectory
    trajectoryGetterFunc = getTrajectory(object);
    [Yzad, kk, ypp, upp, xpp] = trajectoryGetterFunc(osf);

    %% Check for plotting being turned off
    if length(varargin) >= 1
        isPlotting = varargin{1};
    else
        isPlotting = true;
    end

    %% Test loop
    if strcmp(func2str(alg), c.algDMC)...
        || strcmp(func2str(alg), c.algGPC)...
        || strcmp(func2str(alg), c.algMPCS)
        e = runSingleAlg(D, N, Nu, mi, lambda, uMin, uMax, duMin, duMax,...
        yMin, yMax, alg, algType, ny, nu, InputDelay, nx, st, A, B, dA, dB,...
        dC, dD, xpp, ypp, upp, osf, Yzad, kk, isPlotting, c);
    else
        disp(Utilities.joinText('Unknown algorithm : ', func2str(alg)));
    end
end

function e = runSingleAlg(D, N, Nu, mi, lambda, uMin, uMax, duMin, duMax,...
    yMin, yMax, alg, algType, ny, nu, InputDelay, nx, st, A, B, dA, dB, dC,...
    dD, xpp, ypp, upp, osf, Yzad, kk, isPlotting, c)

    % Get D elements of object step response
    stepResponses = getStepResponsesEq(ny, nu, InputDelay, A, B, D);

    %% Variable initialisation
    XX = ones(kk, nx) * xpp;
    YY = ones(kk, ny) * ypp;
    UU = ones(kk, nu) * upp;
    YY_k_1 = ones(1, ny) * ypp;

    %% Regulator
    reg = getRegulatorObject(D, N, Nu, ny, nu, InputDelay, nx, stepResponses,...
        A, B, dA, dB, dC, dD, mi, lambda, uMin, uMax, duMin, duMax,...
        yMin, yMax, alg, algType);

    % Every k moment a new control value is calculated and multiple object
    % output value simulations can occur in one k, hence division
    for k=1:kk/osf
        % MPCS
        if strcmp(func2str(alg), func2str(@MPCS))
            reg = reg.calculateControl(XX(k*osf + osf - 1, :), Yzad(k*osf, :));
            % Assign control values (row will not be stretched over multiple
            % rows)
            U_k = reg.getControl();
            for cu = 1:nu
                UU(k * osf:(k + 1)* osf - 1, cu) = U_k(cu);
            end
            for k_obj = 0:osf-1
                [XX((k + 1) * osf + k_obj, :), YY(k*osf + k_obj, :)] =...
                    getObjectOutputState(dA, dB, dC, dD, XX, xpp, nx,...
                    UU, upp, nu, ny, InputDelay, k*osf + k_obj);
            end
        % DMC and GPC
        else
            reg = reg.calculateControl(YY_k_1, Yzad(k*osf, :));
            % Assign control values (row will not be stretched over multiple
            % rows)
            U_k = reg.getControl();
            for cu = 1:nu
                UU(k*osf:(k + 1)* osf - 1, cu) = U_k(cu);
            end
            % Object simulation
            for k_obj = 0:osf-1
                YY(k*osf + k_obj, :) = getObjectOutputEq(A, B, YY, ypp,...
                    UU, upp, ny, nu, InputDelay, k*osf + k_obj);
            end
            % Newest measured object value
            YY_k_1 = YY(k*osf + osf - 1, :);
        end
    end
    % Remove trailing output values from step kk
    YY = YY(1:end - (osf - 1), :);

    if isPlotting
        algName = func2str(alg);
        plotRun(YY, Yzad, UU, st, ny, nu, algName, algType);
    end
    e = Utilities.calMatrixError(YY, Yzad);
    disp(Utilities.joinText('Control error for ', func2str(alg),...
        ' algorithm in (ny: ', num2str(ny), ', nu: ', num2str(nu),...
        ') configuration and type ', algType, ': ', num2str(e)));
end

function reg = getRegulatorObject(D, N, Nu, ny, nu, InputDelay, nx, stepResponses, A, B,...
        dA, dB, dC, dD, mi, lambda, uMin, uMax, duMin, duMax, yMin, yMax,...
        alg, algType)
    c = Constants();
    % DMC
    if strcmp(func2str(alg), func2str(@DMC))
        if strcmp(algType, c.numericalAlgType)
            reg = alg(D, N, Nu, ny, nu, stepResponses,...
                'mi', mi, 'lambda', lambda,...
                'uMin', uMin, 'uMax', uMax,...
                'duMin', duMin, 'duMax', duMax,...
                'yMin', yMin, 'yMax', yMax,...
                'algType', algType);
        else
            reg = alg(D, N, Nu, ny, nu, stepResponses,...
                'mi', mi, 'lambda', lambda,...
                'uMin', uMin, 'uMax', uMax,...
                'duMin', duMin, 'duMax', duMax,...
                'algType', algType);
        end
    % GPC
    elseif strcmp(func2str(alg), func2str(@GPC))
        if strcmp(algType, c.numericalAlgType)
            reg = alg(D, N, Nu, ny, nu, InputDelay, A, B,...
                'mi', mi, 'lambda', lambda,...
                'uMin', uMin, 'uMax', uMax,...
                'duMin', duMin, 'duMax', duMax,...
                'yMin', yMin, 'yMax', yMax,...
                'algType', algType);
        else
            reg = alg(D, N, Nu, ny, nu, InputDelay, A, B,...
                'mi', mi, 'lambda', lambda,...
                'uMin', uMin, 'uMax', uMax,...
                'duMin', duMin, 'duMax', duMax,...
                'algType', algType);
        end
    % MPCS
    elseif strcmp(func2str(alg), func2str(@MPCS))
        if strcmp(algType, c.numericalAlgType)
            reg = alg(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
                'mi', mi, 'lambda', lambda,...
                'uMin', uMin, 'uMax', uMax,...
                'duMin', duMin, 'duMax', duMax,...
                'yMin', yMin, 'yMax', yMax,...
                'algType', algType);
        else
            reg = alg(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
                'mi', mi, 'lambda', lambda,...
                'uMin', uMin, 'uMax', uMax,...
                'duMin', duMin, 'duMax', duMax,...
                'algType', algType);
        end
    end
end
