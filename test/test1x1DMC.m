function test1x1DMC()
    addpath('../obj');
    addpath('../plot');
    addpath('../src');
    %% Object
    ypp = 0;
    upp = 0;
    st = 0.1; % Sampling time
    controlObj = get1x1(st);
    %% DMC parameters
    D = 50; % Dynamic horizon
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
    U = zeros(kk, controlObj.nu);
    % Trajectory
    Yzad = getTrajectory(kk, controlObj.ny);
    % Regulator
    reg = DMC(D, N, Nu, stepResponses, mi, lambda,...
        uMin, uMax, duMin, duMax);

    for k=1:kk
        Y(k, 1) = controlObj.getOutput(Y, U, ypp, upp, k);
        reg = reg.calculateControl(Y(k,1), Yzad(k,1));
        U(k, 1) = reg.getControl();
    end
    
    plotYYseparate(Y, Yzad, st);
    figure;
    plot(U);
end

function Yzad = getTrajectory(kk, ny)
    Yzad = zeros(kk, ny);
    
    Yzad(201:400, :) = 2;
    Yzad(401:600, :) = -1;
    Yzad(601:800, :) = 0.5; 
end
