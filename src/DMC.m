%% DMC - Dynamic Matrix Control
% Allows choosing DMC algorithm type thanks to 'algType' parameter
% Returns an object of proper DMC algorithm
function obj = DMC(D, N, Nu, ny, nu, stepResponses, varargin)
    init();  % Adding necessary paths
    c = Constants();  % Constant values

    [algType, varargin] = Utilities.resolveAlgType(c, varargin);

    choosenConstructorFunc = Utilities.chooseAlgorithm(c, c.algDMC, algType);
    obj = choosenConstructorFunc(D, N, Nu, ny, nu, stepResponses,...
        varargin{:});
end
