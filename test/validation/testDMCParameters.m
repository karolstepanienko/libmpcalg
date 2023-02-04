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


%-------------------------------------- nz -------------------------------------
% isnumeric
%!error <DMC: failed validation of NZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('nz', '2');

% isscalar (is not a matrix)
%!error <DMC: failed validation of NZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('nz', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <DMC: failed validation of NZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('nz', 1.1);

% isPositive (x > 0)
%!error <DMC: failed validation of NZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('nz', -1);


%----------------------------------- nz_assign ---------------------------------
%!error <Some required parameters \('nz', 'Dz', 'stepResponsesZ'\) for DMC disturbance mechanism were left unassigned> testDMCParameters('nz_assign', 1)


%------------------------------------- Dz ---------------------------------------
% isnumeric
%!error <DMC: failed validation of DZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('Dz', '2');

% isscalar (is not a matrix)
%!error <DMC: failed validation of DZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('Dz', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <DMC: failed validation of DZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('Dz', 1.1);

% isPositive (x > 0)
%!error <DMC: failed validation of DZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testDMCParameters('Dz', -1);


%----------------------------------- Dz_assign ---------------------------------
%!error <Some required parameters \('nz', 'Dz', 'stepResponsesZ'\) for DMC disturbance mechanism were left unassigned> testDMCParameters('Dz_assign', 1)


%------------------------------- stepResponsesZ ---------------------------------
% isCell
%!error <DMC: failed validation of STEPRESPONSESZ with @\(x\) iscell \(x\) && !isempty \(x\)> testDMCParameters('stepResponsesZ', 1)

% is not empty
%!error <DMC: failed validation of STEPRESPONSESZ with @\(x\) iscell \(x\) && !isempty \(x\)> testDMCParameters('stepResponsesZ', cell())

% invalid number of inputs
%!error <Malformed step responses cell. Number of inputs \(2\) doesn't match the number of inputs \(1\) in provided step responses cell> testDMCParameters('stepResponsesZ', { 1, 1 })

% invalid number of outputs
%!error <Malformed step responses cell. Number of outputs \(2\) doesn't match the number of outputs \(1\) in provided step responses cell> testDMCParameters('stepResponsesZ', { 1; 1 })

% Warn about stepResponses shorter than dynamic horizon D
%!warning <Step response for combination of input \(2\) and output \(2\) is shorter \(1\) than dynamic horizon D=300. Assumed constant step response equal to last known element.> testDMCParameters('stepResponsesZ', {[1 1]; [1 1]})


%----------------------------- stepResponsesZ_assign ---------------------------
%!error <Some required parameters \('nz', 'Dz', 'stepResponsesZ'\) for DMC disturbance mechanism were left unassigned> testDMCParameters('stepResponsesZ_assign', {1, 1})


%-------------------------------------- mi -------------------------------------
% isnumeric
%!error <DMC: failed validation of MI with isnumeric> testDMCParameters('mi', '2');

% stretch single element
%!warning <Assumed array mi consists of 2 elements with a value of 1> testDMCParameters('mi', 1)

% has ny Elements
%!error <Array mi should have \(2\) elements> testDMCParameters('mi', [1, 1, 1])

% can be horizontal
%!test(testDMCParameters('mi', [1, 1]))

% can be vertical
%!test(testDMCParameters('mi', [1; 1]))

% is not a matrix
%!error <Value mi should be a horizontal or vertical array with 2 elements> (testDMCParameters('mi', [1, 1; 1, 1]))


%------------------------------------ lambda -----------------------------------
% isnumeric
%!error <DMC: failed validation of LAMBDA with isnumeric> testDMCParameters('lambda', '2');

% lambda = 0
%!warning <Lambda value set to 0. Regulator might be unstable.> testDMCParameters('lambda', [0, 0])

% stretch single element
%!warning <Assumed array lambda consists of 2 elements with a value of 1> testDMCParameters('lambda', 1)

% has nu Elements
%!error <Array lambda should have \(2\) elements> testDMCParameters('lambda', [1, 1, 1])

% can be horizontal
%!test(testDMCParameters('lambda', [1, 1]))

% can be vertical
%!test(testDMCParameters('lambda', [1; 1]))

% is not a matrix
%!error <Value lambda should be a horizontal or vertical array with 2 elements> (testDMCParameters('lambda', [1, 1; 1, 1]))


%-------------------------------------- uMin -----------------------------------
% isnumeric
%!error <DMC: failed validation of UMIN with isnumeric> testDMCParameters('uMin', '2');

% stretch single element
%!warning <Assumed array uMin consists of 2 elements with a value of 1> testDMCParameters('uMin', 1)

% has ny Elements
%!error <Array uMin should have \(2\) elements> testDMCParameters('uMin', [1, 1, 1])

% can be horizontal
%!test(testDMCParameters('uMin', [1, 1]))

% can be vertical
%!test(testDMCParameters('uMin', [1; 1]))

% is not a matrix
%!error <Value uMin should be a horizontal or vertical array with 2 elements> (testDMCParameters('uMin', [1, 1; 1, 1]))


%-------------------------------------- uMax -----------------------------------
% isnumeric
%!error <DMC: failed validation of UMAX with isnumeric> testDMCParameters('uMax', '2');

% stretch single element
%!warning <Assumed array uMax consists of 2 elements with a value of 1> testDMCParameters('uMax', 1)

% has ny Elements
%!error <Array uMax should have \(2\) elements> testDMCParameters('uMax', [1, 1, 1])

% can be horizontal
%!test(testDMCParameters('uMax', [1, 1]))

% can be vertical
%!test(testDMCParameters('uMax', [1; 1]))

% is not a matrix
%!error <Value uMax should be a horizontal or vertical array with 2 elements> (testDMCParameters('uMax', [1, 1; 1, 1]))


%------------------------------------- duMin -----------------------------------
% isnumeric
%!error <DMC: failed validation of DUMIN with @\(x\) isnumeric \(x\) && obj.isNegative \(x\)> testDMCParameters('duMin', '2');

% isNegative (x < 0)
%!error <DMC: failed validation of DUMIN with @\(x\) isnumeric \(x\) && obj.isNegative \(x\)> testDMCParameters('duMin', 2);

% stretch single element
%!warning <Assumed array duMin consists of 2 elements with a value of -1> testDMCParameters('duMin', -1)

% has ny Elements
%!error <Array duMin should have \(2\) elements> testDMCParameters('duMin', [-1, -1, -1])

% can be horizontal
%!test(testDMCParameters('duMin', [-1, -1]))

% can be vertical
%!test(testDMCParameters('duMin', [-1; -1]))

% is not a matrix
%!error <Value duMin should be a horizontal or vertical array with 2 elements> (testDMCParameters('duMin', [-1, -1; -1, -1]))


%------------------------------------- duMax -----------------------------------
% isnumeric
%!error <DMC: failed validation of DUMAX with @\(x\) isnumeric \(x\) && obj.isPositive \(x\)> testDMCParameters('duMax', '2');

% isPositive (x > 0)
%!error <DMC: failed validation of DUMAX with @\(x\) isnumeric \(x\) && obj.isPositive \(x\)> testDMCParameters('duMax', -1);

% stretch single element
%!warning <Assumed array duMax consists of 2 elements with a value of 1> testDMCParameters('duMax', 1)

% has ny Elements
%!error <Array duMax should have \(2\) elements> testDMCParameters('duMax', [1, 1, 1])

% can be horizontal
%!test(testDMCParameters('duMax', [1, 1]))

% can be vertical
%!test(testDMCParameters('duMax', [1; 1]))

% is not a matrix
%!error <Value duMax should be a horizontal or vertical array with 2 elements> (testDMCParameters('duMax', [1, 1; 1, 1]))


%------------------------------------- yMin ------------------------------------
% isnumeric
%!error <DMC: failed validation of YMIN with isnumeric> testDMCParameters('yMin', '2');

% stretch single element
%!warning <Assumed array yMin consists of 2 elements with a value of 1> testDMCParameters('yMin', 1)

% has ny Elements
%!error <Array yMin should have \(2\) elements> testDMCParameters('yMin', [1, 1, 1])

% can be horizontal
%!test(testDMCParameters('yMin', [1, 1]))

% can be vertical
%!test(testDMCParameters('yMin', [1; 1]))

% is not a matrix
%!error <Value yMin should be a horizontal or vertical array with 2 elements> (testDMCParameters('yMin', [1, 1; 1, 1]))

% Not accessible in analyticalAlgType
%!error <DMC: argument 'YMIN' is not a valid parameter> testDMCParameters('algType', Constants().analyticalAlgType);

% Not accessible in fastAlgType
%!error <DMC: argument 'YMIN' is not a valid parameter> testDMCParameters('algType', Constants().fastAlgType);


%------------------------------------- yMax ------------------------------------
% isnumeric
%!error <DMC: failed validation of YMAX with isnumeric> testDMCParameters('yMax', '2');

% stretch single element
%!warning <Assumed array yMax consists of 2 elements with a value of 1> testDMCParameters('yMax', 1)

% has ny Elements
%!error <Array yMax should have \(2\) elements> testDMCParameters('yMax', [1, 1, 1])

% can be horizontal
%!test(testDMCParameters('yMax', [1, 1]))

% can be vertical
%!test(testDMCParameters('yMax', [1; 1]))

% is not a matrix
%!error <Value yMax should be a horizontal or vertical array with 2 elements> (testDMCParameters('yMax', [1, 1; 1, 1]))


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
    stepResponses = getStepResponsesEq(ny, nu, IODelay, A, B, D);
    nz = nu; Dz = D; stepResponsesZ = stepResponses;

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
    elseif strcmp(valueName, 'nz')
        nz = testValue;
    elseif strcmp(valueName, 'Dz')
        Dz = testValue;
    elseif strcmp(valueName, 'stepResponsesZ')
        stepResponsesZ = testValue;
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

    % Disturbance parameters assignment tests
    if strcmp(valueName, 'nz_assign')
        nz = testValue;
        reg = DMC(D, N, Nu, ny, nu, stepResponses,...
            'nz', nz,...
            'mi', mi, 'lambda', lambda,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'algType', algType);
    elseif strcmp(valueName, 'Dz_assign')
        Dz = testValue;
        reg = DMC(D, N, Nu, ny, nu, stepResponses,...
            'Dz', Dz,...
            'mi', mi, 'lambda', lambda,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'algType', algType);
    elseif strcmp(valueName, 'stepResponsesZ_assign')
        stepResponsesZ = testValue;
        reg = DMC(D, N, Nu, ny, nu, stepResponses,...
            'stepResponsesZ', stepResponsesZ,...
            'mi', mi, 'lambda', lambda,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'algType', algType);
    else
        % Regulator with disturbance parameters
        reg = DMC(D, N, Nu, ny, nu, stepResponses,...
            'nz', nz, 'Dz', Dz, 'stepResponsesZ', stepResponsesZ,...
            'mi', mi, 'lambda', lambda,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'algType', algType);
    end
end
