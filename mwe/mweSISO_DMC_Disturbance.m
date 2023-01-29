function [Yzad, Yz_DMC, Uz_DMC] = mweSISO_DMC_Disturbance()
% Adjust this to point to libmpcalg library src folder
addpath('../libmpcalg/src');
init();  % Adding necessary paths

% Object parameters
ny = 1;  % Number of outputs
nu = 1;  % Number of inputs
IODelay = zeros(ny, nu);  % Input-Output delay

%% Object model: step response
%
% Double inertial object
% Continuous-time transmittance Gs(s):
%                   K                     2
% Gs(s) = -------------------- = --------------------
%          (T1s + 1)(T2s + 1)     0.24s^2 + 1.1s + 1
% Sampling time = 0.1.
% Discrete-time transmittance Gz(z):
%            0.03585 z + 0.03077
%  Gz(z) = -------------------------
%            z^2 - 1.599 z + 0.6323
% Difference equation:
A = {[1 -1.5990 0.6323]};
B = {[0 0.0358 0.0308]};

% Object step response
stepResponse = {[0; 0.0358; 0.1239; 0.2421; 0.3754; 0.5138; 0.6508; 0.7824; 0.9062; 1.0209; 1.1260; 1.2216; 1.3080; 1.3856; 1.4552; 1.5173; 1.5727; 1.6220; 1.6657; 1.7045; 1.7389; 1.7693; 1.7962; 1.8200; 1.8411; 1.8597; 1.8761; 1.8907; 1.9035; 1.9148; 1.9248; 1.9336; 1.9414; 1.9483; 1.9544; 1.9597; 1.9645; 1.9686; 1.9723; 1.9756; 1.9784; 1.9810; 1.9832; 1.9852; 1.9869; 1.9885; 1.9898; 1.9910; 1.9921; 1.9930; 1.9938; 1.9945; 1.9952; 1.9958; 1.9963; 1.9967; 1.9971; 1.9974; 1.9977; 1.9980; 1.9982; 1.9984; 1.9986; 1.9988; 1.9989; 1.9991; 1.9992; 1.9993; 1.9993; 1.9994; 1.9995; 1.9996; 1.9996; 1.9997; 1.9997; 1.9997; 1.9998; 1.9998; 1.9998; 1.9998]};

% Disturbance object parameters
nyz = 1;  % Number of outputs
nz = 1;  % Number of inputs
IODelayZ = zeros(nyz, nz);  % Input-Output delay

% Disturbance object
% Single inertial object
% Object's continuous transmittance Gs(s):
%    K           1
% -------- = ---------
%  Ts + 1     s + 1
% Sampling time = 0.1.
% Discrete-time transmittance Gz(z):
%            0.009516
%  Gz(z) = ------------
%           z - 0.9048
% Difference equation:
Az = {[1 -0.9048]};
Bz = {[0 0.0095]};
% Disturbance object step response
stepResponseZ = {[0; 0.0095; 0.0181; 0.0259; 0.0330; 0.0393; 0.0451; 0.0503; 0.0551; 0.0593; 0.0632; 0.0667; 0.0699; 0.0727; 0.0753; 0.0777; 0.0798; 0.0817; 0.0835; 0.0850; 0.0865; 0.0878; 0.0889; 0.0900; 0.0909; 0.0918; 0.0926; 0.0933; 0.0939; 0.0945; 0.0950; 0.0955; 0.0959; 0.0963; 0.0967; 0.0970; 0.0973; 0.0975; 0.0978; 0.0980; 0.0982; 0.0983; 0.0985; 0.0986; 0.0988; 0.0989; 0.0990; 0.0991; 0.0992; 0.0993; 0.0993; 0.0994; 0.0994; 0.0995; 0.0995; 0.0996; 0.0996; 0.0997; 0.0997; 0.0997; 0.0998; 0.0998; 0.0998; 0.0998; 0.0998; 0.0998; 0.0999; 0.0999; 0.0999; 0.0999; 0.0999; 0.0999; 0.0999; 0.0999; 0.0999; 0.0999; 0.0999; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000; 0.1000]};

% Regulator parameters
D = 80;  % Dynamic horizon
Dz = 100;  % Disturbance dynamic horizon
N = 70;  % Prediction horizon
N1 = 1;  % Offset resulting from the delay
Nu = 5;  % Moving horizon
mi = ones(ny, 1);  % Output importance
lambda = 10 * ones(nu, 1);  % Control weight
algType = 'analytical';

% Regulator without disturbance compensation
reg = DMC(D, N, Nu, ny, nu, stepResponse, 'N1', N1,...
    'mi', mi, 'lambda', lambda, 'algType', algType);

% Regulator with disturbance compensation
regZ = DMC(D, N, Nu, ny, nu, stepResponse, 'N1', N1,...
    'mi', mi, 'lambda', lambda,...
    'nz', nz, 'Dz', Dz, 'stepResponsesZ', stepResponseZ,...
    'algType', algType);

% Trajectory
[Yzad, kk] = getY1DisturbanceTrajectory();
[Uz, kk] = getU1DisturbanceControl();

% Variable initialisation
ypp = 0; upp = 0;
Yz = ones(kk, nyz) * ypp;
Y_DMC = ones(kk, ny) * ypp;
Yz_DMC = ones(kk, ny) * ypp;
U_DMC = ones(kk, nu) * upp;
Uz_DMC = ones(kk, nu) * upp;
Y_DMC_k_1 = ones(1, ny) * ypp;
Yz_DMC_k_1 = ones(1, ny) * ypp;

% Control loop
for k=1:kk
    % Disturbance object
    Yz(k, :) = getObjectOutputEq(Az, Bz, Yz, ypp, Uz, upp,...
            ny, nu, IODelayZ, k);

    % Without disturbance compensation
    U_DMC(k) = reg.calculateControl(Y_DMC_k_1, Yzad(k));
    Y_DMC(k) = getObjectOutputEq(A, B, Y_DMC, ypp, U_DMC, upp, ny, nu,...
        IODelay, k);
    Y_DMC(k) = Y_DMC(k) + Yz(k);
    Y_DMC_k_1 = Y_DMC(k);

    % With disturbance compensation
    Uz_DMC(k) = regZ.calculateControl(Yz_DMC_k_1, Yzad(k), Uz(k, :));
    Yz_DMC(k) = getObjectOutputEq(A, B, Yz_DMC, ypp,...
        Uz_DMC, upp, ny, nu, IODelay, k);
    Yz_DMC(k) = Yz_DMC(k) + Yz(k);
    Yz_DMC_k_1 = Yz_DMC(k);
end

% Plotting
hold on
    plot(Y_DMC);
    plot(Yz_DMC);
hold off
legend({'Y without disturbance compensation',...
    'Y with disturbance compensation'});

% Control error
err = Utilities.calculateError(Y_DMC, Yzad)
err = Utilities.calculateError(Yz_DMC, Yzad)
end
