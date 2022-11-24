% Adjust this to point to libmpcalg library src folder
addpath('../libmpcalg/src')

% Object parameters
ny = 2;  % Number of outputs
nu = 2;  % Number of inputs
InputDelay = [1; 1];

% Object model: difference equation
%
% Discrete transmittance:
%             0.09516       Y1                0.09754       Y1
% G1x1(z) = ------------ = ----,  G1x2(z) = ------------ = ----,
%            z - 0.9048     U1               z - 0.9512     U2
%
%             0.09835       Y2                0.09876       Y2
% G2x1(z) = ------------ = ----,  G2x2(z) = ------------ = ----,
%            z - 0.9672     U1               z - 0.9753     U2
% 
% Bring to a common denominator:
%       U1( 0.0952z - 0.0905 ) + U2( 0.0975z - 0.0883 )
% Y1 = -----------------------------------------------------,
%                   z^2 - 1.8561 + 0.8607
%       U1( 0.09835z - 0.0959) + U2( 0.0988z - 0.0955 )
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
uMin = -2;
uMax = -uMin;
duMin = -0.5;
duMax = -duMin;
algType = 'fast';

% Regulator
reg = GPC(D, N, Nu, ny, nu, InputDelay, A, B, 'mi', mi, 'lambda', lambda,...
    'uMin', uMin,'uMax', uMax, 'duMin', duMin, 'duMax', duMax,...
    'algType', algType);

% Trajectory
[YYzad, kk, ypp, upp, ~] = getY2Trajectory();

% Variable initialisation
YY = zeros(kk, ny);
UU = zeros(kk, nu);

% Control loop
for k=1:kk
    YY(k, :) = getObjectOutputEq(A, B, YY, ypp, UU, upp, ny, nu, InputDelay, k);
    reg = reg.calculateControl(YY(k, :), YYzad(k, :));
    UU(k, :) = reg.getControl();
end

% Plotting
plotRun(YY, YYzad, UU, 0.01, ny, nu, 'GPC', algType);

% Control error
err = Utilities.calculateError(YY, YYzad)
