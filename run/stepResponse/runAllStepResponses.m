%% testAllStepResponses
% Runs all step response tests
% Remember to enable automatic closing of plots in Constants class
function runAllStepResponses()
    runStepResponse('1x1.mat', 10, 'Eq');
    runStepResponse('1x2.mat', 25, 'Eq');
    runStepResponse('2x2.mat', 3, 'Eq');
    runStepResponse('1x1.mat', 10, 'state');
    runStepResponse('1x2.mat', 25, 'state');    
    runStepResponse('2x2.mat', 25, 'state');
end
