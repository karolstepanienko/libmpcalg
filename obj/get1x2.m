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

    Gs = tf(cNum, cDen);
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
    m.N1 = 1;  % Delay offset
    m.NNl = 4;  % Prediction horizon for nonlinear algorithm
                % (purpose: decrease test time)
    m.Nu = 6;  % Moving horizon
    m.NuNl = 1;  % Moving horizon for nonlinear algorithm
                 % (purpose: decrease test time)
    m.mi = ones(m.ny, 1);  % Output importance
    m.lambda = ones(m.nu, 1);  % Control weight
    m.uMin = -0.5 * ones(m.nu, 1);
    m.uMax = 0.5 * ones(m.nu, 1);
    m.duMin = -0.4 * ones(m.nu, 1);
    m.duMax = 0.4 * ones(m.nu, 1);
    m.yMin = -1.8 * ones(m.ny, 1);
    m.yMax = 1.8 * ones(m.ny, 1);
    m.osf = 1;  % Object Sampling Factor
end
