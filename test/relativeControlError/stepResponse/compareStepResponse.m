% Runs step response relative/comparison tests

%!assert(compareStepResponse('1x1RelativeTest', false) < [10^-20, 10^-20])
%!assert(compareStepResponse('1x1', false) < [10^-20, 10^-20])
%!assert(compareStepResponse('1x2', false) < [10^-20, 10^-20])
%!assert(compareStepResponse('2x2', false) < [10^-20, 10^-20])


function [errEq, errState] = compareStepResponse(object, isPlotting)
    Utilities.loadPkgControlInOctave();
    load(Utilities.getObjBinFilePath(Utilities.joinText(object, '.mat')));

    c = Constants();

    % Test parameters
    kk = D;
    % Step assumes that first element will not be used and extends step response
    % by one element
    seconds = (kk - 1) * st;

    Gz = Utilities.getGzFromNumDen(numDen, st);

    %% Reference step response (k, ny, nu)
    w = warning('off', 'all');
    stepResponseMatrix = step(Gz, seconds);
    warning(w);
    % Adjust to step response format used in libmpcalg
    stepResponseRef = Utilities.stepResponseMatrix2Cell(stepResponseMatrix, nu);

    %% Differential equation step response
    stepResponseEq = getStepResponsesEq(ny, nu, InputDelay, A, B, kk);

    %% State system step response
    stepResponseState = getStepResponsesState(nx, ny, nu, InputDelay,...
        dA, dB, dC, dD, kk);

    %% Differences between step responses
    errEq = Utilities.calMatrixError(stepResponseMatrix,...
        Utilities.stepResponseCell2Matrix(stepResponseEq, kk, ny, nu));
    errState = Utilities.calMatrixError(stepResponseMatrix,...
        Utilities.stepResponseCell2Matrix(stepResponseState, kk, ny, nu));

    fprintf('Differential equation step response error: %s\n', num2str(errEq));
    fprintf('State space step response error: %s\n', num2str(errState));

    assert(errEq < c.allowedNumericLimit);
    assert(errState < c.allowedNumericLimit);

    %% Plotting
    % Prepare data structure
    stepResponseCombined = cell(nu, 3);
    for cu = 1:nu
        stepResponseCombined{cu, 1} = stepResponseRef{cu, 1};
        stepResponseCombined{cu, 2} = stepResponseEq{cu, 1};
        stepResponseCombined{cu, 3} = stepResponseState{cu, 1};
    end

    if (isPlotting)
        figure;
        plotStepResponses(stepResponseCombined, st);
        legend({'Reference', 'Differential equation', 'State system'});
    end
end
