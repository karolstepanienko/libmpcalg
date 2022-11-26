% Runs control error tests for MPCS algorithm

%!assert(runAlg('1x1', @MPCS, 'analytical', false) < 40)
%!assert(runAlg('1x1', @MPCS, 'fast', false) < 40)
%!assert(runAlg('1x1', @MPCS, 'numerical', false) < 40)

%!assert(runAlg('1x2', @MPCS, 'analytical', false) < 75)
%!assert(runAlg('1x2', @MPCS, 'fast', false) < 75)
%!assert(runAlg('1x2', @MPCS, 'numerical', false) < 55)

%!assert(runAlg('2x2', @MPCS, 'analytical', false) < 20)
%!assert(runAlg('2x2', @MPCS, 'fast', false) < 20)
%!assert(runAlg('2x2', @MPCS, 'numerical', false) < 20)
