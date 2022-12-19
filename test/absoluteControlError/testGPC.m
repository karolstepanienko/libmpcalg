% Runs control error tests for GPC algorithm

%!assert(runAlg('1x1', @GPC, 'analytical', false) < 32)
%!assert(runAlg('1x1', @GPC, 'fast', false) < 32)
%!assert(runAlg('1x1', @GPC, 'numerical', false) < 32)

%!assert(runAlg('1x1RelativeTest', @GPC, 'analytical', false) < 505)
%!assert(runAlg('1x1RelativeTest', @GPC, 'fast', false) < 505)
%!assert(runAlg('1x1RelativeTest', @GPC, 'numerical', false) < 505)

%!assert(runAlg('1x2', @GPC, 'analytical', false) < 36)
%!assert(runAlg('1x2', @GPC, 'fast', false) < 36)
%!assert(runAlg('1x2', @GPC, 'numerical', false) < 36)

%!assert(runAlg('2x2', @GPC, 'analytical', false) < 25)
%!assert(runAlg('2x2', @GPC, 'fast', false) < 25)
%!assert(runAlg('2x2', @GPC, 'numerical', false) < 25)
