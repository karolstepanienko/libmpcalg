addpath('../libmpcalg/src');
init();  % Adding necessary paths

% Object parameters
ny = 2;  % Number of outputs
nu = 3;  % Number of inputs
InputDelay = zeros(nu, 1);
osf = 1;  % Object sampling factor

% Object model: nonlinear difference equation
% y_1(k) = - 0.25y_1(k-1) - 0.01y_2(k-1)
%          + 0.12(u_1(k-1))^3 - 0.15u_2(k-1) + 0.7u_3(k-3)
% y_2(k) = - 0.02y_1(k-1) - 0.25y_2(k-1)
%          - 0.25u_1(k-1) + 0.08(u_2(k-1))^3 + 0.5u_3(k-3)
%
% Regulator parameters
N = 4;  % Prediction horizon
Nu = 2;  % Moving horizon
lambda = ones(1, nu);  % Control weight

% Trajectory
[YYzad, kk, ypp, upp, xpp] = getY2Trajectory(osf);;

% Variable initialisation
YY = ones(kk, ny) * ypp;
UU = ones(kk, nu) * upp;

% Regulator
reg = MPCNO(N, Nu, ny, nu, @getObjectOutputNl2x3,...
    'lambda', lambda, 'ypp', ypp, 'upp', upp,...
    'uMin', -2, 'uMax', 2, 'duMin', -0.2, 'duMax', 0.2,...
    'yMin', -0.5, 'yMax', 0.5, 'k', 3,...
    'YY', YY, 'UU', UU);

% Control loop
for k=initK:kk
    UU(k, :) = reg.calculateControl(YY(k - 1, :),...
        YYzad(k, :));
    % Using reg data, reg.k == k
    YY(k, :) = getObjectOutputNl2x3(reg, k);
end

% Plotting
plotRun(YY, YYzad, UU, 1, ny, nu, 'MPCNO');

% Control error
err = Utilities.calculateError(YY, YYzad)
