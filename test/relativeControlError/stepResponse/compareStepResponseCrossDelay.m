%% compareStepResponseCrossDelay
% Test runs only in MATLAB due to Octave method 'step' limitations
function [errEq, errState] = compareStepResponseCrossDelay(object, isPlotting)
    % compareStepResponseCrossDelay('2x2Cross', true);
    Utilities.loadPkgControlInOctave();
    c = Constants();
    load(Utilities.getObjBinFilePath(Utilities.joinText(object, '.mat')));

    % Test parameters
    kk = D;
    % Step assumes that first element will not be used and extends step response
    % by one element
    seconds = (kk - 1) * st;

    %% Reference step response (k, ny, nu)
    w = warning('off', 'all');
    stepResponseMatrix = step(Gz, seconds);
    warning(w);

    % Adjust to step response format used in libmpcalg
    stepResponseRef = Utilities.stepResponseMatrix2Cell(stepResponseMatrix,...
        nu);

    %% Differential equation step response
    stepResponseEq = getStepResponsesEq(ny, nu, IODelay, A,...
        B, kk);

    %% State system step response
    stepResponseState = getStepResponsesState(nx, ny, nu,...
        InputDelay, OutputDelay, dA, dB, dC, dD, kk);

    %% Differences between step responses
    errEq = Utilities.calMatrixError(stepResponseMatrix,...
        Utilities.stepResponseCell2Matrix(stepResponseEq, kk, ny, nu));
    errState = Utilities.calMatrixError(stepResponseMatrix,...
        Utilities.stepResponseCell2Matrix(stepResponseState, kk, ny,...
        nu));

    assert(errEq < c.allowedNumericLimit);
    assert(errState < c.allowedNumericLimit);

    % Plotting
    if isPlotting
        figure;
        hold on
            plotStepResponses(stepResponseRef, st);
            plotStepResponses(stepResponseEq, st);
            plotStepResponses(stepResponseState, st);
            legend({'Reference', 'Differential equation', 'State system'});
        hold off
    end
end
