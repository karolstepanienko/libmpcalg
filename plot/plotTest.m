%% plotTest
% Plots test results
function plotTest(YY, Yzad, UU, st, ny, nu, plotTitle)
    fig = figure;
    
    ynPlot = max(ny, nu);
    % For 1x1 object number of plots has to be 2
    if ynPlot == 1
        unPlot = 2;
    else
        unPlot = ynPlot;
    end
    plotYYseparate(YY, Yzad, st, ynPlot, unPlot);
    plotUUseparate(UU, st, ny, ynPlot, unPlot);

    % Applying figure title
    if Utilities.isOctave()
        axes( 'visible', 'off', 'title', plotTitle);
    else
        sgtitle(plotTitle);
    end

    Utilities.closeFigAfterTimeout(fig);
end
