function runSingleDMC(algType, ny, nu, st, A, B, ypp, upp, Yzad, kk)
    %% DMC parameters
    D = 100; % Dynamic horizon
    N = D; % Prediction horizon
    Nu = D; % Moving horizon
    mi = ones(1, ny); % Output importance
    lambda = ones(1, nu); % Control weight
    uMin = -10;
    uMax = -uMin;
    duMin = -0.5;
    duMax = -duMin;

    % Get D elements of object step response
    stepResponses = getStepResponses(ny, nu, A, B, D);

    %% Variable initialisation
    YY = zeros(kk, ny);
    UU = zeros(kk, nu);

    c = Constants();
    % Regulator
    if strcmp(algType, c.numericalAlgType)
        yMin = -10;
        yMax = -yMin;
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
    plotTitle = Utilities.getPlotTitle('DMC', algType);
    plotTest(YY, Yzad, UU, st, ny, nu, plotTitle);
end
