function [YY, UU] = getStepResponseNl1x1(ypp, upp, uStep, kk)
    ny = 1;
    nu = 1;
    %% Variable initialisation
    data.data = struct;
    data.YY = ones(kk, ny) * ypp; data.ypp = ypp;
    data.UU = ones(kk, nu) * uStep; data.upp = upp;

    getOutput = getObjectNlFunc('1x1');

    % Compensation for first element not belonging to step response
    for k=1:kk+1
        data.YY(k) = getOutput(data, k);
    end

    % Step starts at k = 1 (matlab indexing),
    % so step response will start at k = 2
    data.YY = data.YY(2:end, ny); % First element does not belong to the step response
    YY = data.YY;
    UU = data.UU;
end
