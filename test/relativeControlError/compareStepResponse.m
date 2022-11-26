% Runs step response relative/comparison tests

%!assert(compareStepResponse('1x1RelativeTest', false) < [Constants.getAllowedNumericLimit(), Constants.getAllowedNumericLimit()])
%!assert(compareStepResponse('1x1', false) < [Constants.getAllowedNumericLimit(), Constants.getAllowedNumericLimit()])
%!assert(compareStepResponse('1x2', false) < [Constants.getAllowedNumericLimit(), Constants.getAllowedNumericLimit()])
%!assert(compareStepResponse('2x2', false) < [Constants.getAllowedNumericLimit(), Constants.getAllowedNumericLimit()])


function [errEq, errState] = compareStepResponse(object, isPlotting)
    Utilities.loadPkgControlInOctave();
    load(Utilities.getObjBinFilePath(Utilities.joinText(object, '.mat')));

    % Test parameters
    kk = D;
    seconds = kk * st;

    Gz = Utilities.getGzFromNumDen(numDen, st);

    %% Reference step response (k, ny, nu)
    stepResponseRef = step(Gz, seconds);
    % Removing first element of step response
    stepResponseRef = stepResponseRef(2:end, :, :);
    % Adjust to step response format used in libmpcalg
    stepResponseRef = formatStepResponse(stepResponseRef, nu);

    %% Differential equation step response
    stepResponseEq = getStepResponsesEq(ny, nu, InputDelay, A, B, kk);    

    %% State system step response
    stepResponseState = getStepResponsesState(nx, ny, nu, InputDelay,...
        dA, dB, dC, dD, kk);

    %% Differences between step responses
    errEq = 0;
    errState = 0;
    for cu = nu
        errEq = errEq + Utilities.calculateError(...
            stepResponseRef{cu}, stepResponseEq{cu});
        errState = errState + Utilities.calculateError(...
            stepResponseRef{cu}, stepResponseState{cu});
    end
    fprintf('Differential equation step response error: %s\n', num2str(errEq));
    fprintf('State space step response error: %s\n', num2str(errState));

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

function stepResponse = formatStepResponse(stepResponseRef, nu)
    stepResponse = cell(nu, 1);
    for cu = 1:nu
        stepResponse{cu} = stepResponseRef(:, :, cu);
    end
end
