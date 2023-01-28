%% getU1DisturbanceControl
% Control trajectory for disturbance
function [UU, kk] = getU1DisturbanceControl(varargin)
    if size(varargin, 1) == 0 osf = 0.1;
    else osf = varargin{1}; end

    c = Constants();
    kk = c.testSimulationLength * osf;
    UU = zeros(kk, 1);
    UU(0.1*kk:kk, 1) = 1;
end
