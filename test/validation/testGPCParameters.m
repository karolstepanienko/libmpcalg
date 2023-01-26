%------------------------------------- N ---------------------------------------
% isnumeric
%!error <GPC: failed validation of N with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('N', '2');

% isscalar (is not a matrix)
%!error <GPC: failed validation of N with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('N', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <GPC: failed validation of N with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('N', 1.1);

% isPositive (x > 0)
%!error <GPC: failed validation of N with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('N', -1);


%------------------------------------- Nu --------------------------------------
% isnumeric
%!error <GPC: failed validation of NU with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('Nu', '2');

% isscalar (is not a matrix)
%!error <GPC: failed validation of NU with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('Nu', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <GPC: failed validation of NU with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('Nu', 1.1);

% isPositive (x > 0)
%!error <GPC: failed validation of NU with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('Nu', -1);


%-------------------------------------- ny -------------------------------------
% isnumeric
%!error <GPC: failed validation of NUMBEROFOUTPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('ny', '2');

% isscalar (is not a matrix)
%!error <GPC: failed validation of NUMBEROFOUTPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('ny', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <GPC: failed validation of NUMBEROFOUTPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('ny', 1.1);

% isPositive (x > 0)
%!error <GPC: failed validation of NUMBEROFOUTPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('ny', -1);


%------------------------------------- nu --------------------------------------
% isnumeric
%!error <GPC: failed validation of NUMBEROFINPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('nu', '2');

% isscalar (is not a matrix)
%!error <GPC: failed validation of NUMBEROFINPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('nu', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <GPC: failed validation of NUMBEROFINPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('nu', 1.1);

% isPositive (x > 0)
%!error <GPC: failed validation of NUMBEROFINPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('nu', -1);


%------------------------------------- A ---------------------------------------
% iscell
%!error <GPC: failed validation of A with @\(x\) iscell \(x\) && !isempty \(x\)> testGPCParameters('A', '2');

% isempty
%!error <GPC: failed validation of A with @\(x\) iscell \(x\) && !isempty \(x\)> testGPCParameters('A', cell(0));

% nRows == ny
%!error <Cell A should have 2 rows and 2 columns> testGPCParameters('A', cell(1, 2));

% nColumns == ny
%!error <Cell A should have 2 rows and 2 columns> testGPCParameters('A', cell(2, 1));


%------------------------------------- B ---------------------------------------
% iscell
%!error <GPC: failed validation of B with @\(x\) iscell \(x\) && !isempty \(x\)> testGPCParameters('B', '2');

% isempty
%!error <GPC: failed validation of B with @\(x\) iscell \(x\) && !isempty \(x\)> testGPCParameters('B', cell(0));

% nRows == ny
%!error <Cell B should have 2 rows and 2 columns> testGPCParameters('B', cell(1, 2));

% nColumns == nu
%!error <Cell B should have 2 rows and 2 columns> testGPCParameters('B', cell(2, 1));


%----------------------------------- IODelay -----------------------------------
% isnumeric
%!error <GPC: failed validation of IODELAY with isnumeric> testGPCParameters('IODelay', '2');

% stretch single element
%!warning <Assumed \(2 x 2\) IODelay matrix consists entirely of elements with a value of 1> testGPCParameters('IODelay', 1)

% has nu Elements
%!error <Matrix IODelay should have 2 rows and 2 columns> testGPCParameters('IODelay', [1, 1, 1])


%-------------------------------------- mi -------------------------------------
% stretch single element
%!warning <Assumed array mi consists of 2 elements with a value of 1> testGPCParameters('mi', 1)

% has ny Elements
%!error <Array mi should have \(2\) elements> testGPCParameters('mi', [1, 1, 1])

% can be horizontal
%!test(testGPCParameters('mi', [1, 1]))

% can be vertical
%!test(testGPCParameters('mi', [1; 1]))

% is not a matrix
%!error <Value mi should be a horizontal or vertical array with 2 elements> (testGPCParameters('mi', [1, 1; 1, 1]))


%------------------------------------ lambda -----------------------------------
% lambda = 0
%!warning <Lambda value set to 0. Regulator might be unstable.> testGPCParameters('lambda', [0, 0])

% stretch single element
%!warning <Assumed array lambda consists of 2 elements with a value of 1> testGPCParameters('lambda', 1)

% has nu Elements
%!error <Array lambda should have \(2\) elements> testGPCParameters('lambda', [1, 1, 1])

% can be horizontal
%!test(testGPCParameters('mi', [1, 1]))

% can be vertical
%!test(testGPCParameters('mi', [1; 1]))

% is not a matrix
%!error <Value lambda should be a horizontal or vertical array with 2 elements> (testGPCParameters('lambda', [1, 1; 1, 1]))


%------------------------------------ ypp --------------------------------------
% isnumeric
%!error <GPC: failed validation of YPP with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('ypp', '2');

% isscalar (is not a matrix)
%!error <GPC: failed validation of YPP with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('ypp', [1, 1]);

% Value has a type of 'double'
%!error <GPC: failed validation of YPP with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('ypp', int8(1));


%------------------------------------ upp --------------------------------------
% isnumeric
%!error <GPC: failed validation of UPP with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('upp', '2');

% isscalar (is not a matrix)
%!error <GPC: failed validation of UPP with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('upp', [1, 1]);

% Value has a type of 'double'
%!error <GPC: failed validation of UPP with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('upp', int8(1));


%-------------------------------------- uMin -----------------------------------
% isnumeric
%!error <GPC: failed validation of UMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('uMin', '2');

% isscalar (is not a matrix)
%!error <GPC: failed validation of UMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('uMin', [1, 1]);

% Value has a type of 'double'
%!error <GPC: failed validation of UMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('uMin', int8(1));


%-------------------------------------- uMax -----------------------------------
% isnumeric
%!error <GPC: failed validation of UMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('uMax', '2');

% isscalar (is not a matrix)
%!error <GPC: failed validation of UMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('uMax', [1, 1]);

% Value has a type of 'double'
%!error <GPC: failed validation of UMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('uMax', int8(1));


%------------------------------------- duMin -----------------------------------
% isnumeric
%!error <GPC: failed validation of DUMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isNegativeOrEqualToZero \(x\)> testGPCParameters('duMin', '2');

% isscalar (is not a matrix)
%!error <GPC: failed validation of DUMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isNegativeOrEqualToZero \(x\)> testGPCParameters('duMin', [1, 1]);

% Value has a type of 'double'
%!error <GPC: failed validation of DUMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isNegativeOrEqualToZero \(x\)> testGPCParameters('duMin', int8(1));

% Value <= 0
%!error <GPC: failed validation of DUMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isNegativeOrEqualToZero \(x\)> testGPCParameters('duMin', 1);


%------------------------------------- duMax -----------------------------------
% isnumeric
%!error <GPC: failed validation of DUMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isPositiveOrEqualToZero \(x\)> testGPCParameters('duMax', '2');

% isscalar (is not a matrix)
%!error <GPC: failed validation of DUMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isPositiveOrEqualToZero \(x\)> testGPCParameters('duMax', [1, 1]);

% Value has a type of 'double'
%!error <GPC: failed validation of DUMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isPositiveOrEqualToZero \(x\)> testGPCParameters('duMax', int8(1));

% Value >= 0
%!error <GPC: failed validation of DUMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isPositiveOrEqualToZero \(x\)> testGPCParameters('duMax', -1);


%------------------------------------- yMin ------------------------------------
% isnumeric
%!error <GPC: failed validation of YMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('yMin', '2');

% isscalar (is not a matrix)
%!error <GPC: failed validation of YMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('yMin', [1, 1]);

% Value has a type of 'double'
%!error <GPC: failed validation of YMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('yMin', int8(1));

% Not accessible in analyticalAlgType
%!error <GPC: argument 'YMIN' is not a valid parameter> testGPCParameters('algType', Constants().analyticalAlgType);

% Not accessible in fastAlgType
%!error <GPC: argument 'YMIN' is not a valid parameter> testGPCParameters('algType', Constants().fastAlgType);


%------------------------------------- yMax ------------------------------------
% isnumeric
%!error <GPC: failed validation of YMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('yMax', '2');

% isscalar (is not a matrix)
%!error <GPC: failed validation of YMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('yMax', [1, 1]);

% Value has a type of 'double'
%!error <GPC: failed validation of YMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testGPCParameters('yMax', int8(1));


%------------------------------------- k ---------------------------------------
% isnumeric
%!error <GPC: failed validation of K with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('k', '2');

% isscalar (is not a matrix)
%!error <GPC: failed validation of K with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('k', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <GPC: failed validation of K with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('k', 1.1);

% isPositive (x > 0)
%!error <GPC: failed validation of K with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('k', -1);


%-------------------------------------- YY -------------------------------------
% isnumeric
%!error <GPC: failed validation of YY with isnumeric> testGPCParameters('YY', '2');

% Allow empty
%!test testGPCParameters('YY', []);

% nRows
%!error <Matrix YY should have 3 rows or more and 2 columns> testGPCParameters('YY', zeros(2, 2));

% nColumns
%!error <Matrix YY should have 3 rows or more and 2 columns> testGPCParameters('YY', zeros(3, 3));


%-------------------------------------- UU -------------------------------------
% isnumeric
%!error <GPC: failed validation of UU with isnumeric> testGPCParameters('UU', '2');

% Allow empty
%!test testGPCParameters('UU', []);

% nRows
%!error <Matrix UU should have 3 rows or more and 2 columns> testGPCParameters('UU', zeros(2, 2));

% nColumns
%!error <Matrix UU should have 3 rows or more and 2 columns> testGPCParameters('UU', zeros(3, 3));


%------------------------------------ algType ----------------------------------
% algType can be analytical, fast or numerical
%!error <validatestring: 'something' does not match any of\nanalytical, fast, numerical> testGPCParameters('algType', 'something');


function testGPCParameters(valueName, testValue)
    %% Object
    % Setting sampling time -> ../../obj/get2x2.m
    load(Utilities.getObjBinFilePath('2x2.mat'));

    c = Constants();

    ypp = c.testYInitVal;
    upp = c.testUInitVal;
    k = 5;
    YY = ypp * ones(k - 2, ny);
    UU = upp * ones(k - 2, nu);
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
    elseif strcmp(valueName, 'A')
        A = testValue;
    elseif strcmp(valueName, 'B')
        B = testValue;
    elseif strcmp(valueName, 'IODelay')
        IODelay = testValue;
    elseif strcmp(valueName, 'mi')
        mi = testValue;
    elseif strcmp(valueName, 'lambda')
        lambda = testValue;
    elseif strcmp(valueName, 'ypp')
        ypp = testValue;
    elseif strcmp(valueName, 'upp')
        upp = testValue;
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
    elseif strcmp(valueName, 'k')
        k = testValue;
    elseif strcmp(valueName, 'YY')
        YY = testValue;
    elseif strcmp(valueName, 'UU')
        UU = testValue;
    elseif strcmp(valueName, 'algType')
        algType = testValue;
    end

    % Regulator
    reg = GPC(N, Nu, ny, nu, A, B, 'IODelay', IODelay,...
        'mi', mi, 'lambda', lambda, 'ypp', ypp, 'upp', upp,...
        'uMin', uMin, 'uMax', uMax,...
        'duMin', duMin, 'duMax', duMax,...
        'yMin', yMin, 'yMax', yMax,...
        'k', k, 'YY', YY, 'UU', UU,...
        'algType', algType);
end


