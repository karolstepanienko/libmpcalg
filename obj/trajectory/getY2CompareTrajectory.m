%% getY2CompareTrajectory
% Trajectory used in algorithm comparisons
function [YYzad, kk, varargout] = getY2CompareTrajectory(varargin)
    if size(varargin, 1) == 0 osf = 1;
    else osf = varargin{1}; end

    c = Constants();
    % Trajectory in JMatlab starts from 1 and first index is at 0, hence
    % trajectory has 49 elements
    kk = 49 * osf;
    ypp = c.testYInitVal;
    upp = c.testUInitVal;
    xpp = c.testXInitVal;
    varargout{1} = ypp; varargout{2} = upp; varargout{3} = xpp;

    % Trajectory
    YYzad = [ones(kk, 1) * 13, ones(kk, 1) * 15];
end
