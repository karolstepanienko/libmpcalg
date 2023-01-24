function [Yzad, Y, U] = mweSISO_MPCS()
% Adjust this to point to libmpcalg library src folder
addpath('../libmpcalg/src');
init();  % Adding necessary paths

% Object parameters
ny = 1;  % Number of outputs
nu = 1;  % Number of inputs
nx = 2;  % Number of state variables
InputDelay = 0;
OutputDelay = 0;

% Object model
dA = [1.5990, -0.6323; 1, 0];
dB = [0.25; 0];
dC = [0.1434, 0.1231];
dD = 0;

% Regulator parameters
D = 80;  % Dynamic horizon
N = 70;  % Prediction horizon
Nu = 5;  % Moving horizon
mi = ones(1, ny);  % Output importance
lambda = ones(1, nu);  % Control weight
uMin = -2;
uMax = -uMin;
duMin = -1;
duMax = -duMin;
yMin = -1.3;
yMax = -yMin;
algType = 'numerical';  % Numerical algorithm allows the usage of output limits

% Regulator
reg = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD, 'mi', mi, 'lambda', lambda,...
    'uMin', uMin, 'uMax', uMax, 'duMin', duMin, 'duMax', duMax,...
    'yMin', yMin, 'yMax', yMax, 'algType', algType);

% Trajectory
[Yzad, kk] = getY1Trajectory();

% Variable initialisation
ypp = 0; upp = 0; xpp = 0;
X = ones(kk, nx) * xpp;
Y = ones(kk, ny) * ypp;
U = ones(kk, nu) * upp;

% Control loop
for k=1:kk
    U(k, :) = reg.calculateControl(X(k, :), Yzad(k, :));
    [X(k + 1, :), Y(k, :)] = getObjectOutputState(dA, dB, dC, dD, X, xpp, nx,...
        U, upp, nu, ny, InputDelay, OutputDelay, k);
end

% Plotting
plotRun(Y, Yzad, U, 0.1, ny, nu, 'MPCS', algType);

% Control error
err = Utilities.calculateError(Y, Yzad)
end
