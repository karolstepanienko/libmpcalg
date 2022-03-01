

st = 0.1; % Sampling time
obj = MIMOObj(A, B, C, D, st);
stepResponses = obj.getStepResponses();

%% Plotting
for i=1:obj.nu
    figure;
    hold on
    for j=1:obj.ny
        plot(stepResponses{i, 1}(:,j));
    end
    hold off
end
