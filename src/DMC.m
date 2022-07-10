%% DMC - Dynamic Matrix Control
% Allows choosing DMC algorithm type thanks to 'algType' parameter
% Returns an object of proper DMC algorithm
function obj = DMC(D, N, Nu, ny, nu, stepResponses, varargin)
    init();  % Adding necessary paths
    v = Validation();  % Validation object with data validation functions
    c = Constants();  % Constant values

    algTypeName = 'algType';

    algType = Utilities.extractFromVarargin(algTypeName, varargin);
    if strcmp(algType, '') ~= 1
        v.validAlgType(algType);  % Validate algorithm type
    else
        algType = c.analyticalAlgType;
        varargin = Utilities.replaceInVarargin(algTypeName, algType, varargin);
    end

    choosenConstructorFunc = Utilities.chooseAlgorithm(c, algType);
    obj = choosenConstructorFunc(D, N, Nu, ny, nu, stepResponses,...
        varargin{:});
end
