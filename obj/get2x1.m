%% get2x1
% Returns object with two outputs and one input
function obj = get2x1(st)
    % y x u
    A = [-1 0; 0 -1];
    B = [0.8; 0.1];
    C = [1 0; 0 1];
    D = 0;
    obj = MIMOObj(A, B, C, D, st);
end
