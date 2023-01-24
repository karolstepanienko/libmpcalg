function [YYzad, YY, UU] = mweMIMO_GPC()
% Adjust this to point to libmpcalg library src folder
addpath('../libmpcalg/src');
init();  % Adding necessary paths

% Object parameters
ny = 2;  % Number of outputs
nu = 2;  % Number of inputs
IODelay = zeros(ny, nu);  % Input-Output delay

%% Object model: difference equation
%
% Continuous-time transmittance Gs(ny x nu)(s):
%                  1       Y1
% Gs(1x1)(s) = -------- = ----,
%                s + 1     U1
%
%                  2       Y1
% Gs(1x2)(s) = -------- = ----,
%               2s + 1     U2
%
%                  3       Y2
% Gs(2x1)(s) = -------- = ----,
%               3s + 1     U1
%
%                  4       Y2
% Gs(2x2)(s) = -------- = ----.
%               4s + 1     U2
%
% Sampling time = 0.1.
% Discrete-time transmittance Gz(ny x nu)(z):
%             0.09516       Y1
% Gz(1x1)(z) = ------------ = ----,
%            z - 0.9048     U1
%
%             0.09754       Y1
% Gz(1x2)(z) = ------------ = ----,
%            z - 0.9512     U2
%
%             0.09835       Y2
% Gz(2x1)(z) = ------------ = ----,
%            z - 0.9672     U1
%
%             0.09876       Y2
% Gz(2x2)(z) = ------------ = ----.
%            z - 0.9753     U2
%
% Bring to a common denominator:
%       U1( 0.0952z - 0.0905 ) + U2( 0.0975z - 0.0883 )
% Y1 = -----------------------------------------------------,
%                   z^2 - 1.8561 + 0.8607
%       U1( 0.0984z - 0.0959) + U2( 0.0988z - 0.0955 )
% Y2 = -----------------------------------------------------,
%                   z^2 - 1.9425 + 0.9433
%
% Which gives a difference equation:
A = { [1, -1.8561, 0.8607],[0, 0, 0];
    [0, 0, 0], [1, -1.9425, 0.9433] };
B = { [0, 0.0952, -0.0905], [0, 0.0975, -0.0883];
    [0, 0.0984, -0.0959], [0, 0.0988, -0.0955] };

% Regulator parameters
D = 200;  % Dynamic horizon
N = 100;  % Prediction horizon
Nu = 8;  % Moving horizon
mi = ones(1, ny);  % Output importance
lambda = ones(1, nu);  % Control weight
algType = 'fast';

% Regulator
reg = GPC(N, Nu, ny, nu, A, B, 'IODelay', IODelay,...
    'mi', mi, 'lambda', lambda, 'uMin', -2,'uMax', 2,...
    'duMin', -0.5, 'duMax', 0.5, 'algType', algType);

% Trajectory
[YYzad, kk] = getY2Trajectory();

% Variable initialisation
ypp = 0; upp = 0;
YY = ones(kk, ny) * ypp;
UU = ones(kk, nu) * upp;
YY_k_1 = ones(1, ny) * ypp;

% Control loop
for k=1:kk
    UU(k, :) = reg.calculateControl(YY_k_1, YYzad(k, :));
    YY(k, :) = getObjectOutputEq(A, B, YY, ypp, UU, upp,...
        ny, nu, reg.IODelay, k);
    YY_k_1 = YY(k, :);
end

% Plotting
plotRun(YY, YYzad, UU, 0.1, ny, nu, 'GPC', algType);

% Control error
err = Utilities.calculateError(YY, YYzad)
end
