function err = runMPCNO(object, varargin)
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
    [YYzad, kk, data.ypp, data.upp, xpp] = trajectoryGetterFunc(osf);

    % Object
    getOutput = getObjectNlFunc(object);

    % Regulator
    reg = MPCNO(N, Nu, ny, nu, getOutput, 'mi', mi, 'lambda', lambda,...
        'ypp', data.ypp, 'upp', data.upp, 'uMin', uMin, 'uMax', uMax,...
        'duMin', duMin, 'duMax', duMax, 'yMin', yMin, 'yMax', yMax);

    % Variable initialisation
    data.data = struct;
    data.YY = ones(kk, ny) * data.ypp;
    data.UU = ones(kk, nu) * data.upp;
    YY_k_1 = ones(1, ny) * data.ypp;

    % Control loop
    for k=1:kk
        data.UU(k, :) = reg.calculateControl(YY_k_1, YYzad(k, :));
        % Using custom data structure, reg.k ~ k
        data.YY(k, :) = getOutput(data, k);
        YY_k_1 = data.YY(k, :);
    end

    % Plotting
    if isPlotting
        plotRun(data.YY, YYzad, data.UU, 1, ny, nu, 'MPCNO', algType);
    end

    % Control error
    err = Utilities.calculateError(data.YY, YYzad);
end