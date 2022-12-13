%!assert(lambda0MPCS(false, 0, '1x1', 'analytical') < 8)
%!assert(lambda0MPCS(false, 0, '1x1', 'fast') < 8)
%!assert(lambda0MPCS(false, 0, '1x1', 'numerical') < 8)

%!assert(lambda0MPCS(false, 0, '1x1RelativeTest', 'analytical') < 8)
%!assert(lambda0MPCS(false, 0, '1x1RelativeTest', 'fast') < 8)
%!assert(lambda0MPCS(false, 0, '1x1RelativeTest', 'numerical') < 8)

function controlErrMPCS = lambda0MPCS(isPlotting, lambda, object, algType)
    po = Utilities.prepareObjectStruct(lambda, object, algType);

    %% libmpcalg MPCS
    [regMPCS, YMPCS, UMPCS] = getDebugLibmpcalgMPCS(isPlotting, po);
    controlErrMPCS = Utilities.calMatrixError(YMPCS, po.Yzad);

    fprintf('Lambda0 MPCS, (%s), control error: %s\n', object,...
        num2str(controlErrMPCS));
end
