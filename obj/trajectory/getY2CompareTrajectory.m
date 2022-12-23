%% getY2CompareTrajectory
% Trajectory used in algorithm comparisons
function [YYzad, kk, ypp, upp, xpp] = getY2CompareTrajectory(osf)
    c = Constants();
    % Trajectory in JMatlab starts from 1 and first index is at 0, hence
    % trajectory has 49 elements
    kk = 49 * osf;
    ypp = c.testYInitVal;
    upp = c.testUInitVal;
    xpp = c.testXInitVal;
    % Trajectory
    YYzad = [ones(kk, 1) * 13, ones(kk, 1) * 15];
end
