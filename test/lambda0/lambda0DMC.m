%!assert(lambda0DMC(false, 0, '1x1', 'analytical') < 123)
%!assert(lambda0DMC(false, 0, '1x1', 'fast') < 123)
%!assert(lambda0DMC(false, 0, '1x1', 'numerical') < 123)


function controlErrDMC = lambda0DMC(isPlotting, lambda, object, algType)
    po = Utilities.prepareObjectStruct(lambda, object, algType);

    %% libmpcalg DMC
    [regDMC, YDMC, UDMC] = getDebugLibmpcalgDMC(isPlotting, po);
    controlErrDMC = Utilities.calMatrixError(YDMC, po.Yzad);

    fprintf('Lambda0 DMC, (%s), control error: %s\n', object,...
        num2str(controlErrDMC));
end
