function e = runSingleDMC(D, N, Nu, mi, lambda, uMin, uMax, duMin, duMax,...
    yMin, yMax, algType, ny, nu, st, A, B, ypp, upp, Yzad, kk, isPlotting)

    % Get D elements of object step response
    stepResponses = getStepResponses(ny, nu, A, B, D);

    %% Variable initialisation
    YY = zeros(kk, ny);
    UU = zeros(kk, nu);

    c = Constants();
    % Regulator
    if strcmp(algType, c.numericalAlgType)
        reg = DMC(D, N, Nu, ny, nu, stepResponses,...
            'mi', mi, 'lambda', lambda,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'algType', algType);
    else
        reg = DMC(D, N, Nu, ny, nu, stepResponses,...
            'mi', mi, 'lambda', lambda,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'algType', algType);
    end
    
    for k=1:kk
        YY(k, :) = getObjectOutput(A, B, YY, ypp, UU, upp, ny, nu, k);
        reg = reg.calculateControl(YY(k,:), Yzad(k,:));
        UU(k, :) = reg.getControl();
    end
    if isPlotting
        algName = 'DMC';
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
