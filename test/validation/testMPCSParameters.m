%------------------------------------- N ---------------------------------------
%!error <MPCS: failed validation of N with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('N', '2');

% isscalar (is not a matrix)
%!error <MPCS: failed validation of N with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('N', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <MPCS: failed validation of N with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('N', 1.1);

% isPositive (x > 0)
%!error <MPCS: failed validation of N with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('N', -1);


%------------------------------------- Nu --------------------------------------
% isnumeric
%!error <MPCS: failed validation of NU with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('Nu', '2');

% isscalar (is not a matrix)
%!error <MPCS: failed validation of NU with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('Nu', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <MPCS: failed validation of NU with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('Nu', 1.1);

% isPositive (x > 0)
%!error <MPCS: failed validation of NU with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('Nu', -1);


%-------------------------------------- ny -------------------------------------
% isnumeric
%!error <MPCS: failed validation of NUMBEROFOUTPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('ny', '2');

% isscalar (is not a matrix)
%!error <MPCS: failed validation of NUMBEROFOUTPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('ny', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <MPCS: failed validation of NUMBEROFOUTPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('ny', 1.1);

% isPositive (x > 0)
%!error <MPCS: failed validation of NUMBEROFOUTPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('ny', -1);


%------------------------------------- nu --------------------------------------
% isnumeric
%!error <MPCS: failed validation of NUMBEROFINPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('nu', '2');

% isscalar (is not a matrix)
%!error <MPCS: failed validation of NUMBEROFINPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('nu', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <MPCS: failed validation of NUMBEROFINPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('nu', 1.1);

% isPositive (x > 0)
%!error <MPCS: failed validation of NUMBEROFINPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('nu', -1);


%------------------------------------- nx --------------------------------------
% isnumeric
%!error <MPCS: failed validation of NUMBEROFSTATEVARIABLES with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('nx', '2');

% isscalar (is not a matrix)
%!error <MPCS: failed validation of NUMBEROFSTATEVARIABLES with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('nx', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <MPCS: failed validation of NUMBEROFSTATEVARIABLES with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('nx', 1.1);

% isPositive (x > 0)
%!error <MPCS: failed validation of NUMBEROFSTATEVARIABLES with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('nx', -1);


%------------------------------------- dA --------------------------------------
% isnumeric
%!error <MPCS: failed validation of DA with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\) && size \(x, 1\) == size \(x, 2\)> testMPCSParameters('dA', '2');

% Value has a type of 'double'
%!error <MPCS: failed validation of DA with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\) && size \(x, 1\) == size \(x, 2\)> testMPCSParameters('dA', int8(1));

% ismatrix (3D array is not a matrix)
%!error <MPCS: failed validation of DA with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\) && size \(x, 1\) == size \(x, 2\)> testMPCSParameters('dA', zeros(1, 1, 2));

% isSquare
%!error <MPCS: failed validation of DA with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\) && size \(x, 1\) == size \(x, 2\)> testMPCSParameters('dA', zeros(1, 2));

% isSquare (nx, nx)
%!error <dA should be a square matrix> testMPCSParameters('dA', zeros(3, 3));


%------------------------------------- dB --------------------------------------
% isnumeric
%!error <MPCS: failed validation of DB with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dB', '2');

% Value has a type of 'double'
%!error <MPCS: failed validation of DB with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dB', int8(1));

% ismatrix (3D array is not a matrix)
%!error <MPCS: failed validation of DB with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dB', zeros(1, 1, 2));

% MatrixInvalidSize
%!error <Matrix dB should have 4 rows and 2 columns> testMPCSParameters('dB', zeros(1, 2));


%------------------------------------- dC --------------------------------------
% isnumeric
%!error <MPCS: failed validation of DC with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dC', '2');

% Value has a type of 'double'
%!error <MPCS: failed validation of DC with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dC', int8(1));

% ismatrix (3D array is not a matrix)
%!error <MPCS: failed validation of DC with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dC', zeros(1, 1, 2));

% MatrixInvalidSize
%!error <Matrix dC should have 2 rows and 4 columns> testMPCSParameters('dC', zeros(1, 2));


%------------------------------------- dD --------------------------------------
% isnumeric
%!error <MPCS: failed validation of DD with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dD', '2');

% Value has a type of 'double'
%!error <MPCS: failed validation of DD with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dD', int8(1));

% ismatrix (3D array is not a matrix)
%!error <MPCS: failed validation of DD with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dD', zeros(1, 1, 2));

% MatrixInvalidSize
%!error <Matrix dD should have 2 rows and 2 columns> testMPCSParameters('dD', zeros(1, 2));


%-------------------------------------- mi -------------------------------------
% stretch single element
%!warning <Assumed array mi consists of 2 elements with a value of 1> testMPCSParameters('mi', 1)

% has ny Elements
%!error <Array mi should have \(2\) elements> testMPCSParameters('mi', [1, 1, 1])

% can be horizontal
%!test(testMPCSParameters('mi', [1, 1]))

% can be vertical
%!test(testMPCSParameters('mi', [1; 1]))


%------------------------------------ lambda -----------------------------------
% lambda = 0
%!warning <Lambda value set to 0. Regulator might be unstable.> testMPCSParameters('lambda', [0, 0])

% stretch single element
%!warning <Assumed array lambda consists of 2 elements with a value of 1> testMPCSParameters('lambda', 1)

% has nu Elements
%!error <Array lambda should have \(2\) elements> testMPCSParameters('lambda', [1, 1, 1])

% can be horizontal
%!test(testMPCSParameters('mi', [1, 1]))

% can be vertical
%!test(testMPCSParameters('mi', [1; 1]))


%-------------------------------------- uMin -----------------------------------
% isnumeric
%!error <MPCS: failed validation of UMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCSParameters('uMin', '2');

% isscalar (is not a matrix)
%!error <MPCS: failed validation of UMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCSParameters('uMin', [1, 1]);

% Value has a type of 'double'
%!error <MPCS: failed validation of UMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCSParameters('uMin', int8(1));


%-------------------------------------- uMax -----------------------------------
% isnumeric
%!error <MPCS: failed validation of UMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCSParameters('uMax', '2');

% isscalar (is not a matrix)
%!error <MPCS: failed validation of UMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCSParameters('uMax', [1, 1]);

% Value has a type of 'double'
%!error <MPCS: failed validation of UMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCSParameters('uMax', int8(1));


%------------------------------------- duMin -----------------------------------
% isnumeric
%!error <MPCS: failed validation of DUMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isNegativeOrEqualToZero \(x\)> testMPCSParameters('duMin', '2');

% isscalar (is not a matrix)
%!error <MPCS: failed validation of DUMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isNegativeOrEqualToZero \(x\)> testMPCSParameters('duMin', [1, 1]);

% Value has a type of 'double'
%!error <MPCS: failed validation of DUMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isNegativeOrEqualToZero \(x\)> testMPCSParameters('duMin', int8(1));

% Value <= 0
%!error <MPCS: failed validation of DUMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isNegativeOrEqualToZero \(x\)> testMPCSParameters('duMin', 1);


%------------------------------------- duMax -----------------------------------
% isnumeric
%!error <MPCS: failed validation of DUMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isPositiveOrEqualToZero \(x\)> testMPCSParameters('duMax', '2');

% isscalar (is not a matrix)
%!error <MPCS: failed validation of DUMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isPositiveOrEqualToZero \(x\)> testMPCSParameters('duMax', [1, 1]);

% Value has a type of 'double'
%!error <MPCS: failed validation of DUMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isPositiveOrEqualToZero \(x\)> testMPCSParameters('duMax', int8(1));

% Value >= 0
%!error <MPCS: failed validation of DUMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isPositiveOrEqualToZero \(x\)> testMPCSParameters('duMax', -1);


%------------------------------------- yMin ------------------------------------
% isnumeric
%!error <MPCS: failed validation of YMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCSParameters('yMin', '2');

% isscalar (is not a matrix)
%!error <MPCS: failed validation of YMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCSParameters('yMin', [1, 1]);

% Value has a type of 'double'
%!error <MPCS: failed validation of YMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCSParameters('yMin', int8(1));

% Not accessible in analyticalAlgType
%!error <MPCS: argument 'YMIN' is not a valid parameter> testMPCSParameters('algType', Constants().analyticalAlgType);

% Not accessible in fastAlgType
%!error <MPCS: argument 'YMIN' is not a valid parameter> testMPCSParameters('algType', Constants().fastAlgType);


%------------------------------------- yMax ------------------------------------
% isnumeric
%!error <MPCS: failed validation of YMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCSParameters('yMax', '2');

% isscalar (is not a matrix)
%!error <MPCS: failed validation of YMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCSParameters('yMax', [1, 1]);

% Value has a type of 'double'
%!error <MPCS: failed validation of YMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCSParameters('yMax', int8(1));


%------------------------------------ algType ----------------------------------
% algType can be analytical, fast or numerical
%!error <validatestring: 'something' does not match any of\nanalytical, fast, numerical> testMPCSParameters('algType', 'something');


function testMPCSParameters(valueName, testValue)
    %% Object
    % Setting sampling time -> ../../obj/get2x2.m
    load(Utilities.getObjBinFilePath('2x2.mat'));

    c = Constants();

    algType = c.numericalAlgType;

    % Assign test values
    if strcmp(valueName, 'N')
        N = testValue;
    elseif strcmp(valueName, 'Nu')
        Nu = testValue;
    elseif strcmp(valueName, 'ny')
        ny = testValue;
    elseif strcmp(valueName, 'nu')
        nu = testValue;
    elseif strcmp(valueName, 'nx')
        nx = testValue;
    elseif strcmp(valueName, 'dA')
        dA = testValue;
    elseif strcmp(valueName, 'dB')
        dB = testValue;
    elseif strcmp(valueName, 'dC')
        dC = testValue;
    elseif strcmp(valueName, 'dD')
        dD = testValue;
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
    reg = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
        'mi', mi, 'lambda', lambda,...
        'uMin', uMin, 'uMax', uMax,...
        'duMin', duMin, 'duMax', duMax,...
        'yMin', yMin, 'yMax', yMax,...
        'algType', algType);
end
