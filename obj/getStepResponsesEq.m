% Returns all object step responses
function stepResponses = getStepResponsesEq(ny, nu, InputDelay, A, B, kk)
    stepResponses = cell(nu, 1);
    for i=1:nu % for every input
        % kk + 1 because first element does not belong to step response
        stepResponses{i, 1} = getStepResponse(ny, nu, InputDelay, A, B, i, kk+1);
    end
end

% Returns output response for a step on a given input
function YY = getStepResponse(ny, nu, InputDelay, A, B, chosenU, kk)
    %% Variable initialisation
    YY = zeros(kk, ny);
    UU = zeros(kk, nu);
    ypp = 0;
    upp = 0;

    %% Add control step
    % Step starts at k = 1 (matlab indexing),
    % so step response will start at k = 2
    UU(:, chosenU) = ones(kk, 1);

    for k=1:kk
        YY(k, :) = getObjectOutputEq(A, B, YY, ypp, UU, upp, ny, nu, InputDelay, k);
    end
    YY = YY(2:end, :); % First element does not belong to the step response
end
