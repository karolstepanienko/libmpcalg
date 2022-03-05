function testStepResponse(objFunc, st, kk)
    addpath('../../src');
    addpath('../../obj');
    obj = objFunc(st);
    stepResponses = obj.getStepResponses(kk);
    

    %% Plotting
    for i=1:obj.nu
        figure;
        hold on
        for j=1:obj.ny
            plot(stepResponses{i, 1}(:,j));
            title(join(['In: ', num2str(i)]));
        end
        hold off
    end
end
