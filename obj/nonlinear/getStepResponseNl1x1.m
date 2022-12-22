function [Y, U] = getStepResponseNl1x1(ypp, upp, uStep, kk)
    ny = 1;
    nu = 1;
    %% Variable initialisation
    Y = ones(kk, ny) * ypp;
    U = ones(kk, nu) * uStep;

    % Compensation for first element not belonging to step response
    for k=1:kk+1
        Y(k) = getObjectOutputNl('1x1', ypp, Y, upp, U, k);
    end

    % Step starts at k = 1 (matlab indexing),
    % so step response will start at k = 2
    Y = Y(2:end, ny); % First element does not belong to the step response
end
