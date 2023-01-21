% Runs control error tests for MPCNO algorithm

%!assert(runAlg('1x1', @MPCNO, '', false) < 31)
%!assert(runAlg('1x1RelativeTest', @MPCNO, '', false) < 1000)
%!assert(runAlg('1x1Unstable', @MPCNO, '', false) < 30)
%!assert(runAlg('1x2', @MPCNO, '', false) < 28)
%!assert(runAlg('2x2', @MPCNO, '', false) < 17)
%!assert(runAlg('2x3', @MPCNO, '', false) < 4)

% Nonlinear objects
%!assert(runMPCNO('1x1', false) < 17)
%!assert(runMPCNO('2x3', false) < 4)
%!assert(runMPCNOk('1x1', false) < 17)
%!assert(runMPCNOk('2x3', false) < 4)
