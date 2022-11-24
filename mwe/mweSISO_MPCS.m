% Adjust this to point to libmpcalg library src folder
addpath('../libmpcalg/src')

% Object parameters
ny = 1;  % Number of outputs
nu = 1;  % Number of inputs
nx = 2;  % Number of state variables
InputDelay = 0;

% Object model
dA = [1.5990, -0.6323; 1, 0];
dB = [0.25; 0];
dC = [0.1434, 0.1231];
dD = 0;

% Regulator parameters
D = 20;  % Dynamic horizon
N = 8;  % Prediction horizon
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
[Yzad, kk, ypp, upp, xpp] = getY1Trajectory();

% Variable initialisation
X = zeros(kk, nx);
Y = zeros(kk, ny);
U = zeros(kk, nu);

% Control loop
for k=1:kk
    reg = reg.calculateControl(X(k, :), Yzad(k, :));
    U(k, :) = reg.getControl();
    [X(k + 1, :), Y(k, :)] = getObjectOutputState(dA, dB, dC, dD, X, xpp, nx,...
        U, upp, nu, ny, InputDelay, k);
end

% Plotting
plotRun(Y, Yzad, U, 0.1, ny, nu, 'MPCS', algType);

% Control error
err = Utilities.calculateError(Y, Yzad)
