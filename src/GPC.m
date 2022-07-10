%% GPC - Generalized Predictive Control

% A (ny, ny) cell containing nA sized vectors describing relation
% between output value(s) and past output value(s)

% B (nu, nu) cell containing nB sized vectors describing relation
% between current control value(s) and past control value(s)

function obj = GPC(D, N, Nu, ny, nu, A, B, varargin)
    init();  % Adding necessary paths
    kk = D;
    stepResponses = getStepResponses(ny, nu, A, B, kk);
    obj = DMC(D, N, Nu, ny, nu, stepResponses, varargin{:});
end
