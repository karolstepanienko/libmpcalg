function test1x2DMC()
    addpath('../obj');
    addpath('../plot');
    addpath('../src');
    %% Object
    ypp = 0;
    upp = 0;
    st = 0.1; % Sampling time
    controlObj = get1x2(st);
    %% DMC parameters
    D = 100; % Dynamic horizon
    N = D; % Prediction horizon
    Nu = D; % Moving horizon
    mi = 1;
    lambda = 1;
    uMin = -2;
    uMax = -uMin;
    duMin = -0.5;
    duMax = -duMin;
    
    % Get D elements of object step response
    stepResponses = controlObj.getStepResponses(D);

    %% Variable initialisation
    kk = 1000; % Simulation length
    Y = zeros(kk, controlObj.ny);
    UU = zeros(kk, controlObj.nu);
    % Trajectory
    Yzad = getTrajectory(kk, controlObj.ny);
    % Regulator
    reg = DMC(D, N, Nu, stepResponses, mi, lambda,...
        uMin, uMax, duMin, duMax);

    for k=1:kk
        Y(k, 1) = controlObj.getOutput(Y, UU, ypp, upp, k);
        reg = reg.calculateControl(Y(k,1), Yzad(k,1));
        UU(k, :) = reg.getControl();
    end
    plotYYseparate(Y, Yzad, st);
    plotUUseparate(UU, st);
end

function Yzad = getTrajectory(kk, ny)
    Yzad = zeros(kk, ny);
    Yzad(201:400, :) = -1;
    Yzad(401:600, :) = 0;
    Yzad(601:800, :) = 0; 
end
