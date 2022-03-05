%% get1x1
% Returns stable SISO object
function obj = get1x1(st)
    % y x u
    A = -3/4;
    B = 1;
    C = 5/4;
    D = 0;
    obj = MIMOObj(A,B,C,D,st);
end