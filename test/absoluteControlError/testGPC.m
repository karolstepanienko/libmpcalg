% Runs control error tests for GPC algorithm

%!assert(runAlg('1x1', @GPC, 'analytical', false) < 20)
%!assert(runAlg('1x1', @GPC, 'fast', false) < 20)
%!assert(runAlg('1x1', @GPC, 'numerical', false) < 40)

%!assert(runAlg('1x2', @GPC, 'analytical', false) < 20)
%!assert(runAlg('1x2', @GPC, 'fast', false) < 20)
%!assert(runAlg('1x2', @GPC, 'numerical', false) < 20)

%!assert(runAlg('2x2', @GPC, 'analytical', false) < 10)
%!assert(runAlg('2x2', @GPC, 'fast', false) < 10)
%!assert(runAlg('2x2', @GPC, 'numerical', false) < 10)
