%% get1x1Unstable
% Returns unstable SISO object
% y x u
function obj = get1x1Unstable(st)
    arguments
        st (1,1) { mustBeNumeric } = 1  % Sampling time
    end

    % Object's continuous transmittance
    %         2
    % ------------------
    %   24s^2 - 5s + 1
    %

    K = 2;
    T1 = 3;
    T2 = 8;

    cNum = [K];
    cDen = [T1*T2 T1-T2 1];

    Gs = tf(cNum, cDen);

    obj = MIMOObj(Gs, st);

    % kk = 300;
    % figure;
    % step(Gs, kk);

    fileName = '1x1Unstable.mat';
    obj.save(fileName);

    % Appending the save file
    m = matfile(Utilities.getObjBinFilePath(fileName), 'Writable',true);

    %% MPC regulator parameters
    m.D = 40;  % Dynamic horizon
    m.N = 40;  % Prediction horizon
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
