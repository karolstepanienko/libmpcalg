%% get1x2
% Returns object with one output and two inputs
function obj = get1x2(st)
    % y x u
    A = [-1/2 -3/4; -5/6 -7/8];
    B = [1 0; 0 1];
    C = [2/1, 4/3];
    D = 0;
    obj = MIMOObj(A, B, C, D, st);
end
