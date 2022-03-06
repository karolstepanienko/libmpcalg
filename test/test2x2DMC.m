function test2x2DMC()
    addpath('../obj');
    addpath('../plot');
    addpath('../src');
    %% Object
    ypp = 0;
    upp = 0;
    st = 0.1; % Sampling time
    controlObj = get2x2(st);
    controlObj.getGz()
    %% DMC parameters
    D = 100; % Dynamic horizon
    N = D; % Prediction horizon
    Nu = D; % Moving horizon
    mi = 1;
    lambda = 1;
    uMin = -2;
    uMax = -uMin;
    duMin = -0.1;
    duMax = -duMin;
    
    % Get D elements of object step response
    stepResponses = controlObj.getStepResponses(D);

    %% Variable initialisation
    kk = 1000; % Simulation length
    YY = zeros(kk, controlObj.ny);
    UU = zeros(kk, controlObj.nu);
    % Trajectory
    Yzad = getTrajectory(kk, controlObj.ny);
    % Regulator
    reg = DMC(D, N, Nu, stepResponses, mi, lambda,...
        uMin, uMax, duMin, duMax);

    for k=1:kk
        YY(k, :) = controlObj.getOutput(YY, UU, ypp, upp, k);
        reg = reg.calculateControl(YY(k,:), Yzad(k,:));
        UU(k, :) = reg.getControl();
    end
    plotYYseparate(YY, Yzad, st);
    plotUUseparate(UU, st);
end

function Yzad = getTrajectory(kk, ny)
    Yzad = zeros(kk, ny);
    for i=201:400; Yzad(i, :) = [3 -0.4]; end
    for i=401:600; Yzad(i, :) = [-0.07 2]; end
    for i=601:800; Yzad(i, :) = 0; end
end
