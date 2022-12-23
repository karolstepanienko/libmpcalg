%% plotStepResponses
% Plots step responses in 'step' like fashion
function plotStepResponses(stepResponses, st)
    nu = size(stepResponses, 1);
    nCompare = size(stepResponses, 2);
    [kk, ny] = size(stepResponses{1});
    nPlot = 1;

    % TODO add a manual title to figure
    % sgtitle('(y, u)');

    for iy=1:ny
        axesList = zeros(1, nu);
        for ju=1:nu
            axesList(1, ju) = subplot(ny, nu, nPlot);
            nPlot = nPlot + 1;
            hold on
            for cnc = 1:nCompare
                stairs(stepResponses{ju, cnc}(:, iy), 'LineWidth',...
                    nCompare + 1 - cnc);
            end
            hold off
            title(['y', num2str(iy), ', u', num2str(ju)]);
            xlabel(['From: In(', num2str(ju), ')']);
            ylabel(['To: Out(', num2str(iy), ')']);
            % set(gca,'xaxisLocation','top');
            xt = get(gca, 'XTick');  % 'XTick' Values
            % Relabel 'XTick' With 'XTickLabel' Values
            set(gca, 'XTick', xt, 'XTickLabel', xt*st);
        end
        if nu > 1
            YstepResponses = Utilities.getYStepResponses(iy, nu, ny,...
                                                        stepResponses, kk);
            sortedAxesList = Utilities.sortAxesList(nu, kk, YstepResponses,...
                axesList);
            linkaxes(sortedAxesList);
        end
    end
end
