addpath('../test');
st = 0.1; % Sampling time
obj = get3x2Obj(st);
stepResponses = obj.getStepResponses(100);

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
