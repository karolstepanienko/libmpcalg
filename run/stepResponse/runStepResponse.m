%% runStepResponse
% Universal function that tests step responses for object in a given file name
function runStepResponse(fileName, simTime)
    u = Utilities();
    filePath = u.getObjBinFilePath(fileName);
    load(filePath);
    kk = simTime/st; % Simulation length
    stepResponses = getStepResponses(ny, nu, A, B, kk);
    plotStepResponses(stepResponses, st);
end

% TODO automatic simulation length detection
