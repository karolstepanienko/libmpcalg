%% get1x1
% Returns stable SISO object
% y x u
function obj = get1x1(st)
    arguments
        st (1,1) { mustBeNumeric } = 1
    end

    %% Double inertial object
    % Object's continuous transmittance
    %          K                     2
    % -------------------- = --------------------
    % (T1s + 1)(T2s + 1)      0.24s^2 + 1.1s + 1
    %
    
    K = 2;
    T1 = 0.3;
    T2 = 0.8;

    cNum = [K];
    cDen = [T1*T2 T1+T2 1];
    Gs = tf(cNum, cDen);
    st = 0.1; % Sampling time
    
    obj = MIMOObj(Gs, st);
    % figure;
    % step(Gs);

    fileName = '1x1.mat';
    obj.save(fileName);

    % Appending the save file
    m = matfile(Utilities.getObjBinFilePath(fileName), 'Writable',true);

    %% MPC regulator parameters
    m.D = 20;  % Dynamic horizon
    m.N = 8;  % Prediction horizon
    m.Nu = 5;  % Moving horizon
    m.ny = 1;
    m.nu = 1;
    m.mi = ones(1, m.ny);  % Output importance
    m.lambda = ones(1, m.nu);  % Control weight
    m.uMin = -2;
    m.uMax = -m.uMin;
    m.duMin = -1;
    m.duMax = -m.duMin;
    m.yMin = -1.3;
    m.yMax = -m.yMin;
end
