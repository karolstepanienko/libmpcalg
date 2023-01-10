function [YY, UU] = getStepResponseNl2x3(ypp, upp, uStep, chosenU, kk)
    ny = 2;
    nu = 3;
    %% Variable initialisation
    data.data = struct;
    data.YY = ones(kk, ny) * ypp; data.ypp = ypp;
    data.UU = ones(kk, nu) * upp; data.upp = upp;
    % Control step only on chosen input
    data.UU(:, chosenU) = ones(kk, 1) * uStep;

    getOutput = getObjectNlFunc('2x3');

    % Compensation for first element not belonging to step response
    for k=1:kk+1
        data.YY(k, :) = getOutput(data, k);
    end

    % Step starts at k = 1 (matlab indexing),
    % so step response will start at k = 2
    data.YY = data.YY(2:end, :); % First element does not belong to the step response
    YY = data.YY;
    UU = data.UU;
end
