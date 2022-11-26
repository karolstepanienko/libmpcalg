% Runs control error tests for GPC algorithm

%!assert(runAlg('1x1', @GPC, 'analytical', false) < 20)
%!assert(runAlg('1x1', @GPC, 'fast', false) < 20)
%!assert(runAlg('1x1', @GPC, 'numerical', false) < 21)

%!assert(runAlg('1x2', @GPC, 'analytical', false) < 20)
%!assert(runAlg('1x2', @GPC, 'fast', false) < 20)
%!assert(runAlg('1x2', @GPC, 'numerical', false) < 21)

%!assert(runAlg('2x2', @GPC, 'analytical', false) < 15)
%!assert(runAlg('2x2', @GPC, 'fast', false) < 15)
%!assert(runAlg('2x2', @GPC, 'numerical', false) < 15)
