function [YY, UU] = getStepResponseNl2x3(ypp, upp, uStep, chosenU, kk)
    ny = 2;
    nu = 3;
    %% Variable initialisation
    YY = ones(kk, ny) * ypp;
    UU = ones(kk, nu) * upp;
    % Control step only on chosen input
    UU(:, chosenU) = ones(kk, 1) * uStep;

    % Compensation for first element not belonging to step response
    for k=1:kk+1
        YY(k, :) = getObjectOutputNl('2x3', ypp, YY, upp, UU, k);
    end

    % Step starts at k = 1 (matlab indexing),
    % so step response will start at k = 2
    YY = YY(2:end, :); % First element does not belong to the step response
end
