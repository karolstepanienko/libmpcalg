function [Yzad, kk, varargout] = getY1Trajectory(osf)
    % Simulation length
    c = Constants();
    kk = c.testSimulationLength * osf;
    ypp = c.testYInitVal;
    upp = c.testUInitVal;
    xpp = c.testXInitVal;
    varargout{1} = ypp; varargout{2} = upp; varargout{3} = xpp;

    % Space allocation
    Yzad = zeros(kk, 1) + ypp;

    % Trajectory
    Yzad(kk * 0.2 + 1:kk * 0.4, :) = 1;
    Yzad(kk * 0.4 + 1:kk * 0.6, :) = -1;
    Yzad(kk * 0.6 + 1:kk * 0.8, :) = 0.5;
end
