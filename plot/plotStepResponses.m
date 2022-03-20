%% plotStepResponses
% Plots step responses in 'step' like fashion
function plotStepResponses(stepResponses)
    nu = length(stepResponses);
    [kk, ny] = size(stepResponses{1});
    nPlot = 1;

    figure;

    % TODO add a manual title to figure
    % sgtitle('(y, u)');
    
    for iy=1:ny
        axesList = zeros(1, nu);
        for ju=1:nu
            axesList(1, ju) = subplot(ny, nu, nPlot);
            nPlot = nPlot + 1;
            stairs(stepResponses{ju, 1}(:, iy))
            title(['y', num2str(iy), ', u', num2str(ju)]);
            xlabel(['From: In(', num2str(ju), ')']);
            ylabel(['To: Out(', num2str(iy), ')']); 
            % set(gca,'xaxisLocation','top');
        end
        if nu > 1
            YstepResponses = Utilities.getYStepResponses(iy, nu, ny,...
                                                        stepResponses, kk);
            sortedAxesList = Utilities.sortAxesList(iy, nu, kk, YstepResponses, axesList);
            linkaxes(sortedAxesList);
        end
    end
end


