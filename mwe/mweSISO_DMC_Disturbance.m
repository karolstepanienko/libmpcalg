function [YYzad, Y, U] = mweSISO_DMC_Disturbance()
% Adjust this to point to libmpcalg library src folder
addpath('../libmpcalg/src');
init();  % Adding necessary paths

% Regulation and disturbance object parameters
ny = 1;  % Number of regulation object outputs
nu = 1;  % Number of regulation object inputs
nyz = ny;  % Number of disturbance object outputs
nz = nu;  % Number of disturbance object inputs
% Input-Output delay of regulation object
IODelay = zeros(ny, nu);
% Input-Output delay of disturbance object
IODelayZ = zeros(nyz, nz);

% Regulation and disturbance object
% Single inertial object
% Object's continuous transmittance Gs(s):
%    K           1
% -------- = ---------
%  Ts + 1     s + 1
% Sampling time = 0.1.
% Discrete-time transmittance Gz(z):
%            0.09516
%  Gz(z) = ------------
%           z - 0.9048
% Difference equation:
A = {[1 -0.9048]}; Az = A;
B = {[0 0.0952]}; Bz = B;
% Disturbance object step response
stepResponse = {[0; 0.0952; 0.1813; 0.2592; 0.3297; 0.3935; 0.4512; 0.5034; 0.5507; 0.5934; 0.6321; 0.6671; 0.6988; 0.7275; 0.7534; 0.7769; 0.7981; 0.8173; 0.8347; 0.8504; 0.8647; 0.8775; 0.8892; 0.8997; 0.9093; 0.9179; 0.9257; 0.9328; 0.9392; 0.9450; 0.9502; 0.9550; 0.9592; 0.9631; 0.9666; 0.9698; 0.9727; 0.9753; 0.9776; 0.9798; 0.9817; 0.9834; 0.9850; 0.9864; 0.9877; 0.9889; 0.9899; 0.9909; 0.9918; 0.9926; 0.9933; 0.9939; 0.9945; 0.9950; 0.9955; 0.9959; 0.9963; 0.9967; 0.9970; 0.9973; 0.9975; 0.9978; 0.9980; 0.9982; 0.9983; 0.9985; 0.9986; 0.9988; 0.9989; 0.9990; 0.9991; 0.9992; 0.9993; 0.9993; 0.9994; 0.9994; 0.9995; 0.9995; 0.9996; 0.9996; 0.9997; 0.9997; 0.9997; 0.9998; 0.9998; 0.9998; 0.9998; 0.9998; 0.9998; 0.9999; 0.9999; 0.9999; 0.9999; 0.9999; 0.9999; 0.9999; 0.9999; 0.9999; 0.9999; 0.9999; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000; 1.0000]};

% Regulator parameters
D = 80;  % Dynamic horizon
Dz = 100;  % Disturbance dynamic horizon
N = 70;  % Prediction horizon
N1 = 1;  % Offset resulting from the delay
Nu = 5;  % Moving horizon
mi = ones(ny, 1);  % Output importance
lambda = zeros(nu, 1);  % Control weight
algType = 'analytical';

% Regulator without disturbance compensation
reg = DMC(D, N, Nu, ny, nu, stepResponse, 'N1', N1,...
    'mi', mi, 'lambda', lambda, 'algType', algType);

% Regulator with disturbance compensation
regZ = DMC(D, N, Nu, ny, nu, stepResponse, 'N1', N1,...
    'mi', mi, 'lambda', lambda,...
    'nz', nz, 'Dz', Dz, 'stepResponsesZ', stepResponse,...
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
Yo_DMC_k_1 = ones(1, ny) * ypp;
Yoz_DMC_k_1 = ones(1, ny) * ypp;
Yo_DMC = ones(kk, ny) * ypp;
Yoz_DMC = ones(kk, ny) * ypp;

% Control loop
for k=1:kk
    % Disturbance object
    Yz(k, :) = getObjectOutputEq(Az, Bz, Yz, ypp, Uz, upp,...
            ny, nu, IODelayZ, k);

    % Without disturbance compensation
    U_DMC(k) = reg.calculateControl(Yo_DMC_k_1, Yzad(k));
    Y_DMC(k) = getObjectOutputEq(A, B, Y_DMC, ypp,...
        U_DMC, upp, ny, nu, IODelay, k);
    Yo_DMC(k) = Y_DMC(k) + Yz(k);
    Yo_DMC_k_1 = Yo_DMC(k);

    % With disturbance compensation
    Uz_DMC(k) = regZ.calculateControl(Yoz_DMC_k_1,...
        Yzad(k), Uz(k, :));
    Yz_DMC(k) = getObjectOutputEq(A, B, Yz_DMC, ypp,...
        Uz_DMC, upp, ny, nu, IODelay, k);
    Yoz_DMC(k) = Yz_DMC(k) + Yz(k);
    Yoz_DMC_k_1 = Yoz_DMC(k);
end

% Plotting
hold on
    plot(Yo_DMC);
    plot(Yoz_DMC);
hold off
legend({'Y without disturbance compensation',...
    'Y with disturbance compensation'});

% Control error
err = Utilities.calculateError(Yo_DMC, Yzad)
err = Utilities.calculateError(Yoz_DMC, Yzad)

% Join matrices for octave tests
Y = [Yo_DMC, Yoz_DMC];
U = [U_DMC, Uz_DMC];
YYzad = [Yzad, Yzad];
end
