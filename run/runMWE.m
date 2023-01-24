%% runMWE
% MWE scripts wrapper for Octave tests
function e = runMWE(func)
    [YYzad, YY, ~] = func();
    e = Utilities.calMatrixError(YYzad, YY);
end
