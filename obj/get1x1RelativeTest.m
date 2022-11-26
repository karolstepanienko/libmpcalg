%% get1x1RelativeTest
% Creates and saves an object used for relative tests
% Large time constant enables testing stability of MPC algorithms
function obj = get1x1RelativeTest(st)
    arguments
        st (1,1) { mustBeNumeric } = 0.1  % Sampling time
    end

    %% Single inertial object
    % Object's continuous transmittance
    %    K           1
    % -------- = ---------
    %  Ts + 1     50s + 1

    K = 1;  % Gain
    T = 50;  % Time constant

    cNum = [K];
    cDen = [T, 1];

    InputDelay = 0;

    Gs = tf(cNum, cDen, 'InputDelay', InputDelay);  % Continuous transmittance
    Gz = c2d(Gs, st, 'zoh');  % Discrete transmittance
    obj = MIMOObj(Gs, st);   % Object

    fileName = '1x1RelativeTest';
    obj.save(fileName);

    m = matfile(Utilities.getObjBinFilePath(fileName), 'Writable',true);

    %% MPC regulator parameters
    m.D = 3500;  % Dynamic horizon
    m.N = 3000;  % Prediction horizon
    m.Nu = 10;  % Moving horizon
    m.mi = ones(1, m.ny);  % Output importance
    m.lambda = ones(1, m.nu);  % Control weight
    m.uMin = -2;
    m.uMax = -m.uMin;
    m.duMin = -1;
    m.duMax = -m.duMin;
    m.yMin = -1.3;
    m.yMax = -m.yMin;
end
