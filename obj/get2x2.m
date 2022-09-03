%% get2x2
% Returns stable object with two outputs and two inputs
% y x u
function obj = get2x2(st)
    arguments
        st (1,1) { mustBeNumeric } = 0.01
    end
    %% Single inertial object
    %               1                       2
    % (y1, u1): ----------,   (y1, u2): ----------
    %            0.1s + 1                0.2s + 1
    %               3                       4
    % (y2, u1): ----------,   (y2, u2): ----------
    %            0.3s + 1                0.4s + 1
    %

    ny = 2;
    nu = 2;

    cNum = {
    %  u1 u2
        1 2; % y1
        3 4  % y2
    };
    
    cDen = {
        %  u1     u2
        [0.1 1] [0.2 1]; % y1
        [0.3 1] [0.4 1]  % y2
    };
    
    Gs = tf(cNum, cDen);
    obj = MIMOObj(Gs, st);
    % SSs = ss(Gs)
    % SSz = c2d(SSs, st)
    % figure;
    % step(Gs);

    fileName = '2x2.mat';
    obj.save(fileName);

    % Appending the save file
    m = matfile(Utilities.getObjBinFilePath(fileName), 'Writable',true);

    %% MPC regulator parameters
    m.D = 200;  % Dynamic horizon
    m.N = 100;  % Prediction horizon
    m.Nu = 8;  % Moving horizon
    m.ny = 2;
    m.nu = 2;
    m.mi = ones(1, m.ny);  % Output importance
    m.lambda = ones(1, m.nu);  % Control weight
    m.uMin = -2;
    m.uMax = -m.uMin;
    m.duMin = -0.5;
    m.duMax = -m.duMin;
    m.yMin = -0.6;
    m.yMax = -m.yMin;
end
