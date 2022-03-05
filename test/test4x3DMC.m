function test4x3DMC()
    addpath('../src');
    addpath('../plot');
    addpath('../obj');
    %% Object step responses
    load('./stepResponse/3x4StepResponses.mat', 'stepResponses');
    nu = size(stepResponses, 1);
    ny = size(stepResponses{1, 1}, 2);
    st = 0.5; % 0.5 second sampling time
    
    %% DMC parameters
    D = 50; % Dynamic horizon
    N = D; % Prediction horizon
    Nu = D; % Moving horizon
    mi = ones(ny, 1); % Output importance
    lambda = ones(nu, 1); % Control weight
    
    %% Variable initialisation
    kk = 1000; % Simulation length
    YY = zeros(kk, ny);
    UU = zeros(kk, nu);
    % Trajectory
    [YYzad, kk]= getTrajectory4x3();
    % Regulator
    reg = DMC(D, N, Nu, stepResponses, mi, lambda);
    
    for k=1:kk        
        %% Prepare control and output signals
        [u1_k_1, u1_k_2, u1_k_3, u1_k_4,...
        u2_k_1, u2_k_2, u2_k_3, u2_k_4,...   
        u3_k_1, u3_k_2, u3_k_3, u3_k_4,...   
        u4_k_1, u4_k_2, u4_k_3, u4_k_4,...
        y1_k_1, y1_k_2, y1_k_3, y1_k_4,...
        y2_k_1, y2_k_2, y2_k_3, y2_k_4,...
        y3_k_1, y3_k_2, y3_k_3, y3_k_4] = ...
            assign_values_after_offset(YY, UU, k);

        % Object simulation
        YY(k, :) = obj4x3(...
            u1_k_1, u1_k_2, u1_k_3, u1_k_4,...
            u2_k_1, u2_k_2, u2_k_3, u2_k_4,...   
            u3_k_1, u3_k_2, u3_k_3, u3_k_4,...   
            u4_k_1, u4_k_2, u4_k_3, u4_k_4,...
            y1_k_1, y1_k_2, y1_k_3, y1_k_4,...
            y2_k_1, y2_k_2, y2_k_3, y2_k_4,...
            y3_k_1, y3_k_2, y3_k_3, y3_k_4);
        
        reg = reg.calculateControl(YY(k, :), YYzad(k, :));
        UU(k, :) = reg.getControl();
    end
    %% Plot results
    plotYYseparate(YY, YYzad, st);
    plotUUseparate(UU, st);
end

function [YYTrajectoryMatrix, kk]= getTrajectory4x3()
    ypp = 0;
    % Trajectory length
    kk = 1200;
    % Initialisation of trajecotry matrix
    YYTrajectoryMatrix = zeros(kk, 3) + ypp;
    %% Y1 = Y2 = Y3 trajectory
    YYTrajectoryMatrix(1:100, :) = ypp;
    YYTrajectoryMatrix(100:300, :) = 0.1;
    YYTrajectoryMatrix(300:500, :) = -1;
    YYTrajectoryMatrix(500:700, :) = -0.8;
    YYTrajectoryMatrix(700:900, :) = 1;
    YYTrajectoryMatrix(900:1100, :) = 0.5;
    YYTrajectoryMatrix(1100:kk, :) = ypp;
end

%% assign_values_after_offset
% Returns values required by process simulating function
% Assigns op point values where index would exceed array bounds
function [u1_k_1, u1_k_2, u1_k_3, u1_k_4,...
    u2_k_1, u2_k_2, u2_k_3, u2_k_4,...   
    u3_k_1, u3_k_2, u3_k_3, u3_k_4,...   
    u4_k_1, u4_k_2, u4_k_3, u4_k_4,...
    y1_k_1, y1_k_2, y1_k_3, y1_k_4,...
    y2_k_1, y2_k_2, y2_k_3, y2_k_4,...
    y3_k_1, y3_k_2, y3_k_3, y3_k_4] = assign_values_after_offset(Y, U, k)
    
    %% Operating point initialisation
    upp = 0;
    ypp = 0;

    if k == 1
        u1_k_1 = upp; u2_k_1 = upp; u3_k_1 = upp; u4_k_1 = upp;
        y1_k_1 = ypp; y2_k_1 = ypp; y3_k_1 = ypp;
    else
        u1_k_1 = U(k-1,1); u2_k_1 = U(k-1,2); u3_k_1 = U(k-1,3); u4_k_1 = U(k-1,4);
        y1_k_1 = Y(k-1,1); y2_k_1 = Y(k-1,2); y3_k_1 = Y(k-1,3);
    end

    if k <= 2
        u1_k_2 = upp; u2_k_2 = upp; u3_k_2 = upp; u4_k_2 = upp;
        y1_k_2 = ypp; y2_k_2 = ypp; y3_k_2 = ypp;
    else
        u1_k_2 = U(k-2,1); u2_k_2 = U(k-2,2); u3_k_2 = U(k-2,3); u4_k_2 = U(k-2,4);
        y1_k_2 = Y(k-2,1); y2_k_2 = Y(k-2,2); y3_k_2 = Y(k-2,3);
    end

    if k <= 3
        u1_k_3 = upp; u2_k_3 = upp; u3_k_3 = upp; u4_k_3 = upp;
        y1_k_3 = ypp; y2_k_3 = ypp; y3_k_3 = ypp;
    else
        u1_k_3 = U(k-3,1); u2_k_3 = U(k-3,2); u3_k_3 = U(k-3,3); u4_k_3 = U(k-3,4);
        y1_k_3 = Y(k-3,1); y2_k_3 = Y(k-3,2); y3_k_3 = Y(k-3,3);
    end

    if k <= 4
        u1_k_4 = upp; u2_k_4 = upp; u3_k_4 = upp; u4_k_4 = upp;
        y1_k_4 = ypp; y2_k_4 = ypp; y3_k_4 = ypp;
    else
        u1_k_4 = U(k-4,1); u2_k_4 = U(k-4,2); u3_k_4 = U(k-4,3); u4_k_4 = U(k-4,4);
        y1_k_4 = Y(k-4,1); y2_k_4 = Y(k-4,2); y3_k_4 = Y(k-4,3);
    end
end
