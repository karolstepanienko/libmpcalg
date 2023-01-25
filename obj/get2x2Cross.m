%% get2x2
% Returns stable object with two outputs and two inputs with cross delays
% y x u
function obj = get2x2Cross(st)
    arguments
        st (1,1) { mustBeNumeric } = 0.1  % Sampling time
    end
    %% Single inertial object
    %                          1                                 2
    % (y1, u1): e^(-0.1s) ----------,   (y1, u2): e^(-0.3s) ----------
    %                      0.1s + 1                          0.2s + 1
    %                          3                                 4
    % (y2, u1): e^(-0.3s) ----------,   (y2, u2): e^(-0.4s) ----------
    %                      0.3s + 1                          0.4s + 1
    %

    % From input 1 to output...
    Gs1x1 = tf([1], [1 1], 'InputDelay', 0.1);
    Gs2x1 = tf([3], [3 1], 'InputDelay', 0.2);
    % From input 2 to output...
    Gs1x2 = tf([2], [2 1], 'InputDelay', 0.3);
    Gs2x2 = tf([4], [4 1], 'InputDelay', 0.4);

    Gs = [Gs1x1, Gs1x2;
        Gs2x1, Gs2x2];

    st = 0.1;
    obj = MIMOObj(Gs, st);
    % figure;
    % step(Gs);

    fileName = '2x2Cross.mat';
    obj.save(fileName);

    % Appending the save file
    m = matfile(Utilities.getObjBinFilePath(fileName), 'Writable',true);

    %% MPC regulator parameters
    m.D = 300;  % Dynamic horizon
    m.N = 200;  % Prediction horizon
    m.N1 = 1;  % Delay offset
    m.NNl = 20;  % Prediction horizon for nonlinear algorithm
                % (purpose: decrease test time)
    m.Nu = 10;  % Moving horizon
    m.NuNl = 1;  % Moving horizon for nonlinear algorithm
                 % (purpose: decrease test time)
    m.mi = ones(1, m.ny);  % Output importance
    m.lambda = ones(1, m.nu);  % Control weight
    m.uMin = -2;
    m.uMax = -m.uMin;
    m.duMin = -2.5;
    m.duMax = -m.duMin;
    m.yMin = -1;
    m.yMax = -m.yMin;
    m.osf = 1;  % Object Sampling Factor
end
