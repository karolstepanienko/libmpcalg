function plotStabilisedStepResponses(ny, nu, nStep, stabilisedStepResponses)
    %% Plotting
    line_width = 1.5;
    nPlot = 1;
    % Plot for every input
    axesList = zeros(1, nu);
    for cu=1:nu
        legendContent = {};
        axesList(1, cu) = subplot(ny, nu, nPlot);
        nPlot = nPlot + 1;
        title(Utilities.joinText('u', num2str(cu)))
        hold on
        for cy=1:ny
            plot(stabilisedStepResponses(:, cy, cu), 'LineWidth', line_width);
            legendContent{cy} = Utilities.joinText('y', num2str(cy));
        end
        plot(0:1:nStep, 0:1:nStep, 'k--', 'LineWidth', line_width);
        legendContent{cy + 1} = 'y(x)=x';
        legend(legendContent);
        hold off
        xlabel('U step value');
        ylabel('Y');
    end
end
