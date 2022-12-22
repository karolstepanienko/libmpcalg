%% Script used to manually test MPCNO algorithm implementation

% Object parameters
ny = 2;  % Number of outputs
nu = 3;  % Number of inputs
InputDelay = 0;
osf = 1;  % Object sampling factor

% Regulator parameters
N = 4;  % Prediction horizon
Nu = 2;  % Moving horizon
lambda = ones(1, nu);  % Control weight
uMin = -100;
uMax = -uMin;
algType = '';

% Trajectory
object = '2x3';
trajectoryGetterFunc = getTrajectory(object);
[YYzad, kk, ypp, upp, xpp] = trajectoryGetterFunc(osf);

% Regulator
reg = MPCNO(N, Nu, ny, nu, @getObjectOutputNl2x3, 'lambda', lambda,...
    'ypp', ypp, 'upp', upp, 'uMin', uMin, 'uMax', uMax);

% Variable initialisation
YY = ones(kk, ny) * ypp;
UU = ones(kk, nu) * upp;
YY_k_1 = ones(1, ny) * ypp;

% Control loop
for k=1:kk
    reg = reg.calculateControl(YY_k_1, YYzad(k, :));
    UU(k, :) = reg.getControl();
    YY(k, :) = getObjectOutputNl2x3(ypp, YY, upp, UU, k);
    YY_k_1 = YY(k, :);
    % disp("loop")
    % k
    % YY(1:k+1, :)
    % pause
end

% Plotting
plotRun(YY, YYzad, UU, 1, ny, nu, 'MPCNO', algType);

% Control error
err = Utilities.calculateError(YY, YYzad)
