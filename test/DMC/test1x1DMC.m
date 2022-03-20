function test1x1DMC()
    %% Object
    % Setting sampling time -> ../../obj/get2x2.m
    ypp = 0;
    upp = 0;
    fileName = '1x1.mat';
    u = Utilities();
    filePath = u.getObjBinFilePath(fileName);
    load(filePath);

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
    stepResponses = getStepResponses(ny, nu, numDen, D+1);
    
    %% Variable initialisation
    kk = 1000; % Simulation length
    Y = zeros(kk, ny);
    U = zeros(kk, nu);
    % Trajectory
    Yzad = getTrajectory(kk, ny);
    % Regulator
    reg = DMC(D, N, Nu, stepResponses, mi, lambda,...
        uMin, uMax, duMin, duMax);

    for k=1:kk
        Y(k, 1) = getObjectOutput(ny, nu, numDen, Y, U, ypp, upp, k);
        reg = reg.calculateControl(Y(k,1), Yzad(k,1));
        U(k, 1) = reg.getControl();
    end
    plotYYseparate(Y, Yzad, st);
    plotUUseparate(U, st);
end

function Yzad = getTrajectory(kk, ny)
    Yzad = zeros(kk, ny);
    
    Yzad(201:400, :) = 2;
    Yzad(401:600, :) = -1;
    Yzad(601:800, :) = 0.5; 
end
