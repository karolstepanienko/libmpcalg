% Runs control error tests for MPCS algorithm

%!assert(runAlg('1x1', @MPCS, 'analytical', false) < 40)

%!assert(runAlg('1x2', @MPCS, 'analytical', false) < 19)

%!assert(runAlg('2x2', @MPCS, 'analytical', false) < 19)
