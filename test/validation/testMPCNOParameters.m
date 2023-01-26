%------------------------------------- N ---------------------------------------
% isnumeric
%!error <MPCNO: failed validation of N with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCNOParameters('N', '2');

% isscalar (is not a matrix)
%!error <MPCNO: failed validation of N with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCNOParameters('N', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <MPCNO: failed validation of N with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCNOParameters('N', 1.1);

% isPositive (x > 0)
%!error <MPCNO: failed validation of N with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCNOParameters('N', -1);


%------------------------------------- Nu --------------------------------------
% isnumeric
%!error <MPCNO: failed validation of NU with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCNOParameters('Nu', '2');

% isscalar (is not a matrix)
%!error <MPCNO: failed validation of NU with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCNOParameters('Nu', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <MPCNO: failed validation of NU with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCNOParameters('Nu', 1.1);

% isPositive (x > 0)
%!error <MPCNO: failed validation of NU with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCNOParameters('Nu', -1);


%-------------------------------------- ny -------------------------------------
% isnumeric
%!error <MPCNO: failed validation of NUMBEROFOUTPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCNOParameters('ny', '2');

% isscalar (is not a matrix)
%!error <MPCNO: failed validation of NUMBEROFOUTPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCNOParameters('ny', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <MPCNO: failed validation of NUMBEROFOUTPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCNOParameters('ny', 1.1);

% isPositive (x > 0)
%!error <MPCNO: failed validation of NUMBEROFOUTPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCNOParameters('ny', -1);


%------------------------------------- nu --------------------------------------
% isnumeric
%!error <MPCNO: failed validation of NUMBEROFINPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCNOParameters('nu', '2');

% isscalar (is not a matrix)
%!error <MPCNO: failed validation of NUMBEROFINPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCNOParameters('nu', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <MPCNO: failed validation of NUMBEROFINPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCNOParameters('nu', 1.1);

% isPositive (x > 0)
%!error <MPCNO: failed validation of NUMBEROFINPUTS with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCNOParameters('nu', -1);


%--------------------------------- getOutput -----------------------------------
%!error <MPCNO: failed validation of GETOUTPUT with @\(x\) isa \(x, \'function_handle\'\)> testMPCNOParameters('getOutput', '2');


%-------------------------------------- mi -------------------------------------
% stretch single element
%!warning <Assumed array mi consists of 2 elements with a value of 1> testMPCNOParameters('mi', 1)

% has ny Elements
%!error <Array mi should have \(2\) elements> testMPCNOParameters('mi', [1, 1, 1])

% can be horizontal
%!test(testMPCNOParameters('mi', [1, 1]))

% can be vertical
%!test(testMPCNOParameters('mi', [1; 1]))

% is not a matrix
%!error <Value mi should be a horizontal or vertical array with 2 elements> (testMPCNOParameters('mi', [1, 1; 1, 1]))


%------------------------------------ lambda -----------------------------------
% lambda = 0
%!warning <Lambda value set to 0. Regulator might be unstable.> testMPCNOParameters('lambda', [0, 0])

% stretch single element
%!warning <Assumed array lambda consists of 2 elements with a value of 1> testMPCNOParameters('lambda', 1)

% has nu Elements
%!error <Array lambda should have \(2\) elements> testMPCNOParameters('lambda', [1, 1, 1])

% can be horizontal
%!test(testMPCNOParameters('mi', [1, 1]))

% can be vertical
%!test(testMPCNOParameters('mi', [1; 1]))

% is not a matrix
%!error <Value lambda should be a horizontal or vertical array with 2 elements> (testMPCNOParameters('lambda', [1, 1; 1, 1]))


%------------------------------------ ypp --------------------------------------
% isnumeric
%!error <MPCNO: failed validation of YPP with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('ypp', '2');

% isscalar (is not a matrix)
%!error <MPCNO: failed validation of YPP with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('ypp', [1, 1]);

% Value has a type of 'double'
%!error <MPCNO: failed validation of YPP with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('ypp', int8(1));


%------------------------------------ upp --------------------------------------
% isnumeric
%!error <MPCNO: failed validation of UPP with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('upp', '2');

% isscalar (is not a matrix)
%!error <MPCNO: failed validation of UPP with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('upp', [1, 1]);

% Value has a type of 'double'
%!error <MPCNO: failed validation of UPP with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('upp', int8(1));


%-------------------------------------- uMin -----------------------------------
% isnumeric
%!error <MPCNO: failed validation of UMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('uMin', '2');

% isscalar (is not a matrix)
%!error <MPCNO: failed validation of UMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('uMin', [1, 1]);

% Value has a type of 'double'
%!error <MPCNO: failed validation of UMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('uMin', int8(1));


%-------------------------------------- uMax -----------------------------------
% isnumeric
%!error <MPCNO: failed validation of UMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('uMax', '2');

% isscalar (is not a matrix)
%!error <MPCNO: failed validation of UMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('uMax', [1, 1]);

% Value has a type of 'double'
%!error <MPCNO: failed validation of UMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('uMax', int8(1));


%------------------------------------- duMin -----------------------------------
% isnumeric
%!error <MPCNO: failed validation of DUMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isNegativeOrEqualToZero \(x\)> testMPCNOParameters('duMin', '2');

% isscalar (is not a matrix)
%!error <MPCNO: failed validation of DUMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isNegativeOrEqualToZero \(x\)> testMPCNOParameters('duMin', [1, 1]);

% Value has a type of 'double'
%!error <MPCNO: failed validation of DUMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isNegativeOrEqualToZero \(x\)> testMPCNOParameters('duMin', int8(1));

% Value <= 0
%!error <MPCNO: failed validation of DUMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isNegativeOrEqualToZero \(x\)> testMPCNOParameters('duMin', 1);


%------------------------------------- duMax -----------------------------------
% isnumeric
%!error <MPCNO: failed validation of DUMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isPositiveOrEqualToZero \(x\)> testMPCNOParameters('duMax', '2');

% isscalar (is not a matrix)
%!error <MPCNO: failed validation of DUMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isPositiveOrEqualToZero \(x\)> testMPCNOParameters('duMax', [1, 1]);

% Value has a type of 'double'
%!error <MPCNO: failed validation of DUMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isPositiveOrEqualToZero \(x\)> testMPCNOParameters('duMax', int8(1));

% Value >= 0
%!error <MPCNO: failed validation of DUMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\) && obj.isPositiveOrEqualToZero \(x\)> testMPCNOParameters('duMax', -1);


%------------------------------------- yMin ------------------------------------
% isnumeric
%!error <MPCNO: failed validation of YMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('yMin', '2');

% isscalar (is not a matrix)
%!error <MPCNO: failed validation of YMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('yMin', [1, 1]);

% Value has a type of 'double'
%!error <MPCNO: failed validation of YMIN with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('yMin', int8(1));


%------------------------------------- yMax ------------------------------------
% isnumeric
%!error <MPCNO: failed validation of YMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('yMax', '2');

% isscalar (is not a matrix)
%!error <MPCNO: failed validation of YMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('yMax', [1, 1]);

% Value has a type of 'double'
%!error <MPCNO: failed validation of YMAX with @\(x\) isnumeric \(x\) && isscalar \(x\) && isa \(x, 'double'\)> testMPCNOParameters('yMax', int8(1));


%------------------------------------- k ---------------------------------------
% isnumeric
%!error <MPCNO: failed validation of K with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isMoreOrEqualTo2 \(x\)> testMPCNOParameters('k', '2');

% isscalar (is not a matrix)
%!error <MPCNO: failed validation of K with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isMoreOrEqualTo2 \(x\)> testMPCNOParameters('k', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <MPCNO: failed validation of K with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isMoreOrEqualTo2 \(x\)> testMPCNOParameters('k', 1.1);

% isPositive (x > 0)
%!error <MPCNO: failed validation of K with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isMoreOrEqualTo2 \(x\)> testMPCNOParameters('k', -1);


%-------------------------------------- YY -------------------------------------
% isnumeric
%!error <MPCNO: failed validation of YY with isnumeric> testMPCNOParameters('YY', '2');

% Allow empty
%!test testMPCNOParameters('YY', []);

% nRows
%!error <Matrix YY should have 3 rows or more and 2 columns> testMPCNOParameters('YY', zeros(2, 2));

% nColumns
%!error <Matrix YY should have 3 rows or more and 2 columns> testMPCNOParameters('YY', zeros(3, 3));


%-------------------------------------- UU -------------------------------------
% isnumeric
%!error <MPCNO: failed validation of UU with isnumeric> testMPCNOParameters('UU', '2');

% Allow empty
%!test testMPCNOParameters('UU', []);

% nRows
%!error <Matrix UU should have 3 rows or more and 2 columns> testMPCNOParameters('UU', zeros(2, 2));

% nColumns
%!error <Matrix UU should have 3 rows or more and 2 columns> testMPCNOParameters('UU', zeros(3, 3));


%-------------------------------------- data -------------------------------------
%!error <MPCNO: failed validation of DATA with @\(x\) isstruct> testMPCNOParameters('data', '2');


function testMPCNOParameters(valueName, testValue)
    %% Object
    % Setting sampling time -> ../../obj/get2x2.m
    load(Utilities.getObjBinFilePath('2x2.mat'));

    c = Constants();

    getOutput = @getObjectOutputNl1x1;
    ypp = c.testYInitVal;
    upp = c.testUInitVal;
    k = 5;
    YY = ypp * ones(k - 2, ny);
    UU = upp * ones(k - 2, nu);
    data = struct;

    % Assign test values
    if strcmp(valueName, 'N')
        N = testValue;
    elseif strcmp(valueName, 'Nu')
        Nu = testValue;
    elseif strcmp(valueName, 'ny')
        ny = testValue;
    elseif strcmp(valueName, 'nu')
        nu = testValue;
    elseif strcmp(valueName, 'getOutput')
        getOutput = testValue;
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
    elseif strcmp(valueName, 'data')
        data = testValue;
    end

    % Regulator
    reg = MPCNO(N, Nu, ny, nu, getOutput, 'mi', mi, 'lambda', lambda,...
        'ypp', ypp, 'upp', upp, 'uMin', uMin, 'uMax', uMax,...
        'duMin', duMin, 'duMax', duMax, 'yMin', yMin, 'yMax', yMax,...
        'k', k, 'YY', YY, 'UU', UU, 'data', data);
end
