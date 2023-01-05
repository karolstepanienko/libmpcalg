% Runs control error tests for MPCS algorithm

%!assert(runAlg('1x1', @MPCS, 'analytical', false) < 32)
%!assert(runAlg('1x1', @MPCS, 'fast', false) < 32)
%!assert(runAlg('1x1', @MPCS, 'numerical', false) < 32)

%!assert(runAlg('1x1RelativeTest', @MPCS, 'analytical', false) < 801)
%!assert(runAlg('1x1RelativeTest', @MPCS, 'fast', false) < 801)
%!assert(runAlg('1x1RelativeTest', @MPCS, 'numerical', false) < 801)

%!assert(runAlg('1x1Unstable', @MPCS, 'analytical', false) < 26)
%!assert(runAlg('1x1Unstable', @MPCS, 'fast', false) < 26)
%!assert(runAlg('1x1Unstable', @MPCS, 'numerical', false) < 31)

%!assert(runAlg('1x2', @MPCS, 'analytical', false) < 36)
%!assert(runAlg('1x2', @MPCS, 'fast', false) < 36)
%!assert(runAlg('1x2', @MPCS, 'numerical', false) < 36)

%!assert(runAlg('2x2', @MPCS, 'analytical', false) < 36)
%!assert(runAlg('2x2', @MPCS, 'fast', false) < 36)
%!assert(runAlg('2x2', @MPCS, 'numerical', false) < 36)

%!assert(runAlg('2x3', @MPCS, 'analytical', false) < 4)
%!assert(runAlg('2x3', @MPCS, 'fast', false) < 4)
%!assert(runAlg('2x3', @MPCS, 'numerical', false) < 4)
