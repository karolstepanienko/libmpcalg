%% get1x1SingleInertial
% Returns stable SISO object
% y x u
function obj = get1x1SingleInertial(st)
    arguments
        st (1,1) { mustBeNumeric } = 1  % Sampling time
    end

    %% Single inertial object
    % Object's continuous transmittance
    %      K            4
    % ---------- = ----------
    %  (Ts + a)     (10s + 3)

    K = 4;
    T = 10;
    a = 3;

    cNum = [K];
    cDen = [T a];

    Gs = tf(cNum, cDen);

    obj = MIMOObj(Gs, st);
    % figure;
    % step(Gs);

    fileName = '1x1SingleInertial.mat';
    obj.save(fileName);

    % Appending the save file
    m = matfile(Utilities.getObjBinFilePath(fileName), 'Writable',true);

    %% MPC regulator parameters
    m.D = 30;  % Dynamic horizon
    m.N = 30;  % Prediction horizon
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
    m.yMax = 1.3 * ones(m.ny, 1);
    m.osf = 1;  % Object Sampling Factor
end
