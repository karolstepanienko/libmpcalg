function [Yzad, Y, U] = mweSISO_GPC()
% Adjust this to point to libmpcalg library src folder
addpath('../libmpcalg/src');
init();  % Adding necessary paths

% Object parameters
ny = 1;  % Number of outputs
nu = 1;  % Number of inputs
IODelay = zeros(ny, nu);  % Input-Output delay

% Object model: difference equation
%
% Discrete transmittance:
%             0.0358 z + 0.0308      Y(z)
% G(z) = ------------------------- = ----
%         z^2 - 1.5990 z + 0.6323    U(z)
% Which gives a difference equation:
A = {[1, -1.5990, 0.6323]};
B = {[0, 0.0358, 0.0308]};

% Regulator parameters
D = 80;  % Dynamic horizon
N = 70;  % Prediction horizon
Nu = 5;  % Moving horizon
InputDelay = zeros(1, nu);
mi = ones(1, ny);  % Output importance
lambda = ones(1, nu);  % Control weight
uMin = -2;
uMax = -uMin;
duMin = -1;
duMax = -duMin;
algType = 'fast';

% Regulator
reg = GPC(N, Nu, ny, nu, A, B, 'IODelay', IODelay, 'mi', mi, 'lambda', lambda, 'uMin', uMin,...
    'uMax', uMax, 'duMin', duMin, 'duMax', duMax, 'algType', algType);

% Trajectory
[Yzad, kk] = getY1Trajectory();

% Variable initialisation
ypp = 0; upp = 0;
Y = ones(kk, ny) * ypp;
U = ones(kk, nu) * ypp;
Y_k_1 = ones(1, ny) * ypp;

% Control loop
for k=1:kk
    U(k, :) = reg.calculateControl(Y_k_1, Yzad(k, :));
    Y(k, :) = getObjectOutputEq(A, B, Y, ypp, U, upp, ny, nu, IODelay, k);
    Y_k_1 = Y(k, :);
end

% Plotting
plotRun(Y, Yzad, U, 0.1, ny, nu, 'GPC', algType);

% Control error
err = Utilities.calculateError(Y, Yzad)
end
