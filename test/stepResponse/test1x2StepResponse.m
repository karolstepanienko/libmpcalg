function test1x2StepResponse(time)
    arguments
        time (1, 1) double = 10;
    end
    st = 0.1; % Sampling time
    kk = time/st; % Simulation length
    testStepResponse(@get1x2, st, kk); % ny x nu
end