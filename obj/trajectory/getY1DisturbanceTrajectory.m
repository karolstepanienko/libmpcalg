%% getY1DisturbanceTrajectory
% Flat trajectory used in disturbance tests
function [Yzad, kk, varargout] = getY1DisturbanceTrajectory(varargin)
    if size(varargin, 1) == 0 osf = 0.1;
    else osf = varargin{1}; end

    % Simulation length
    c = Constants();
    kk = c.testSimulationLength * osf;
    ypp = c.testYInitVal;
    upp = c.testUInitVal;
    xpp = c.testXInitVal;
    varargout{1} = ypp; varargout{2} = upp; varargout{3} = xpp;

    % Space allocation and trajectory
    Yzad = zeros(kk, 1) + ypp;
end
