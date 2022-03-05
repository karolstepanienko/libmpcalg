function obj = get2x2(st)
    % Unstable
    % y x u
    A = [-4/3 0 ; -5/4 0]; % ny x nx    
    B = [-2/3 0; 0 -4/5]; % ny x nu
    C = [1 -0.5; 0.4 0.1]; % ny x nx
    D = [-0.1 -0.2; 0.3 -0.4]; % ny x nu
    obj = MIMOObj(A, B, C, D, st);
end