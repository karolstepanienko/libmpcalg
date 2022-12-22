%% get1x2
% Returns object with one output and two inputs
% y x u
function obj = get1x2(st)
    arguments
        st (1,1) { mustBeNumeric } = 0.1  % Sampling time
    end
    %% Single inertial object
    %               2                       3
    % (y1, u1): ----------,   (y1, u2): ----------
    %            1.5s + 1                2.5s + 1
    %

    cNum = {
    %  u1 u2
        2 3 % y1
    };

    cDen = {
        %  u1     u2
        [1.5 1] [2.5 1] % y1
    };

    InputDelay = [0; 0];

    Gs = tf(cNum, cDen, 'InputDelay', InputDelay);
    obj = MIMOObj(Gs, st);
    % SSs = ss(Gs);
    % SSz = c2d(SSs, st)
    % figure;
    % step(Gs);

    fileName = '1x2.mat';
    obj.save(fileName);

    % Appending the save file
    m = matfile(Utilities.getObjBinFilePath(fileName), 'Writable',true);

    %% MPC regulator parameters
    m.D = 250;  % Dynamic horizon
    m.N = 150;  % Prediction horizon
    m.NNl = 4;  % Prediction horizon for nonlinear algorithm
                % (purpose: decrease test time)
    m.Nu = 6;  % Moving horizon
    m.NuNl = 1;  % Moving horizon for nonlinear algorithm
                 % (purpose: decrease test time)
    m.mi = ones(1, m.ny);  % Output importance
    m.lambda = ones(1, m.nu);  % Control weight
    m.uMin = -0.5;
    m.uMax = -m.uMin;
    m.duMin = -0.4;
    m.duMax = -m.duMin;
    m.yMin = -1.8;
    m.yMax = -m.yMin;
    m.osf = 1;  % Object Sampling Factor
end
