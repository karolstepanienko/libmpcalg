function testDMC(ny, nu, st, numDen, ypp, upp, Yzad, kk)
    %% DMC parameters
    D = 100; % Dynamic horizon
    N = D; % Prediction horizon
    Nu = D; % Moving horizon
    mi = ones(1, ny); % Output importance
    lambda = ones(1, nu); % Control weight
    uMin = -10;
    uMax = -uMin;
    duMin = -0.1;
    duMax = -duMin;

    % Get D elements of object step response
    stepResponses = getStepResponses(ny, nu, numDen, D);

    %% Variable initialisation
    YY = zeros(kk, ny);
    UU = zeros(kk, nu);

    % Regulator
    reg = DMC(D, N, Nu, stepResponses, mi, lambda,...
        uMin, uMax, duMin, duMax);

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
