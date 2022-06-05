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
    figure;
    step(Gs);
    obj.save('1x2.mat');
end
