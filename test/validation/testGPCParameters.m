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


%-------------------------------------- nz -------------------------------------
% isnumeric
%!error <GPC: failed validation of NZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('nz', '2');

% isscalar (is not a matrix)
%!error <GPC: failed validation of NZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('nz', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <GPC: failed validation of NZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('nz', 1.1);

% isPositive (x > 0)
%!error <GPC: failed validation of NZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testGPCParameters('nz', -1);


%----------------------------------- nz_assign ---------------------------------
%!error <Some required parameters \('nz', 'Az', 'Bz', 'IODelayZ'\) for GPC disturbance mechanism were left unassigned> testGPCParameters('nz_assign', 1)


%------------------------------------- Az --------------------------------------
% iscell
%!error <GPC: failed validation of AZ with @\(x\) iscell \(x\) && !isempty \(x\)> testGPCParameters('Az', '2');

% isempty
%!error <GPC: failed validation of AZ with @\(x\) iscell \(x\) && !isempty \(x\)> testGPCParameters('Az', cell(0));

% nRows == ny
%!error <Cell Az should have 2 rows and 2 columns> testGPCParameters('Az', cell(1, 2));

% nColumns == ny
%!error <Cell Az should have 2 rows and 2 columns> testGPCParameters('Az', cell(2, 1));


%----------------------------------- Az_assign ---------------------------------
%!error <Some required parameters \('nz', 'Az', 'Bz', 'IODelayZ'\) for GPC disturbance mechanism were left unassigned> testGPCParameters('Az_assign', 1)


%------------------------------------- Bz --------------------------------------
% iscell
%!error <GPC: failed validation of BZ with @\(x\) iscell \(x\) && !isempty \(x\)> testGPCParameters('Bz', '2');

% isempty
%!error <GPC: failed validation of BZ with @\(x\) iscell \(x\) && !isempty \(x\)> testGPCParameters('Bz', cell(0));

% nRows == ny
%!error <Cell Bz should have 2 rows and 2 columns> testGPCParameters('Bz', cell(1, 2));

% nColumns == nu
%!error <Cell Bz should have 2 rows and 2 columns> testGPCParameters('Bz', cell(2, 1));


%----------------------------------- Bz_assign ---------------------------------
%!error <Some required parameters \('nz', 'Az', 'Bz', 'IODelayZ'\) for GPC disturbance mechanism were left unassigned> testGPCParameters('Bz_assign', 1)


%----------------------------------- IODelayZ ----------------------------------
% isnumeric
%!error <GPC: failed validation of IODELAYZ with isnumeric> testGPCParameters('IODelayZ', '2');

% stretch single element
%!warning <Assumed \(2 x 2\) IODelayZ matrix consists entirely of elements with a value of 1> testGPCParameters('IODelayZ', 1)

% has nu Elements
%!error <Matrix IODelayZ should have 2 rows and 2 columns> testGPCParameters('IODelayZ', [1, 1, 1])


%-------------------------------- IODelayZ_assign ------------------------------
%!error <Some required parameters \('nz', 'Az', 'Bz', 'IODelayZ'\) for GPC disturbance mechanism were left unassigned> testGPCParameters('IODelayZ_assign', 1)


%-------------------------------------- mi -------------------------------------
% isnumeric
%!error <GPC: failed validation of MI with isnumeric> testGPCParameters('mi', '2');

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
% isnumeric
%!error <GPC: failed validation of LAMBDA with isnumeric> testGPCParameters('lambda', '2');

% lambda = 0
%!warning <Lambda value set to 0. Regulator might be unstable.> testGPCParameters('lambda', [0, 0])

% stretch single element
%!warning <Assumed array lambda consists of 2 elements with a value of 1> testGPCParameters('lambda', 1)

% has nu Elements
%!error <Array lambda should have \(2\) elements> testGPCParameters('lambda', [1, 1, 1])

% can be horizontal
%!test(testGPCParameters('lambda', [1, 1]))

% can be vertical
%!test(testGPCParameters('lambda', [1; 1]))

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
%!error <GPC: failed validation of UMIN with isnumeric> testGPCParameters('uMin', '2');

% stretch single element
%!warning <Assumed array uMin consists of 2 elements with a value of 1> testGPCParameters('uMin', 1)

% has ny Elements
%!error <Array uMin should have \(2\) elements> testGPCParameters('uMin', [1, 1, 1])

% can be horizontal
%!test(testGPCParameters('uMin', [1, 1]))

% can be vertical
%!test(testGPCParameters('uMin', [1; 1]))

% is not a matrix
%!error <Value uMin should be a horizontal or vertical array with 2 elements> (testGPCParameters('uMin', [1, 1; 1, 1]))


%-------------------------------------- uMax -----------------------------------
% isnumeric
%!error <GPC: failed validation of UMAX with isnumeric> testGPCParameters('uMax', '2');

% stretch single element
%!warning <Assumed array uMax consists of 2 elements with a value of 1> testGPCParameters('uMax', 1)

% has ny Elements
%!error <Array uMax should have \(2\) elements> testGPCParameters('uMax', [1, 1, 1])

% can be horizontal
%!test(testGPCParameters('uMax', [1, 1]))

% can be vertical
%!test(testGPCParameters('uMax', [1; 1]))

% is not a matrix
%!error <Value uMax should be a horizontal or vertical array with 2 elements> (testGPCParameters('uMax', [1, 1; 1, 1]))


%------------------------------------- duMin -----------------------------------
% isnumeric
%!error <GPC: failed validation of DUMIN with @\(x\) isnumeric \(x\) && obj.isNegative \(x\)> testGPCParameters('duMin', '2');

% isNegative (x < 0)
%!error <GPC: failed validation of DUMIN with @\(x\) isnumeric \(x\) && obj.isNegative \(x\)> testGPCParameters('duMin', 2);

% stretch single element
%!warning <Assumed array duMin consists of 2 elements with a value of -1> testGPCParameters('duMin', -1)

% has ny Elements
%!error <Array duMin should have \(2\) elements> testGPCParameters('duMin', [-1, -1, -1])

% can be horizontal
%!test(testGPCParameters('duMin', [-1, -1]))

% can be vertical
%!test(testGPCParameters('duMin', [-1; -1]))

% is not a matrix
%!error <Value duMin should be a horizontal or vertical array with 2 elements> (testGPCParameters('duMin', [-1, -1; -1, -1]))


%------------------------------------- duMax -----------------------------------
% isnumeric
%!error <GPC: failed validation of DUMAX with @\(x\) isnumeric \(x\) && obj.isPositive \(x\)> testGPCParameters('duMax', '2');

% isPositive (x > 0)
%!error <GPC: failed validation of DUMAX with @\(x\) isnumeric \(x\) && obj.isPositive \(x\)> testGPCParameters('duMax', -1);

% stretch single element
%!warning <Assumed array duMax consists of 2 elements with a value of 1> testGPCParameters('duMax', 1)

% has ny Elements
%!error <Array duMax should have \(2\) elements> testGPCParameters('duMax', [1, 1, 1])

% can be horizontal
%!test(testGPCParameters('duMax', [1, 1]))

% can be vertical
%!test(testGPCParameters('duMax', [1; 1]))

% is not a matrix
%!error <Value duMax should be a horizontal or vertical array with 2 elements> (testGPCParameters('duMax', [1, 1; 1, 1]))


%------------------------------------- yMin ------------------------------------
% isnumeric
%!error <GPC: failed validation of YMIN with isnumeric> testGPCParameters('yMin', '2');

% stretch single element
%!warning <Assumed array yMin consists of 2 elements with a value of 1> testGPCParameters('yMin', 1)

% has ny Elements
%!error <Array yMin should have \(2\) elements> testGPCParameters('yMin', [1, 1, 1])

% can be horizontal
%!test(testGPCParameters('yMin', [1, 1]))

% can be vertical
%!test(testGPCParameters('yMin', [1; 1]))

% is not a matrix
%!error <Value yMin should be a horizontal or vertical array with 2 elements> (testGPCParameters('yMin', [1, 1; 1, 1]))

% Not accessible in analyticalAlgType
%!error <GPC: argument 'YMIN' is not a valid parameter> testGPCParameters('algType', Constants().analyticalAlgType);

% Not accessible in fastAlgType
%!error <GPC: argument 'YMIN' is not a valid parameter> testGPCParameters('algType', Constants().fastAlgType);


%------------------------------------- yMax ------------------------------------
% isnumeric
%!error <GPC: failed validation of YMAX with isnumeric> testGPCParameters('yMax', '2');

% stretch single element
%!warning <Assumed array yMax consists of 2 elements with a value of 1> testGPCParameters('yMax', 1)

% has ny Elements
%!error <Array yMax should have \(2\) elements> testGPCParameters('yMax', [1, 1, 1])

% can be horizontal
%!test(testGPCParameters('yMax', [1, 1]))

% can be vertical
%!test(testGPCParameters('yMax', [1; 1]))

% is not a matrix
%!error <Value yMax should be a horizontal or vertical array with 2 elements> (testGPCParameters('yMax', [1, 1; 1, 1]))



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


%-------------------------------------- YYz -------------------------------------
% isnumeric
%!error <GPC: failed validation of YYZ with isnumeric> testGPCParameters('YYz', '2');

% Allow empty
%!test testGPCParameters('YYz', []);

% nRows
%!error <Matrix YYz should have 3 rows or more and 2 columns> testGPCParameters('YYz', zeros(2, 2));

% nColumns
%!error <Matrix YYz should have 3 rows or more and 2 columns> testGPCParameters('YYz', zeros(3, 3));


%-------------------------------------- UUz -------------------------------------
% isnumeric
%!error <GPC: failed validation of UUZ with isnumeric> testGPCParameters('UUz', '2');

% Allow empty
%!test testGPCParameters('UUz', []);

% nRows
%!error <Matrix UUz should have 3 rows or more and 2 columns> testGPCParameters('UUz', zeros(2, 2));

% nColumns
%!error <Matrix UUz should have 3 rows or more and 2 columns> testGPCParameters('UUz', zeros(3, 3));


%------------------------------------ algType ----------------------------------
% algType can be analytical, fast or numerical
%!error <validatestring: 'something' does not match any of\nanalytical, fast, numerical> testGPCParameters('algType', 'something');


function testGPCParameters(valueName, testValue)
    %% Object
    % Setting sampling time -> ../../obj/get2x2.m
    load(Utilities.getObjBinFilePath('2x2.mat'));

    c = Constants();

    nz = nu;
    ypp = c.testYInitVal;
    upp = c.testUInitVal;
    k = 5;
    nz = nu; Az = A; Bz = B; IODelayZ = IODelay;
    YY = ypp * ones(k - 2, ny);
    YYz = ypp * ones(k - 2, ny);
    UU = upp * ones(k - 2, nu);
    UUz = upp * ones(k - 2, nz);
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
    elseif strcmp(valueName, 'nz')
        nz = testValue;
    elseif strcmp(valueName, 'A')
        A = testValue;
    elseif strcmp(valueName, 'Az')
        Az = testValue;
    elseif strcmp(valueName, 'B')
        B = testValue;
    elseif strcmp(valueName, 'Bz')
        Bz = testValue;
    elseif strcmp(valueName, 'IODelay')
        IODelay = testValue;
    elseif strcmp(valueName, 'IODelayZ')
        IODelayZ = testValue;
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
    elseif strcmp(valueName, 'YYz')
        YYz = testValue;
    elseif strcmp(valueName, 'UU')
        UU = testValue;
    elseif strcmp(valueName, 'UUz')
        UUz = testValue;
    elseif strcmp(valueName, 'algType')
        algType = testValue;
    end

    % Disturbance parameters assignment tests
    if strcmp(valueName, 'nz_assign')
        reg = GPC(N, Nu, ny, nu, A, B, 'IODelay', IODelay,...
            'mi', mi, 'lambda', lambda, 'ypp', ypp, 'upp', upp,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'k', k, 'YY', YY, 'UU', UU,...
            'nz', nz,...
            'YYz', YYz, 'UUz', UUz,...
            'algType', algType);
    elseif strcmp(valueName, 'Az_assign')
        reg = GPC(N, Nu, ny, nu, A, B, 'IODelay', IODelay,...
            'mi', mi, 'lambda', lambda, 'ypp', ypp, 'upp', upp,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'k', k, 'YY', YY, 'UU', UU,...
            'Az', Az,...
            'YYz', YYz, 'UUz', UUz,...
            'algType', algType);
    elseif strcmp(valueName, 'Bz_assign')
        reg = GPC(N, Nu, ny, nu, A, B, 'IODelay', IODelay,...
            'mi', mi, 'lambda', lambda, 'ypp', ypp, 'upp', upp,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'k', k, 'YY', YY, 'UU', UU,...
            'Bz', Bz,...
            'YYz', YYz, 'UUz', UUz,...
            'algType', algType);
    elseif strcmp(valueName, 'IODelayZ_assign')
        reg = GPC(N, Nu, ny, nu, A, B, 'IODelay', IODelay,...
            'mi', mi, 'lambda', lambda, 'ypp', ypp, 'upp', upp,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'k', k, 'YY', YY, 'UU', UU,...
            'IODelayZ', IODelayZ,...
            'YYz', YYz, 'UUz', UUz,...
            'algType', algType);
    else
        % Regulator with disturbance parameters
        reg = GPC(N, Nu, ny, nu, A, B, 'IODelay', IODelay,...
            'mi', mi, 'lambda', lambda, 'ypp', ypp, 'upp', upp,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'k', k, 'YY', YY, 'UU', UU,...
            'nz', nz, 'Az', Az, 'Bz', Bz, 'IODelayZ', IODelayZ,...
            'YYz', YYz, 'UUz', UUz,...
            'algType', algType);
    end
end


