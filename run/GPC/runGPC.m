function runGPC()
    load(Utilities.getObjBinFilePath('1x1.mat'));

    %% GPC parameters
    D = 100; % Dynamic horizon
    N = D; % Prediction horizon
    Nu = D; % Moving horizon
    mi = ones(1, ny); % Output importance
    lambda = ones(1, nu); % Control weight
    uMin = -10;
    uMax = -uMin;
    duMin = -0.5;
    duMax = -duMin;
    algType = Constants().analyticalAlgType;

    reg = GPC(D, N, Nu, ny, nu, A, B,...
        'mi', mi, 'lambda', lambda,...
        'uMin', uMin, 'uMax', uMax,...
        'duMin', duMin, 'duMax', duMax,...
        'algType', algType);
end
