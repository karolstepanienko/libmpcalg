function test2x1StepResponse(time)
    arguments
        time (1, 1) double = 10;
    end
    st = 0.1; % Sampling time
    kk = time/st; % Simulation length
    testStepResponse(@get2x1, st, kk); % ny x nu
end