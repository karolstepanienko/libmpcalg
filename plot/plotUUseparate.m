%% plot_u_separate
% Plots u vectors on one figure. Every input signal gets it's own graph.
% Graphs are alligned horizontally.
function uFig = plotUUseparate(UU, st)
    %% Get simulation length (length of vectors in matrix)
    % and number of input vectors
    [K, nu] = size(UU);
    
    %% Time range for plot
    x_t = 0:st:(K - 1)*st;
    
    %% Defining plot settings
    line_width = 1.5;
    legend_location = 'northeast';
    axesList = zeros(1, nu);

    %% Plotting output
    uFig = figure;
    for i=1:nu
        axesList(1, i) = subplot(nu,1,i);
        stairs(x_t, UU(:, i), 'LineWidth', line_width);
        xlabel('t[s]');
        ylabel('u');
        legend(['u_', num2str(i)], 'location', legend_location,...
            'Orientation', 'horizontal')
    end
    if nu > 1
        linkaxes(axesList);
    end
end

% TODO sort axes for vectors
