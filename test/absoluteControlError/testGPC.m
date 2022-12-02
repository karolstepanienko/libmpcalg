% Runs control error tests for GPC algorithm

%!assert(runAlg('1x1', @GPC, 'analytical', false) < 30)
%!assert(runAlg('1x1', @GPC, 'fast', false) < 30)
%!assert(runAlg('1x1', @GPC, 'numerical', false) < 32)

%!assert(runAlg('1x1RelativeTest', @GPC, 'analytical', false) < 175)
%!assert(runAlg('1x1RelativeTest', @GPC, 'fast', false) < 175)
%!assert(runAlg('1x1RelativeTest', @GPC, 'numerical', false) < 606)

%!assert(runAlg('1x2', @GPC, 'analytical', false) < 40)
%!assert(runAlg('1x2', @GPC, 'fast', false) < 40)
%!assert(runAlg('1x2', @GPC, 'numerical', false) < 40)

%!assert(runAlg('2x2', @GPC, 'analytical', false) < 25)
%!assert(runAlg('2x2', @GPC, 'fast', false) < 25)
%!assert(runAlg('2x2', @GPC, 'numerical', false) < 25)
