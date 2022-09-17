%% MPCS - Model Predictive Control with State-space model
% A, B, C, D - object model: discrete state system of equations
% Allows choosing MPCS algorithm type thanks to 'algType' parameter
% Returns an object of proper MPCS algorithm
function obj = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD, varargin)
    init();  % Adding necessary paths
    c = Constants();  % Constant values

    [algType, varargin] = Utilities.resolveAlgType(c, varargin);

    choosenConstructorFunc = Utilities.chooseAlgorithm(c, c.algMPCS, algType);
    obj = choosenConstructorFunc(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
        varargin{:});
end
