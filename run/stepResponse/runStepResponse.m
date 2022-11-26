%% runStepResponse
% Universal function that tests step responses for object in a given file name
function runStepResponse(fileName, simTime, stepResponseGetter)
    u = Utilities();
    filePath = u.getObjBinFilePath(fileName);
    load(filePath);
    kk = simTime/st; % Simulation length
    if strcmp(stepResponseGetter, 'Eq')
        stepResponses = getStepResponsesEq(ny, nu, InputDelay, A, B, kk);
    elseif strcmp(stepResponseGetter, 'state')
        stepResponses = getStepResponsesState(nx, ny, nu, InputDelay, dA, dB,...
            dC, dD, kk);
    end
    figure;
    plotStepResponses(stepResponses, st);
end

% TODO automatic simulation length detection
