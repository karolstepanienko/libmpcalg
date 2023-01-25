%% get2x3
% Returns stable object with two outputs and three inputs
% y x u
function obj = get2x3(st)
    arguments
        st (1,1) { mustBeNumeric } = 1  % Sampling time
    end
    %% Single inertial object
    %               1                       2                        3
    % (y1, u1): ----------,   (y1, u2): ----------,   (y1, u3) = ----------,
    %            1s + 1                  2s + 1                   3s + 1
    %               4                       5                        6
    % (y2, u1): ----------,   (y2, u2): ----------,   (y2, u3) = ----------,
    %            4s + 1                  5s + 1                   6s + 1
    %

    cNum = {
    %  u1 u2 u3
        1 2 3; % y1
        4 5 6 % y2
    };

    cDen = {
        %  u1     u2
        [1 1] [2 1] [3 1]; % y1
        [4 1] [5 1] [6 1]  % y2
    };

    Gs = tf(cNum, cDen);
    obj = MIMOObj(Gs, st);

    % obj.A
    % obj.B
    % SSs = ss(Gs)
    % SSz = c2d(SSs, st)
    % figure;
    % step(Gs);
    % stepResponses = getStepResponsesEq(obj.ny, obj.nu, obj.InputDelay,...
    %     obj.A, obj.B, 40);
    % figure;
    % plotStepResponses(stepResponses, st);

    fileName = '2x3.mat';
    obj.save(fileName);

    % Appending the save file
    m = matfile(Utilities.getObjBinFilePath(fileName), 'Writable',true);

    %% MPC regulator parameters
    m.D = 300;  % Dynamic horizon
    m.N = 200;  % Prediction horizon
    m.N1 = 1;  % Delay offset
    m.NNl = 8;  % Prediction horizon for nonlinear algorithm
                % (purpose: decrease test time)
    m.Nu = 8;  % Moving horizon
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
