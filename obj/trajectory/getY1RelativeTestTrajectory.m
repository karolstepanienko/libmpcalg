function [Yzad, kk, ypp, upp, xpp] = getY1RelativeTestTrajectory(osf)
    % Simulation length
    c = Constants();
    kk = 4000 * osf;
    ypp = c.testYInitVal;
    upp = c.testUInitVal;
    xpp = c.testXInitVal;

    % Space allocation
    Yzad = zeros(kk, 1) + ypp;

    % Trajectory
    Yzad(kk * 0.2 + 1:kk * 0.4, :) = 1;
    Yzad(kk * 0.4 + 1:kk * 0.6, :) = -1;
    Yzad(kk * 0.6 + 1:kk * 0.8, :) = 0.5;
end