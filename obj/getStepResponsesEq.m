% Returns all object step responses
function stepResponses = getStepResponsesEq(ny, nu, IODelay, A, B, kk)
    stepResponses = cell(nu, 1);
    for i=1:nu % for every input
        % kk + 1 because first element does not belong to step response
        stepResponses{i, 1} = getStepResponse(ny, nu, IODelay, A, B, i,...
            kk);
    end
end

% Returns output response for a step on a given input
function YY = getStepResponse(ny, nu, IODelay, A, B, chosenU, kk)
    c = Constants();
    %% Variable initialisation
    ypp = c.testYInitVal;
    upp = c.testUInitVal;
    YY = ones(kk, ny) * ypp;
    UU = ones(kk, nu) * upp;

    %% Add control step
    % Step starts at k = 1 (matlab indexing),
    % so step response will start at k = 2
    UU(:, chosenU) = ones(kk, 1);

    for k=1:kk
        YY(k, :) = getObjectOutputEq(A, B, YY, ypp, UU, upp, ny, nu,...
            IODelay, k);
    end
end
