function obj = get3x2(st)
    % y x u
    A = [-4 1 0; -5 0 1; -6 0 0]; % ny x nx    
    B = [-1 -2; -3 1; -3 -4]; % ny x nu
    C = [1 -0.5 3; 0.2 -4 1; 0.4 -0.7 0.1]; % ny x nx
    D = [-0.1 -0.2; 0.3 -0.4; -0.5 0.6]; % ny x nu
    obj = MIMOObj(A, B, C, D, st);
end