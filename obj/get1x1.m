%% get1x1
% Returns stable SISO object
% y x u
function obj = get1x1(st)
    arguments
        st (1,1) { mustBeNumeric } = 0.1  % Sampling time
    end

    %% Double inertial object
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

    K = 2;
    T1 = 0.3;
    T2 = 0.8;

    cNum = [K];
    cDen = [T1*T2 T1+T2 1];

    Gs = tf(cNum, cDen);

    obj = MIMOObj(Gs, st);
    % figure;
    % step(Gs);

    fileName = '1x1.mat';
    obj.save(fileName);

    % Appending the save file
    m = matfile(Utilities.getObjBinFilePath(fileName), 'Writable',true);

    %% MPC regulator parameters
    m.D = 80;  % Dynamic horizon
    m.N = 70;  % Prediction horizon
    m.NNl = 6;  % Prediction horizon for nonlinear algorithm
                % (purpose: decrease test time)
    m.Nu = 5;  % Moving horizon
    m.NuNl = 1;  % Moving horizon for nonlinear algorithm
                 % (purpose: decrease test time)
    m.mi = ones(1, m.ny);  % Output importance
    m.lambda = ones(1, m.nu);  % Control weight
    m.uMin = -2;
    m.uMax = -m.uMin;
    m.duMin = -1;
    m.duMax = -m.duMin;
    m.yMin = -1.3;
    m.yMax = -m.yMin;
    m.osf = 1;  % Object Sampling Factor
end
