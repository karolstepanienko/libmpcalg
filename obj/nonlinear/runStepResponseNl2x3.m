function runStepResponseNl2x3()
    ny = 2; nu = 3;
    ypp = 0; upp = 0;
    kk = 15;
    nStep = 5;

    for cStep=1:nStep
        uStep = cStep;
        % uStep = 1;
        for chosenU=1:nu
            [stepResponsesMultiStep{chosenU, cStep}, UU] = ...
                getStepResponseNl2x3(ypp, upp, uStep, chosenU, kk);
        end
    end

    % st = 1;
    % figure;
    % stepResponses = {stepResponsesMultiStep{:, 1}};
    % plotStepResponses(stepResponses', st);

    % Gather last stepResponse elements
    stabilisedStepResponses = zeros(nStep, ny, nu);
    for cStep=1:nStep
        for cu=1:nu
            for cy=1:ny
                stabilisedStepResponses(cStep, cy, cu) =...
                    stepResponsesMultiStep{cu, cStep}(kk, cy);
            end
        end
    end

    figure;
    plotStabilisedStepResponses(ny, nu, nStep, stabilisedStepResponses);
end
