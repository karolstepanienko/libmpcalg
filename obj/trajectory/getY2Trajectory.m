function [Yzad, kk, ypp, upp, xpp] = getY2Trajectory(osf)
    % Simulation length
    c = Constants();
    kk = c.testSimulationLength * osf;
    ypp = c.testYInitVal;
    upp = c.testUInitVal;
    xpp = c.testXInitVal;

    % Space allocation
    Yzad = zeros(kk, 2) + ypp;

    % Trajectory
    for i=kk * 0.2 + 1:kk * 0.4; Yzad(i, :) = [0.3 -0.3]; end
    for i=kk * 0.4 + 1:kk * 0.6; Yzad(i, :) = [-0.1 0.1]; end
    for i=kk * 0.6 + 1:kk * 0.8; Yzad(i, :) = [-0.5 0.5]; end
end
