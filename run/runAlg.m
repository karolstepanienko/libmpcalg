function e = runAlg(object, alg, algType, varargin)
    %% Load object
    load(Utilities.getObjBinFilePath(Utilities.joinText(object, '.mat')));

    %% Trajectory
    trajectoryGetterFunc = getTrajectory(object);
    [Yzad, kk, ypp, upp] = trajectoryGetterFunc();

    %% Check for plotting being turned off
    if length(varargin) >= 1
        isPlotting = varargin{1};
    else
        isPlotting = true;
    end

    %% Test loop
    if strcmp(func2str(alg), 'DMC') || strcmp(func2str(alg), 'GPC')
        e = runSingleAlg(D, N, Nu, mi, lambda, uMin, uMax, duMin, duMax,...
        yMin, yMax, alg, algType, ny, nu, st, A, B, ypp, upp, Yzad, kk, isPlotting);
    else
        disp(Utilities.joinText('Unknown algorithm : ', func2str(alg)));
    end
end

function e = runSingleAlg(D, N, Nu, mi, lambda, uMin, uMax, duMin, duMax,...
    yMin, yMax, alg, algType, ny, nu, st, A, B, ypp, upp, Yzad, kk, isPlotting)

    % Get D elements of object step response
    stepResponses = getStepResponses(ny, nu, A, B, D);

    %% Variable initialisation
    YY = zeros(kk, ny);
    UU = zeros(kk, nu);

    %% Regulator
    reg = getRegulatorObject(D, N, Nu, ny, nu, stepResponses, A, B, mi,...
    lambda, uMin, uMax, duMin, duMax, yMin, yMax, alg, algType);

    for k=1:kk
        YY(k, :) = getObjectOutput(A, B, YY, ypp, UU, upp, ny, nu, k);
        reg = reg.calculateControl(YY(k,:), Yzad(k,:));
        UU(k, :) = reg.getControl();
    end
    if isPlotting
        algName = func2str(alg);
        plotRun(YY, Yzad, UU, st, ny, nu, algName, algType);
    end
    e = calculateError(YY, Yzad);
end

function e = calculateError(YY, Yzad)
    ny_YY = size(YY, 2);
    ny_Yzad = size(Yzad, 2);
    assert(ny_YY == ny_Yzad)
    ny = ny_YY;

    e = 0;
    for cy = 1:ny
        e = e + (Yzad(:, cy) - YY(:, cy))' * (Yzad(:, cy) - YY(:, cy));
    end
end

function reg = getRegulatorObject(D, N, Nu, ny, nu, stepResponses, A, B, mi,...
    lambda, uMin, uMax, duMin, duMax, yMin, yMax, alg, algType)
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
            reg = alg(D, N, Nu, ny, nu, A, B,...
                'mi', mi, 'lambda', lambda,...
                'uMin', uMin, 'uMax', uMax,...
                'duMin', duMin, 'duMax', duMax,...
                'yMin', yMin, 'yMax', yMax,...
                'algType', algType);
        else
            reg = alg(D, N, Nu, ny, nu, A, B,...
                'mi', mi, 'lambda', lambda,...
                'uMin', uMin, 'uMax', uMax,...
                'duMin', duMin, 'duMax', duMax,...
                'algType', algType);
        end
    end
end
