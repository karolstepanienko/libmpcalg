%% get1x1RelativeTest
% Creates and saves an object used for relative tests
% Large time constant enables testing stability of MPC algorithms
function obj = get1x1RelativeTest(st)
    arguments
        st (1,1) { mustBeNumeric } = 1  % Sampling time
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

    Gs = tf(cNum, cDen);  % Continuous transmittance
    Gz = c2d(Gs, st, 'zoh');  % Discrete transmittance
    obj = MIMOObj(Gs, st);   % Object

    fileName = '1x1RelativeTest';
    obj.save(fileName);

    m = matfile(Utilities.getObjBinFilePath(fileName), 'Writable',true);

    %% MPC regulator parameters
    m.D = 350;  % Dynamic horizon
    m.N = 300;  % Prediction horizon
    m.N1 = 1;  % Delay offset
    m.NNl = 4;  % Prediction horizon for nonlinear algorithm
                % (purpose: decrease test time)
    m.Nu = 2;  % Moving horizon
    m.NuNl = 1;  % Moving horizon for nonlinear algorithm
                 % (purpose: decrease test time)
    m.mi = ones(m.ny, 1);  % Output importance
    m.lambda = 6 * ones(m.nu, 1);  % Control weight
    m.uMin = -1.5 * ones(m.nu, 1);
    m.uMax = 1.5 * ones(m.nu, 1);
    m.duMin = -0.2 * ones(m.nu, 1);
    m.duMax = 0.2 * ones(m.nu, 1);
    m.yMin = -1.3 * ones(m.ny, 1);
    m.yMax = 1.3 * ones(m.nu, 1);
    m.osf = 4;  % Object Sampling Factor
end
