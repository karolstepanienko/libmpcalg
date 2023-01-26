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
    m.N1 = 1;  % Delay offset
    m.NNl = 6;  % Prediction horizon for nonlinear algorithm
                % (purpose: decrease test time)
    m.Nu = 5;  % Moving horizon
    m.NuNl = 1;  % Moving horizon for nonlinear algorithm
                 % (purpose: decrease test time)
    m.mi = ones(m.ny, 1);  % Output importance
    m.lambda = ones(m.nu, 1);  % Control weight
    m.uMin = -2 * ones(m.nu, 1);
    m.uMax = 2 * ones(m.nu, 1);
    m.duMin = -1 * ones(m.nu, 1);
    m.duMax = 1 * ones(m.nu, 1);
    m.yMin = -1.3 * ones(m.ny, 1);
    m.yMax = 1.3 * ones(m.nu, 1);
    m.osf = 1;  % Object Sampling Factor
end
