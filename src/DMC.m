%% DMC
% Allows choosing DMC algorithm type thanks to 'algType' parameter
% Returns an object of proper DMC algorithm
function obj = DMC(D, N, Nu, ny, nu, stepResponses, varargin)
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

    choosenConstructorFunc = chooseAlgorithm(c, algType);
    obj = choosenConstructorFunc(D, N, Nu, ny, nu, stepResponses,...
        varargin{:});
end

function choosenConstructorFunc = chooseAlgorithm(c, algType)
    if strcmp(algType, c.analyticalAlgType)
        choosenConstructorFunc = @AnalyticalDMC;
    elseif strcmp(algType, c.fastAlgType)
        choosenConstructorFunc = @FastDMC;
    elseif strcmp(algType, c.numericalAlgType)
        choosenConstructorFunc = @NumericalDMC;
    end
end
