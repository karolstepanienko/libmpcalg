% Runs control error tests for DMC algorithm

%!assert(runAlg('1x1', @DMC, 'analytical', false) < 32)
%!assert(runAlg('1x1', @DMC, 'fast', false) < 32)
%!assert(runAlg('1x1', @DMC, 'numerical', false) < 32)

%!assert(runAlg('1x1RelativeTest', @DMC, 'analytical', false) < 505)
%!assert(runAlg('1x1RelativeTest', @DMC, 'fast', false) < 505)
%!assert(runAlg('1x1RelativeTest', @DMC, 'numerical', false) < 505)

%!assert(runAlg('1x2', @DMC, 'analytical', false) < 36)
%!assert(runAlg('1x2', @DMC, 'fast', false) < 36)
%!assert(runAlg('1x2', @DMC, 'numerical', false) < 36)

%!assert(runAlg('2x2', @DMC, 'analytical', false) < 25)
%!assert(runAlg('2x2', @DMC, 'fast', false) < 25)
%!assert(runAlg('2x2', @DMC, 'numerical', false) < 25)
