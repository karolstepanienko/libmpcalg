%% get1x1Disturbance
% Returns stable SISO object used as a measured disturbance
function obj = get1x1Disturbance(st)
    arguments
        st (1,1) { mustBeNumeric } = 0.1  % Sampling time
    end

    %% Single inertial object
    % Object's continuous transmittance
    %    K           1
    % -------- = ---------
    %  Ts + 1     s + 1

    K = 0.1;  % Gain
    T = 1;  % Time constant

    cNum = [K];
    cDen = [T, 1];

    Gs = tf(cNum, cDen);  % Continuous transmittance
    obj = MIMOObj(Gs, st);   % Object
    step(obj.Gz)

    fileName = '1x1Disturbance';
    obj.save(fileName);

    m = matfile(Utilities.getObjBinFilePath(fileName), 'Writable',true);
    m.nz = 1;
    m.D = 150;  % Dynamic horizon
    m.N = 150;  % Prediction horizon
    m.N1 = 1;  % Delay offset
    m.NNl = 6;  % Prediction horizon for nonlinear algorithm
                % (purpose: decrease test time)
    m.Nu = 5;  % Moving horizon
    m.NuNl = 1;  % Moving horizon for nonlinear algorithm
                 % (purpose: decrease test time)
    m.mi = ones(m.ny, 1);  % Output importance
    m.lambda = ones(m.nu, 1);  % Control weight
    m.uMin = -Inf * ones(m.nu, 1);
    m.uMax = Inf * ones(m.nu, 1);
    m.duMin = -Inf * ones(m.nu, 1);
    m.duMax = Inf * ones(m.nu, 1);
    m.yMin = -1.3;
    m.yMax = -m.yMin;
    m.osf = 1;  % Object Sampling Factor
end
