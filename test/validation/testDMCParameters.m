%------------------------------------- D ---------------------------------------
% isnumeric
%!error <DMC: failed validation of D with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('D', '2');

% isscalar (is not a matrix)
%!error <DMC: failed validation of D with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('D', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <DMC: failed validation of D with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('D', 1.1);

% isPositive (x > 0)
%!error <DMC: failed validation of D with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('D', -1);


%------------------------------------- N ---------------------------------------
% isnumeric
%!error <DMC: failed validation of N with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('N', '2');

% isscalar (is not a matrix)
%!error <DMC: failed validation of N with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('N', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <DMC: failed validation of N with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('N', 1.1);

% isPositive (x > 0)
%!error <DMC: failed validation of N with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('N', -1);


%------------------------------------- Nu --------------------------------------
% isnumeric
%!error <DMC: failed validation of NU with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('Nu', '2');

% isscalar (is not a matrix)
%!error <DMC: failed validation of NU with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('Nu', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <DMC: failed validation of NU with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('Nu', 1.1);

% isPositive (x > 0)
%!error <DMC: failed validation of NU with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('Nu', -1);


%-------------------------------------- ny -------------------------------------
% isnumeric
%!error <DMC: failed validation of NUMBEROFOUTPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('ny', '2');

% isscalar (is not a matrix)
%!error <DMC: failed validation of NUMBEROFOUTPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('ny', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <DMC: failed validation of NUMBEROFOUTPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('ny', 1.1);

% isPositive (x > 0)
%!error <DMC: failed validation of NUMBEROFOUTPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('ny', -1);


%------------------------------------- nu --------------------------------------
% isnumeric
%!error <DMC: failed validation of NUMBEROFINPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('nu', '2');

% isscalar (is not a matrix)
%!error <DMC: failed validation of NUMBEROFINPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('nu', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <DMC: failed validation of NUMBEROFINPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('nu', 1.1);

% isPositive (x > 0)
%!error <DMC: failed validation of NUMBEROFINPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('nu', -1);


%------------------------------- stepResponses ---------------------------------
% isCell
%!error <DMC: failed validation of STEPRESPONSES with @\(x\) iscell \(x\) && !isempty \(x\)> testDMCParameters('stepResponses', 1)

% is not empty
%!error <DMC: failed validation of STEPRESPONSES with @\(x\) iscell \(x\) && !isempty \(x\)> testDMCParameters('stepResponses', cell())

% invalid number of inputs
%!error <Malformed step responses cell. Number of inputs \(2\) doesn't match the number of inputs \(1\) in provided step responses cell> testDMCParameters('stepResponses', { 1, 1 })

% invalid number of outputs
%!error <Malformed step responses cell. Number of outputs \(2\) doesn't match the number of outputs \(1\) in provided step responses cell> testDMCParameters('stepResponses', { 1; 1 })

% Warn about stepResponses shorter than dynamic horizon D
%!warning <Step response for combination of input \(2\) and output \(2\) is shorter \(1\) than dynamic horizon D=300. Assumed constant step response equal to last known element.> testDMCParameters('stepResponses', {[1 1]; [1 1]})


%-------------------------------------- mi -------------------------------------
% is Horizontal
%!error <Array mi should be horizontal> testDMCParameters('mi', [1; 1])

% has ny Elements
%!error <Array mi should have \(2\) elements> testDMCParameters('mi', [1])


%------------------------------------ lambda -----------------------------------
% is Horizontal
%!error <Array lambda should be horizontal> testDMCParameters('lambda', [1; 1])

% has ny Elements
%!error <Array lambda should have \(2\) elements> testDMCParameters('lambda', [1])


%-------------------------------------- uMin -----------------------------------
% isnumeric
%!error <DMC: failed validation of UMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testDMCParameters('uMin', '2');

% isscalar (is not a matrix)
%!error <DMC: failed validation of UMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testDMCParameters('uMin', [1, 1]);

% Value has a type of 'double'
%!error <DMC: failed validation of UMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testDMCParameters('uMin', int8(1));


%-------------------------------------- uMax -----------------------------------
% isnumeric
%!error <DMC: failed validation of UMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testDMCParameters('uMax', '2');

% isscalar (is not a matrix)
%!error <DMC: failed validation of UMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testDMCParameters('uMax', [1, 1]);

% Value has a type of 'double'
%!error <DMC: failed validation of UMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testDMCParameters('uMax', int8(1));


%------------------------------------- duMin -----------------------------------
% isnumeric
%!error <DMC: failed validation of DUMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isNegativeOrEqualToZero \(x\)> testDMCParameters('duMin', '2');

% isscalar (is not a matrix)
%!error <DMC: failed validation of DUMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isNegativeOrEqualToZero \(x\)> testDMCParameters('duMin', [1, 1]);

% Value has a type of 'double'
%!error <DMC: failed validation of DUMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isNegativeOrEqualToZero \(x\)> testDMCParameters('duMin', int8(1));

% Value <= 0
%!error <DMC: failed validation of DUMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isNegativeOrEqualToZero \(x\)> testDMCParameters('duMin', 1);


%------------------------------------- duMax -----------------------------------
% isnumeric
%!error <DMC: failed validation of DUMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isPositiveOrEqualToZero \(x\)> testDMCParameters('duMax', '2');

% isscalar (is not a matrix)
%!error <DMC: failed validation of DUMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isPositiveOrEqualToZero \(x\)> testDMCParameters('duMax', [1, 1]);

% Value has a type of 'double'
%!error <DMC: failed validation of DUMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isPositiveOrEqualToZero \(x\)> testDMCParameters('duMax', int8(1));

% Value >= 0
%!error <DMC: failed validation of DUMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isPositiveOrEqualToZero \(x\)> testDMCParameters('duMax', -1);


%------------------------------------- yMin ------------------------------------
% isnumeric
%!error <DMC: failed validation of YMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testDMCParameters('yMin', '2');

% isscalar (is not a matrix)
%!error <DMC: failed validation of YMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testDMCParameters('yMin', [1, 1]);

% Value has a type of 'double'
%!error <DMC: failed validation of YMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testDMCParameters('yMin', int8(1));

% Not accessible in analyticalAlgType
%!error <DMC: argument 'YMIN' is not a valid parameter> testDMCParameters('algType', Constants().analyticalAlgType);

% Not accessible in fastAlgType
%!error <DMC: argument 'YMIN' is not a valid parameter> testDMCParameters('algType', Constants().fastAlgType);


%------------------------------------- yMax ------------------------------------
% isnumeric
%!error <DMC: failed validation of YMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testDMCParameters('yMax', '2');

% isscalar (is not a matrix)
%!error <DMC: failed validation of YMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testDMCParameters('yMax', [1, 1]);

% Value has a type of 'double'
%!error <DMC: failed validation of YMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testDMCParameters('yMax', int8(1));


%------------------------------------ algType ----------------------------------
% algType can be analytical, fast or numerical
%!error <validatestring: 'something' does not match any of\nanalytical, fast, numerical> testDMCParameters('algType', 'something');


function testDMCParameters(valueName, testValue)
    %% Object
    % Setting sampling time -> ../../obj/get2x2.m
    load(Utilities.getObjBinFilePath('2x2.mat'));

    c = Constants();

    algType = c.numericalAlgType;

    % Get D number of elements of object step response
    stepResponses = getStepResponsesEq(ny, nu, InputDelay, A, B, D);

    % Assign test values
    if strcmp(valueName, 'D')
        D = testValue;
    elseif strcmp(valueName, 'N')
        N = testValue;
    elseif strcmp(valueName, 'Nu')
        Nu = testValue;
    elseif strcmp(valueName, 'ny')
        ny = testValue;
    elseif strcmp(valueName, 'nu')
        nu = testValue;
    elseif strcmp(valueName, 'stepResponses')
        stepResponses = testValue;
    elseif strcmp(valueName, 'mi')
        mi = testValue;
    elseif strcmp(valueName, 'lambda')
        lambda = testValue;
    elseif strcmp(valueName, 'uMin')
        uMin = testValue;
    elseif strcmp(valueName, 'uMax')
        uMax = testValue;
    elseif strcmp(valueName, 'duMin')
        duMin = testValue;
    elseif strcmp(valueName, 'duMax')
        duMax = testValue;
    elseif strcmp(valueName, 'yMin')
        yMin = testValue;
    elseif strcmp(valueName, 'yMax')
        yMax = testValue;
    elseif strcmp(valueName, 'algType')
        algType = testValue;
    end

    % Regulator
    reg = DMC(D, N, Nu, ny, nu, stepResponses,...
        'mi', mi, 'lambda', lambda,...
        'uMin', uMin, 'uMax', uMax,...
        'duMin', duMin, 'duMax', duMax,...
        'yMin', yMin, 'yMax', yMax,...
        'algType', algType);
end
