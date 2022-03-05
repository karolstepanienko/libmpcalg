function test1x1StepResponse()
    st = 0.1; % Sampling time
    kk = 100; % Simulation length
    testStepResponse(@get1x1, st, kk); % ny x nu
end