function runStepResponseNl1x1()
    ny = 1; nu = 1;
    ypp = 0; upp = 0;
    kk = 30;

    nStep = 5;

    for cStep=1:nStep
        uStep = cStep;
        [stepResponsesMultiStep{cStep, 1}, U] = getStepResponseNl1x1(ypp, upp, uStep, kk);
    end

    % Gather last stepResponse elements
    stabilisedStepResponses = zeros(nStep, 1);
    for cStep=1:nStep
        stabilisedStepResponses(cStep) = stepResponsesMultiStep{cStep, 1}(kk);
    end

    plotStabilisedStepResponses(ny, nu, nStep, stabilisedStepResponses);
end
