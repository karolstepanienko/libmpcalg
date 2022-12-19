% Runs control error tests for MPCS algorithm

%!assert(runAlg('1x1', @MPCS, 'analytical', false) < 32)
%!assert(runAlg('1x1', @MPCS, 'fast', false) < 32)
%!assert(runAlg('1x1', @MPCS, 'numerical', false) < 32)

%!assert(runAlg('1x1RelativeTest', @MPCS, 'analytical', false) < 801)
%!assert(runAlg('1x1RelativeTest', @MPCS, 'fast', false) < 801)
%!assert(runAlg('1x1RelativeTest', @MPCS, 'numerical', false) < 801)

%!assert(runAlg('1x2', @MPCS, 'analytical', false) < 36)
%!assert(runAlg('1x2', @MPCS, 'fast', false) < 36)
%!assert(runAlg('1x2', @MPCS, 'numerical', false) < 36)

%!assert(runAlg('2x2', @MPCS, 'analytical', false) < 36)
%!assert(runAlg('2x2', @MPCS, 'fast', false) < 36)
%!assert(runAlg('2x2', @MPCS, 'numerical', false) < 36)
