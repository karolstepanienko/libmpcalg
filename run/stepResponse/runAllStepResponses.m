%% testAllStepResponses
% Runs all step response tests
% Remember to enable automatic closing of plots in Constants class
function runAllStepResponses()
    fileName = '1x1.mat'; % File with object data
    simTime = 10;
    runStepResponse(fileName, simTime);

    fileName = '1x2.mat'; % File with object data
    simTime = 25;
    runStepResponse(fileName, simTime);
    
    fileName = '2x2.mat'; % File with object data
    simTime = 3;
    runStepResponse(fileName, simTime);
end