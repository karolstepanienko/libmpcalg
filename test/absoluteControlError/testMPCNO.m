% Runs control error tests for MPCNO algorithm

%!assert(runAlg('1x1', @MPCNO, '', false) < 30)
%!assert(runAlg('1x1RelativeTest', @MPCNO, '', false) < 1000)
%!assert(runAlg('1x1Unstable', @MPCNO, '', false) < 28)
%!assert(runAlg('1x2', @MPCNO, '', false) < 33)
%!assert(runAlg('2x2', @MPCNO, '', false) < 51)
%!assert(runAlg('2x3', @MPCNO, '', false) < 4)
