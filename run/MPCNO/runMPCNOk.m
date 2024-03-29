function err = runMPCNOk(object, varargin)
    if size(varargin, 1) == 0 isPlotting = false;
    else isPlotting = varargin{1}; end

    % Object parameters
    ny = str2num(object(1));  % Number of outputs
    nu = str2num(object(3));  % Number of inputs
    InputDelay = 0;
    osf = 1;  % Object sampling factor

    % Regulator parameters
    N = 4;  % Prediction horizon
    Nu = 2;  % Moving horizon
    mi = ones(ny, 1);  % Output importance
    lambda = ones(nu, 1);  % Control weight
    uMin = -100 * ones(nu, 1);
    uMax = 100 * ones(nu, 1);
    c = Constants();
    duMin = c.defaultMPCNOduMin * ones(nu, 1);
    duMax = c.defaultMPCNOduMax * ones(nu, 1);
    yMin = c.defaultMPCNOyMin * ones(ny, 1);
    yMax = c.defaultMPCNOyMax * ones(ny, 1);
    algType = '';

    % Trajectory
    trajectoryGetterFunc = getTrajectory(object);
    [YYzad, kk, ypp, upp, xpp] = trajectoryGetterFunc(osf);

    % Object
    getOutput = getObjectNlFunc(object);

    initK = 3;

    % Variable initialisation
    YY = ones(kk, ny) * ypp;
    UU = ones(kk, nu) * upp;
    % YY(1, :) = [1, 2];
    % YY(2, :) = [3, 4];

    % UU(1, :) = [1, 2, 3];
    % UU(2, :) = [4, 5, 6];

    % Regulator
    reg = MPCNO(N, Nu, ny, nu, getOutput, 'mi', mi, 'lambda', lambda,...
        'ypp', ypp, 'upp', upp, 'uMin', uMin, 'uMax', uMax,...
        'duMin', duMin, 'duMax', duMax, 'yMin', yMin, 'yMax', yMax,...
        'k', initK, 'YY', YY, 'UU', UU);

    % Control loop
    for k=initK:kk
        UU(k, :) = reg.calculateControl(YY(k - 1, :), YYzad(k, :));
        % Using reg data, reg.k == k
        YY(k, :) = getOutput(reg, k);
    end

    % Plotting
    if isPlotting
        plotRun(YY, YYzad, UU, 1, ny, nu, 'MPCNO', algType);
    end

    % Control error
    err = Utilities.calculateError(YY, YYzad);
end