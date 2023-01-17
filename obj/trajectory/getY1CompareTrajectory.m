function [Yzad, kk, ypp, upp, xpp] = getY1CompareTrajectory(osf)
    % Simulation length
    kk = 50 * osf;
    c = Constants();
    ypp = c.testYInitVal;
    upp = c.testUInitVal;
    xpp = c.testXInitVal;

    % Space allocation
    Yzad = zeros(kk, 1) + ypp;

    % Trajectory
    Yzad(kk * 0.2 + 1:kk, :) = 1;
end
