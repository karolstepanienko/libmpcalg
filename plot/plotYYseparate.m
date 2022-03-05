%% plot_y_separate
% Plots y vectors on one figure. Every output signal gets it's own graph.
% Graphs are alligned horizontally.
function plotYYseparate(YY, YY_zad, st)
    %% Get simulation length (length of vectors in matrix)
    % and number of output vectors
    [K, num_y] = size(YY);
    
    %% Time range for plot
    x_t = 0:st:(K - 1)*st;
    
    %% Defining plot settings
    line_width = 1;
    legend_location = 'northeast';
    axes_list = zeros(num_y, 1);

    %% Plotting output
    figure;
    for i=1:num_y
        axes_list(i, 1) = subplot(num_y,1,i);
        hold on
            stairs(x_t, YY(:,i), 'LineWidth', line_width);
            stairs(x_t, YY_zad(:,i), '--', 'LineWidth', line_width, 'Color', '#D95319');
        hold off
        xlabel('t[s]');
        ylabel('y');
        legend(join(['y_', num2str(i)]), 'Y^{zad}', 'location', legend_location,...
            'Orientation', 'horizontal')
    end
    %% Enforcing the same limits
    linkaxes(axes_list);
end
