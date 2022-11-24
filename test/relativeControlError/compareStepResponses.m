function compareStepResponses(isPlotting)
    [obj, Gz, InputDelay] = get1x1RelativeTestObj();  % Object

    % Test parameters
    kk = 300;

    %% Reference step response
    [Y,T] = step(Gz, 300);
    % Removing first element of step response
    Y = Y(2:end);
    T = T(2:end);

    %% Differential equation step response
    stepResponseEq = getStepResponsesEq(obj.ny, obj.nu, InputDelay, obj.A, obj.B, kk);
    err = Utilities.calculateError(Y, stepResponseEq{1})

    %% State system step response
    stepResponseState = getStepResponsesState(obj.nx, obj.ny, obj.nu, InputDelay, obj.dA, obj.dB, obj.dC, obj.dD, kk);
    err = Utilities.calculateError(Y, stepResponseState{1})

    %% Plotting
    if (isPlotting)
        figure;
        hold on
        stairs(T, Y);
        stairs(T, stepResponseEq{1});
        stairs(T, stepResponseState{1});
        hold off
        legend({'Reference', 'Differential equation', 'State system'});
    end
end
