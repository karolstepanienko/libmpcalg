function test1x2StepResponse()
    st = 0.1; % Sampling time
    kk = 80; % Simulation length
    testStepResponse(@get1x2, st, kk); % ny x nu
end