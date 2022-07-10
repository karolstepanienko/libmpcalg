%% get1x2
% Returns object with one output and two inputs
% y x u
function obj = get1x2(st)
    arguments
        st (1,1) { mustBeNumeric } = 1
    end
    %% Single inertial object
    %               2                       3
    % (y1, u1): ----------,   (y1, u2): ----------
    %            1.5s + 1                2.5s + 1
    %

    ny = 1;
    nu = 2;

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
    % figure;
    % step(Gs);

    fileName = '1x2.mat';
    obj.save(fileName);

    % Appending the save file
    m = matfile(Utilities.getObjBinFilePath(fileName), 'Writable',true);

    %% MPC regulator parameters
    m.D = 25;  % Dynamic horizon
    m.N = 5;  % Prediction horizon
    m.Nu = 1;  % Moving horizon
    m.ny = 1;
    m.nu = 2;
    m.mi = ones(1, m.ny);  % Output importance
    m.lambda = ones(1, m.nu);  % Control weight
    m.uMin = -1;
    m.uMax = -m.uMin;
    m.duMin = -0.4;
    m.duMax = -m.duMin;
    m.yMin = -1.5;
    m.yMax = -m.yMin;
end
