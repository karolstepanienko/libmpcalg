function [Yzad, kk, ypp, upp, xpp] = getY2Trajectory()
    % Simulation length
    c = Constants();
    kk = c.testSimulationLength;
    ypp = c.testYInitVal;
    upp = c.testUInitVal;
    xpp = c.testXInitVal;

    % Space allocation
    Yzad = zeros(kk, 2) + ypp;

    % Trajectory
    for i=201:400; Yzad(i, :) = [0.3 -0.3]; end
    for i=401:600; Yzad(i, :) = [-0.1 0.1]; end
    for i=601:800; Yzad(i, :) = [-0.5 0.5]; end
end
