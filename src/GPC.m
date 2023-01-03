%% GPC - Generalized Predictive Control
% A, B - object model: discrete differential equations (input and output)
% Allows choosing GPC algorithm type thanks to 'algType' parameter
% Returns an object of proper GPC algorithm
function obj = GPC(N, Nu, ny, nu, A, B, varargin)
    init();  % Adding necessary paths
    c = Constants();  % Constant values

    [algType, varargin] = Utilities.resolveAlgType(c, varargin);

    chosenConstructorFunc = Utilities.chooseAlgorithm(c, c.algGPC, algType);
    obj = chosenConstructorFunc(N, Nu, ny, nu, A, B, varargin{:});
end
