%% plotRun
% Plots run results
function plotRun(YY, Yzad, UU, st, ny, nu, algName,...
    varargin)
    if size(varargin, 1) == 0 algType = '';
    else algType = varargin{1}; end

    plotTitle = Utilities.getPlotTitle(algName, algType);

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
