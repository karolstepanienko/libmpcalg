%% plot_u_separate
% Plots u vectors on one figure. Every input signal gets it's own graph.
% Graphs are alligned horizontally.
function plotUUseparate(UU, st)
    %% Get simulation length (length of vectors in matrix)
    % and number of input vectors
    [K, num_u] = size(UU);
    
    %% Time range for plot
    x_t = 0:st:(K - 1)*st;
    
    %% Defining plot settings
    line_width = 1;
    legend_location = 'northeast';

    %% Plotting output
    figure;
    for i=1:num_u
        subplot(num_u,1,i);
        stairs(x_t, UU(:, i), 'LineWidth', line_width);
        xlabel('t[s]');
        ylabel('u');
        legend(join(['u_', num2str(i)]), 'location', legend_location,...
            'Orientation', 'horizontal')
    end
end
