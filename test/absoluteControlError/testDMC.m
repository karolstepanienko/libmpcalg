% Runs control error tests for DMC algorithm

%!assert(runAlg('1x1', @DMC, 'analytical', false) < 20)
%!assert(runAlg('1x1', @DMC, 'fast', false) < 20)
%!assert(runAlg('1x1', @DMC, 'numerical', false) < 40)

%!assert(runAlg('1x2', @DMC, 'analytical', false) < 20)
%!assert(runAlg('1x2', @DMC, 'fast', false) < 20)
%!assert(runAlg('1x2', @DMC, 'numerical', false) < 20)

%!assert(runAlg('2x2', @DMC, 'analytical', false) < 10)
%!assert(runAlg('2x2', @DMC, 'fast', false) < 10)
%!assert(runAlg('2x2', @DMC, 'numerical', false) < 10)
