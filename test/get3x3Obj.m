function obj = get3x3Obj(st)
    % y x u
    %% Stable 3x3
    A = [-4 1 0; -5 0 1; -6 0 0]; % ny x nx
    B = [-1, 0.2 0.1; 2 -0.5 1; 0.1 0.2 -0.3];
    C = [1 -0.5 3; 0.2 -4 1; 0.4 -0.7 0.1]; % ny x nx
    D = [0.1 -0.2 0.3; 0.4 -0.5 0.6; 0.7 -0.8 0.9]; % ny x nu
    obj = MIMOObj(A, B, C, D, st);
end