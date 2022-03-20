%% get2x2
% Returns stable object with two outputs and two inputs
% y x u
function obj = get2x2(st)
    arguments
        st (1,1) {mustBeNumeric} = 0.1
    end
    %% Single intertial object
    %               1                       2
    % (y1, u1): ----------,   (y1, u2): ----------
    %            0.1s + 1                0.2s + 1
    %               3                       4
    % (y2, u1): ----------,   (y2, u2): ----------
    %            0.3s + 1                0.4s + 1
    %
    
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
    step(Gs)
    obj.save('2x2.mat');
end
