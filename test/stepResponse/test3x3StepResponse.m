function test3x3StepResponse()
    st = 0.1; % Sampling time
    kk = 150; % Simulation length
    testStepResponse(@get3x3, st, kk); % ny x nu
end