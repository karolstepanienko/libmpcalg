function [Yzad, Y, U] = mweSISO_DMC()
% Adjust this to point to libmpcalg library src folder
addpath('../libmpcalg/src');
init();  % Adding necessary paths

% Object parameters
ny = 1;  % Number of outputs
nu = 1;  % Number of inputs
IODelay = zeros(ny, nu);  % Input-Output delay
osf = 1;  % Object sampling factor - how many times object
        % output will be calculated between consecutive
        % control calculations. Here set to 1 for
        % simplicity of the Minimal Working Example

%% Object model: step response
%
% Double inertial object
% Continuous-time transmittance Gs(ny x nu)(s):
%                   K                     2
% Gs(s) = -------------------- = --------------------
%          (T1s + 1)(T2s + 1)     0.24s^2 + 1.1s + 1
%
% Sampling time = 0.1.
% Discrete-time transmittance Gz(z):
%            0.03585 z + 0.03077
%  Gz(z) = -------------------------
%            z^2 - 1.599 z + 0.6323
%
% Difference equation:
A = {[1 -1.5990 0.6323]};
B = {[0 0.0358 0.0308]};

% Object step response
stepResponse = {[0; 0.0358; 0.1239; 0.2421; 0.3754; 0.5138; 0.6508; 0.7824; 0.9062; 1.0209; 1.1260; 1.2216; 1.3080; 1.3856; 1.4552; 1.5173; 1.5727; 1.6220; 1.6657; 1.7045; 1.7389; 1.7693; 1.7962; 1.8200; 1.8411; 1.8597; 1.8761; 1.8907; 1.9035; 1.9148; 1.9248; 1.9336; 1.9414; 1.9483; 1.9544; 1.9597; 1.9645; 1.9686; 1.9723; 1.9756; 1.9784; 1.9810; 1.9832; 1.9852; 1.9869; 1.9885; 1.9898; 1.9910; 1.9921; 1.9930; 1.9938; 1.9945; 1.9952; 1.9958; 1.9963; 1.9967; 1.9971; 1.9974; 1.9977; 1.9980; 1.9982; 1.9984; 1.9986; 1.9988; 1.9989; 1.9991; 1.9992; 1.9993; 1.9993; 1.9994; 1.9995; 1.9996; 1.9996; 1.9997; 1.9997; 1.9997; 1.9998; 1.9998; 1.9998; 1.9998]};

% Regulator parameters
D = 80;  % Dynamic horizon
N = 70;  % Prediction horizon
Nu = 5;  % Moving horizon
mi = ones(1, ny);  % Output importance
lambda = 20 * ones(1, nu);  % Control weight
algType = 'analytical';

% Regulator
reg = DMC(D, N, Nu, ny, nu, stepResponse, 'mi', mi,...
    'lambda', lambda, 'uMin', -1, 'uMax', 1,...
    'duMin', -1, 'duMax', 1, 'algType', algType);

% Trajectory
[Yzad, kk] = getY1Trajectory(osf);

% Variable initialisation
ypp = 0; upp = 0;
Y = ones(kk, ny) * ypp;
U = ones(kk, nu) * upp;
Y_k_1 = ones(1, ny) * ypp;

% Control loop
for k=1:kk
    U(k) = reg.calculateControl(Y_k_1, Yzad(k));
    Y(k) = getObjectOutputEq(A, B, Y, ypp, U, upp, ny, nu,...
        IODelay, k);
    Y_k_1 = Y(k);
end

% Plotting
plotRun(Y, Yzad, U, 0.1, ny, nu, 'DMC', algType);

% Control error
err = Utilities.calculateError(Y, Yzad)
end
