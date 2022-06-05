%% plot_u_separate
% Plots u vectors on one figure. Every input signal gets it's own graph.
% Graphs are aligned horizontally.
function plotUUseparate(UU, st, ny, ynPlot, unPlot)
    %% Get simulation length (length of vectors in matrix)
    % and number of input vectors
    [K, nu] = size(UU);
    
    %% Time range for plot
    x_t = 0:st:(K - 1)*st;
    
    %% Defining plot settings
    line_width = 1.5;
    legend_location = 'northeast';
    axesList = zeros(1, nu);

    % Max value for every U
    maxUValues = zeros(nu, 1);

    %% Plotting output
    for i=1:nu
        axesList(1, i) = subplot(ynPlot, unPlot, i + ny);
        % axesList(1, i) = nexttile;
        stairs(x_t, UU(:, i), 'LineWidth', line_width);
        xlabel('t[s]');
        ylabel('u');
        legend(['u_', num2str(i)], 'location', legend_location,...
            'Orientation', 'horizontal');
        
        maxUValues(i) = max(abs(UU(:, i)));
    end
    if nu > 1
        sortedAxesList = Utilities.sortAxes(maxUValues, axesList);
        linkaxes(sortedAxesList);
    end
end
