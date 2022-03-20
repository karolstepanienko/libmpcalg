%% testStepResponse
% Universal function that tests step responses for object in a given file name
function testStepResponse(fileName, simTime)
    u = Utilities();
    filePath = u.getObjBinFilePath(fileName);
    load(filePath);
    kk = simTime/st; % Simulation length
    stepResponses = getStepResponses(ny, nu, numDen, kk);
    plotStepResponses(stepResponses);
end

% TODO automatic sim length detection
