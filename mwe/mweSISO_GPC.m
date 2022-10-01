% Adjust this to point to libmpcalg library src folder
addpath('../libmpcalg/src')

% Object parameters
ny = 1;  % Number of outputs
nu = 1;  % Number of inputs

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
D = 20;  % Dynamic horizon
N = 8;  % Prediction horizon
Nu = 5;  % Moving horizon
mi = ones(1, ny);  % Output importance
lambda = ones(1, nu);  % Control weight
uMin = -2;
uMax = -uMin;
duMin = -1;
duMax = -duMin;
algType = 'fast';

% Regulator
reg = GPC(D, N, Nu, ny, nu, A, B, 'mi', mi, 'lambda', lambda, 'uMin', uMin,...
    'uMax', uMax, 'duMin', duMin, 'duMax', duMax, 'algType', algType);

% Trajectory
[Yzad, kk, ypp, upp, ~] = getY1Trajectory();

% Variable initialisation
Y = zeros(kk, ny);
U = zeros(kk, nu);

% Control loop
for k=1:kk
    Y(k, :) = getObjectOutputEq(A, B, Y, ypp, U, upp, ny, nu, k);
    reg = reg.calculateControl(Y(k, :), Yzad(k, :));
    U(k, :) = reg.getControl();
end

% Plotting
plotRun(Y, Yzad, U, 0.1, ny, nu, 'GPC', algType);
