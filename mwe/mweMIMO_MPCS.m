function [YYzad, YY, UU] = mweMIMO_MPCS()
% Adjust this to point to libmpcalg library src folder
addpath('../libmpcalg/src');
init();  % Adding necessary paths

% Object parameters
ny = 2;  % Number of outputs
nu = 2;  % Number of inputs
nx = 4;  % Number of state variables
InputDelay = zeros(nu, 1);
OutputDelay = zeros(nu, 1);

% Object model
dA = [0.9048, 0, 0, 0;
      0, 0.9672, 0, 0;
      0, 0, 0.9512, 0;
      0, 0, 0, 0.9753];
dB = [ 0.2500, 0;
       0.2500,0;
       0, 0.2500
       0, 0.2500];
dC = [0.3807, 0, 0.3902, 0;
      0, 0.3934, 0, 0.3950];
dD = zeros(ny, nu);

% Regulator parameters
D = 200;  % Dynamic horizon
N = 100;  % Prediction horizon
Nu = 8;  % Moving horizon
mi = ones(ny, 1);  % Output importance
lambda = ones(nu, 1);  % Control weight
algType = 'numerical';

% Regulator
reg = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD, 'mi', mi,...
    'lambda', lambda,...
    'uMin', -2 * ones(nu, 1), 'uMax', 2 * ones(nu, 1),...
    'duMin', -0.5 * ones(nu, 1), 'duMax', 0.5 * ones(nu, 1),...
    'yMin', -0.5 * ones(ny, 1), 'yMax', 0.5 * ones(ny, 1),...
    'algType', algType);

% Trajectory
[YYzad, kk] = getY2Trajectory();

% Variable initialisation
ypp = 0; upp = 0; xpp = 0;
XX = ones(kk, nx) * xpp;
YY = ones(kk, ny) * ypp;
UU = ones(kk, nu) * upp;
YY_k_1 = ones(1, ny) * ypp;

% Control loop
for k=1:kk
    UU(k, :) = reg.calculateControl(XX(k, :),...
        YY_k_1, YYzad(k:end, :));
    [XX(k + 1, :), YY(k, :)] = getObjectOutputState(...
        dA, dB, dC, dD, XX, xpp, nx, UU, upp,...
        nu, ny, InputDelay, OutputDelay, k);
    YY_k_1 = YY(k, :);
end

% Plotting
plotRun(YY, YYzad, UU, 0.1, ny, nu, 'MPCS', algType);

% Control error
err = Utilities.calculateError(YY, YYzad)
end