function stepResponses = getStepResponsesState(nx, ny, nu, dA, dB, dC, dD, kk)
    stepResponses = cell(nu, 1);
    for i=1:nu % for every input
        % kk + 1 because first element does not belong to step response
        stepResponses{i, 1} = getStepResponse(nx, ny, nu, dA, dB, dC, dD, i, kk+1);
    end
end

% Returns output response for a step on a given input
function YY = getStepResponse(nx, ny, nu, dA, dB, dC, dD, chosenU, kk)
    %% Variable initialisation
    XX = zeros(kk, nx);
    YY = zeros(kk, ny);
    UU = zeros(kk, nu);
    xpp = 0;
    ypp = 0;
    upp = 0;

    %% Add control step
    % Step starts at k = 1 (matlab indexing),
    % so step response will start at k = 2
    UU(:, chosenU) = ones(kk, 1);

    for k=1:kk
        [XX(k, :), YY(k, :)]= getObjectOutputState(dA, dB, dC, dD, XX, xpp, nx, UU, upp, nu, ny, k);
    end
    YY = YY(2:end, :); % First element does not belong to the step response
end
