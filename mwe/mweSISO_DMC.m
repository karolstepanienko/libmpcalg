% Adjust this to point to libmpcalg library src folder
addpath('../libmpcalg/src')

% Object parameters
ny = 1;  % Number of outputs
nu = 1;  % Number of inputs
InputDelay = 0;

% Object model
stepResponse = {[0; 0.0666; 0.1731; 0.3013; 0.4390; 0.5780; 0.7133; 0.8417; 0.9615; 1.0718; 1.1725; 1.2637; 1.3459; 1.4197; 1.4857; 1.5445; 1.5969; 1.6435; 1.6848; 1.7214]};

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
algType = 'analytical';

% Regulator
reg = DMC(D, N, Nu, ny, nu, stepResponse, 'mi', mi, 'lambda', lambda,...
    'uMin', uMin, 'uMax', uMax, 'duMin', duMin, 'duMax', duMax,...
    'algType', algType);

% Trajectory
[Yzad, kk, ypp, upp, ~] = getY1Trajectory();

% Variable initialisation
Y = zeros(kk, ny);
U = zeros(kk, nu);

% Control loop
for k=1:kk
    Y(k, :) = simulateObjectDMC(ny, nu, InputDelay, Y, ypp, U, upp, k);
    reg = reg.calculateControl(Y(k, :), Yzad(k, :));
    U(k, :) = reg.getControl();
end

% Plotting
plotRun(Y, Yzad, U, 0.1, ny, nu, 'DMC', algType);

% Control error
err = Utilities.calculateError(Y, Yzad)
