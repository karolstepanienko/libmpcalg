% Adjust this to point to libmpcalg library src folder
addpath('../libmpcalg/src')

% Object parameters
ny = 2;  % Number of outputs
nu = 2;  % Number of inputs
nx = 4;  % Number of state variables
InputDelay = [0; 0];
osf = 1;  % Object sampling factor

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
mi = ones(1, ny);  % Output importance
lambda = ones(1, nu);  % Control weight
uMin = -2;
uMax = -uMin;
duMin = -0.5;
duMax = -duMin;
algType = 'fast';

% Regulator
reg = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD, 'mi', mi, 'lambda', lambda,...
    'uMin', uMin, 'uMax', uMax, 'duMin', duMin, 'duMax', duMax,...
    'algType', algType);

% Trajectory
[YYzad, kk, ypp, upp, xpp] = getY2Trajectory(osf);

% Variable initialisation
XX = ones(kk, nx) * xpp;
YY = ones(kk, ny) * ypp;
UU = ones(kk, nu) * upp;

% Control loop
for k=1:kk
    UU(k, :) = reg.calculateControl(XX(k, :), YYzad(k, :));
    [XX(k + 1, :), YY(k, :)] = getObjectOutputState(dA, dB, dC, dD, XX, xpp,...
        nx, UU, upp, nu, ny, InputDelay, k);
end

% Plotting
plotRun(YY, YYzad, UU, 0.01, ny, nu, 'MPCS', algType);

% Control error
err = Utilities.calculateError(YY, YYzad)
