%!assert(lambda0DMC(false, 0, '1x1', 'analytical') < 123)
%!assert(lambda0DMC(false, 0, '1x1', 'fast') < 123)
%!assert(lambda0DMC(false, 0, '1x1', 'numerical') < 123)


function controlErrDMC = lambda0DMC(isPlotting, lambda, object, algType)
    po = Utilities.prepareObjectStruct(lambda, object, algType);

    % Turn off lambda = 0 warnings
    w = warning('off', 'all');
    %% libmpcalg DMC
    [regDMC, YDMC, UDMC] = getDebugLibmpcalgDMC(isPlotting, po);
    controlErrDMC = Utilities.calMatrixError(YDMC, po.Yzad);
    % Turn warnings on
    warning(w);

    fprintf('Lambda0 DMC, (%s), control error: %s\n', object,...
        num2str(controlErrDMC));
end
