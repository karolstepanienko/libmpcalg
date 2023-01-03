% Runs control error tests for GPC algorithm

%!assert(runAlg('1x1', @GPC, 'analytical', false) < 32)
%!assert(runAlg('1x1', @GPC, 'fast', false) < 32)
%!assert(runAlg('1x1', @GPC, 'numerical', false) < 32)

%!assert(runAlg('1x1RelativeTest', @GPC, 'analytical', false) < 304)
%!assert(runAlg('1x1RelativeTest', @GPC, 'fast', false) < 304)
%!assert(runAlg('1x1RelativeTest', @GPC, 'numerical', false) < 304)

%!assert(runAlg('1x2', @GPC, 'analytical', false) < 36)
%!assert(runAlg('1x2', @GPC, 'fast', false) < 36)
%!assert(runAlg('1x2', @GPC, 'numerical', false) < 36)

%!assert(runAlg('2x2', @GPC, 'analytical', false) < 22)
%!assert(runAlg('2x2', @GPC, 'fast', false) < 22)
%!assert(runAlg('2x2', @GPC, 'numerical', false) < 22)

%!assert(runAlg('2x3', @GPC, 'analytical', false) < 4)
%!assert(runAlg('2x3', @GPC, 'fast', false) < 4)
%!assert(runAlg('2x3', @GPC, 'numerical', false) < 4)
