function test3x2StepResponse()
    st = 0.1; % Sampling time
    kk = 100; % Simulation length
    testStepResponse(@get3x2, st, kk);
end