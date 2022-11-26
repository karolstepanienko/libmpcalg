% Returns all object step responses
function stepResponses = getStepResponsesState(nx, ny, nu, InputDelay, dA, dB, dC, dD, kk)
    stepResponses = cell(nu, 1);
    for i=1:nu % for every input
        % kk + 1 because first element does not belong to step response
        stepResponses{i, 1} = getStepResponse(nx, ny, nu, InputDelay,...
            dA, dB, dC, dD, i, kk+1);
    end
end

% Returns output response for a step on a given input
function YY = getStepResponse(nx, ny, nu, InputDelay, dA, dB, dC, dD, chosenU, kk)
    c = Constants();
    %% Variable initialisation
    xpp = c.testUInitVal;
    ypp = c.testYInitVal;
    upp = c.testUInitVal;
    XX = ones(kk, nx) * xpp;
    YY = ones(kk, ny) * ypp;
    UU = ones(kk, nu) * upp;

    %% Add control step
    % Step starts at k = 1 (matlab indexing),
    % so step response will start at k = 2
    UU(:, chosenU) = ones(kk, 1);

    for k=1:kk
        [XX(k + 1, :), YY(k, :)]= getObjectOutputState(dA, dB, dC, dD,...
            XX, xpp, nx, UU, upp, nu, ny, InputDelay, k);
    end
    YY = YY(2:end, :); % First element does not belong to the step response
end
