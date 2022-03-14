%% get1x2
% Returns object with one output and two inputs
function obj = get1x2(st)
    % y x u
    %% Stable
    A = [-1/2 0; 0 -1];
    B = [1 0; 0 1];
    C = [1.5/2 1/2];
    D = 0;
    obj = MIMOObj(A, B, C, D, st);
end
