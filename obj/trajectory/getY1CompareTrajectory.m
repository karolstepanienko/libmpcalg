function [Yzad, kk, varargout] = getY1CompareTrajectory(varargin)
    if size(varargin, 1) == 0 osf = 1;
    else osf = varargin{1}; end

    % Simulation length
    kk = 50 * osf;
    c = Constants();
    ypp = c.testYInitVal;
    upp = c.testUInitVal;
    xpp = c.testXInitVal;
    varargout{1} = ypp; varargout{2} = upp; varargout{3} = xpp;

    % Space allocation
    Yzad = zeros(kk, 1) + ypp;

    % Trajectory
    Yzad(kk * 0.2 + 1:kk, :) = 1;
end
