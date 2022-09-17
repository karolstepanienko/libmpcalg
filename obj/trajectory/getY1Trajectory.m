function [Yzad, kk, ypp, upp, xpp] = getY1Trajectory()
    % Simulation length
    c = Constants();
    kk = c.testSimulationLength;
    ypp = c.testYInitVal;
    upp = c.testUInitVal;
    xpp = c.testXInitVal;

    % Space allocation
    Yzad = zeros(kk, 1) + ypp;

    % Trajectory
    Yzad(201:400, :) = 1;
    Yzad(401:600, :) = -1;
    Yzad(601:800, :) = 0.5; 
end
