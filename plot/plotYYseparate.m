%% plot_y_separate
% Plots y vectors on one figure. Every output signal gets it's own graph.
% Graphs are alligned horizontally.
function plotYYseparate(YY, YY_zad, st, ynPlot, unPlot)
    %% Get simulation length (length of vectors in matrix)
    % and number of output vectors
    [K, ny] = size(YY);
    
    %% Time range for plot
    x_t = 0:st:(K - 1)*st;
    
    %% Defining plot settings
    line_width = 1.5;
    legend_location = 'northeast';
    axesList = zeros(1, ny);

    % Max value for every Y
    maxYValues = zeros(ny, 1);

    %% Plotting output
    for i=1:ny
        axesList(1, i) = subplot(ynPlot, unPlot, i);
        % axesList(1, i) = nexttile;
        hold on
            stairs(x_t, YY(:,i), 'LineWidth', line_width);
            stairs(x_t, YY_zad(:,i), '--', 'LineWidth', line_width,...
                'Color', [0.8500 0.3250 0.0980]);
        hold off
        xlabel('t[s]');
        ylabel('y');
        legend(['y_', num2str(i)], 'Y^{zad}', 'location', legend_location,...
            'Orientation', 'horizontal');

        maxYValues(i) = max(max(abs(YY(:, i)), abs(YY_zad(:, i))));
    end
    %% Enforcing the same limits
    if ny > 1
        sortedAxesList = Utilities.sortAxes(maxYValues, axesList);
        linkaxes(sortedAxesList);
    end
end
