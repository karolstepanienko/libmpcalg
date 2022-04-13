function testSingleDMC(ny, nu, st, numDen, ypp, upp, Yzad, kk)
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
    stepResponses = getStepResponses(ny, nu, numDen, D);


    %% Variable initialisation
    YY = zeros(kk, ny);
    UU = zeros(kk, nu);

    % Test parameter validation
    % stepResponses = {1; 2}; % inputs
    % stepResponses{nu} = [1,2, 3]; % outputs
    % mi = [1;2];
    % lambda = [1,2];

    % Regulator
    reg = DMC(D, N, Nu, ny, nu, stepResponses,...
        'mi', mi, 'lambda', lambda,...
        'uMin', uMin, 'uMax', uMax,...
        'duMin', duMin, 'duMax', duMax);

    for k=1:kk
        YY(k, :) = getObjectOutput(ny, nu, numDen, YY, UU, ypp, upp, k);
        reg = reg.calculateControl(YY(k,:), Yzad(k,:));
        UU(k, :) = reg.getControl();
    end
    yFig = plotYYseparate(YY, Yzad, st);
    uFig = plotUUseparate(UU, st);
    c = Constants();
    if c.plotWaitSec > 0
        pause(c.plotWaitSec);
        close(yFig);
        close(uFig);
    end
end
