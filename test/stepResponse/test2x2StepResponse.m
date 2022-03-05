function test2x2StepResponse()
    st = 0.1; % Sampling time
    kk = 100; % Simulation length
    testStepResponse(@get2x2, st, kk); % ny x nu
end