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


%-------------------------------------- nz -------------------------------------
% isnumeric
%!error <MPCS: failed validation of NZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('nz', '2');

% isscalar (is not a matrix)
%!error <MPCS: failed validation of NZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('nz', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <MPCS: failed validation of NZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('nz', 1.1);

% isPositive (x > 0)
%!error <MPCS: failed validation of NZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('nz', -1);


%----------------------------------- nz_assign ---------------------------------
%!error <Some required parameters \('nz', 'nxz', 'dAz', 'dBz', 'dCz', 'dDz'\) for MPCS disturbance mechanism were left unassigned> testMPCSParameters('nz_assign', 1)


%------------------------------------ nxz --------------------------------------
% isnumeric
%!error <MPCS: failed validation of NXZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('nxz', '2');

% isscalar (is not a matrix)
%!error <MPCS: failed validation of NXZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('nxz', [1, 1]);

% isInteger (x == round(x) && mod(x, 1) == 0)
%!error <MPCS: failed validation of NXZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('nxz', 1.1);

% isPositive (x > 0)
%!error <MPCS: failed validation of NXZ with @\(x\) isnumeric \(x\) && isscalar \(x\) && x == round \(x\) && mod \(x, 1\) == 0 && obj.isPositive \(x\)> testMPCSParameters('nxz', -1);


%----------------------------------- nxz_assign --------------------------------
%!error <Some required parameters \('nz', 'nxz', 'dAz', 'dBz', 'dCz', 'dDz'\) for MPCS disturbance mechanism were left unassigned> testMPCSParameters('nxz_assign', 1)


%------------------------------------- dAz -------------------------------------
% isnumeric
%!error <MPCS: failed validation of DAZ with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\) && size \(x, 1\) == size \(x, 2\)> testMPCSParameters('dAz', '2');

% Value has a type of 'double'
%!error <MPCS: failed validation of DAZ with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\) && size \(x, 1\) == size \(x, 2\)> testMPCSParameters('dAz', int8(1));

% ismatrix (3D array is not a matrix)
%!error <MPCS: failed validation of DAZ with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\) && size \(x, 1\) == size \(x, 2\)> testMPCSParameters('dAz', zeros(1, 1, 2));

% isSquare
%!error <MPCS: failed validation of DAZ with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\) && size \(x, 1\) == size \(x, 2\)> testMPCSParameters('dAz', zeros(1, 2));

% isSquare (nx, nx)
%!error <dAz should be a square matrix> testMPCSParameters('dAz', zeros(3, 3));


%----------------------------------- dAz_assign ---------------------------------
%!error <Some required parameters \('nz', 'nxz', 'dAz', 'dBz', 'dCz', 'dDz'\) for MPCS disturbance mechanism were left unassigned> testMPCSParameters('dAz_assign', [1, 1; 1, 1])


%------------------------------------- dBz -------------------------------------
% isnumeric
%!error <MPCS: failed validation of DBZ with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dBz', '2');

% Value has a type of 'double'
%!error <MPCS: failed validation of DBZ with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dBz', int8(1));

% ismatrix (3D array is not a matrix)
%!error <MPCS: failed validation of DBZ with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dBz', zeros(1, 1, 2));

% MatrixInvalidSize
%!error <Matrix dBz should have 4 rows and 2 columns> testMPCSParameters('dBz', zeros(1, 2));


%----------------------------------- dBz_assign ---------------------------------
%!error <Some required parameters \('nz', 'nxz', 'dAz', 'dBz', 'dCz', 'dDz'\) for MPCS disturbance mechanism were left unassigned> testMPCSParameters('dBz_assign', [1, 1; 1, 1])


%------------------------------------- dCz -------------------------------------
% isnumeric
%!error <MPCS: failed validation of DCZ with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dCz', '2');

% Value has a type of 'double'
%!error <MPCS: failed validation of DCZ with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dCz', int8(1));

% ismatrix (3D array is not a matrix)
%!error <MPCS: failed validation of DCZ with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dCz', zeros(1, 1, 2));

% MatrixInvalidSize
%!error <Matrix dCz should have 2 rows and 4 columns> testMPCSParameters('dCz', zeros(1, 2));


%----------------------------------- dCz_assign ---------------------------------
%!error <Some required parameters \('nz', 'nxz', 'dAz', 'dBz', 'dCz', 'dDz'\) for MPCS disturbance mechanism were left unassigned> testMPCSParameters('dCz_assign', [1, 1; 1, 1])


%------------------------------------- dDz -------------------------------------
% isnumeric
%!error <MPCS: failed validation of DDZ with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dDz', '2');

% Value has a type of 'double'
%!error <MPCS: failed validation of DDZ with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dDz', int8(1));

% ismatrix (3D array is not a matrix)
%!error <MPCS: failed validation of DDZ with @\(x\) isnumeric \(x\) && isa \(x, 'double'\) && ismatrix \(x\)> testMPCSParameters('dDz', zeros(1, 1, 2));

% MatrixInvalidSize
%!error <Matrix dDz should have 2 rows and 2 columns> testMPCSParameters('dDz', zeros(1, 2));


%----------------------------------- dDz_assign ---------------------------------
%!error <Some required parameters \('nz', 'nxz', 'dAz', 'dBz', 'dCz', 'dDz'\) for MPCS disturbance mechanism were left unassigned> testMPCSParameters('dDz_assign', [1, 1; 1, 1])


%-------------------------------------- mi -------------------------------------
% isnumeric
%!error <MPCS: failed validation of MI with isnumeric> testMPCSParameters('mi', '2');

% stretch single element
%!warning <Assumed array mi consists of 2 elements with a value of 1> testMPCSParameters('mi', 1)

% has ny Elements
%!error <Array mi should have \(2\) elements> testMPCSParameters('mi', [1, 1, 1])

% can be horizontal
%!test(testMPCSParameters('mi', [1, 1]))

% can be vertical
%!test(testMPCSParameters('mi', [1; 1]))

% is not a matrix
%!error <Value mi should be a horizontal or vertical array with 2 elements> (testMPCSParameters('mi', [1, 1; 1, 1]))


%------------------------------------ lambda -----------------------------------
% isnumeric
%!error <MPCS: failed validation of LAMBDA with isnumeric> testMPCSParameters('lambda', '2');

% lambda = 0
%!warning <Lambda value set to 0. Regulator might be unstable.> testMPCSParameters('lambda', [0, 0])

% stretch single element
%!warning <Assumed array lambda consists of 2 elements with a value of 1> testMPCSParameters('lambda', 1)

% has nu Elements
%!error <Array lambda should have \(2\) elements> testMPCSParameters('lambda', [1, 1, 1])

% can be horizontal
%!test(testMPCSParameters('lambda', [1, 1]))

% can be vertical
%!test(testMPCSParameters('lambda', [1; 1]))

% is not a matrix
%!error <Value lambda should be a horizontal or vertical array with 2 elements> (testMPCSParameters('lambda', [1, 1; 1, 1]))


%-------------------------------------- uMin -----------------------------------
% isnumeric
%!error <MPCS: failed validation of UMIN with isnumeric> testMPCSParameters('uMin', '2');

% stretch single element
%!warning <Assumed array uMin consists of 2 elements with a value of 1> testMPCSParameters('uMin', 1)

% has ny Elements
%!error <Array uMin should have \(2\) elements> testMPCSParameters('uMin', [1, 1, 1])

% can be horizontal
%!test(testMPCSParameters('uMin', [1, 1]))

% can be vertical
%!test(testMPCSParameters('uMin', [1; 1]))

% is not a matrix
%!error <Value uMin should be a horizontal or vertical array with 2 elements> (testMPCSParameters('uMin', [1, 1; 1, 1]))


%-------------------------------------- uMax -----------------------------------
% isnumeric
%!error <MPCS: failed validation of UMAX with isnumeric> testMPCSParameters('uMax', '2');

% stretch single element
%!warning <Assumed array uMax consists of 2 elements with a value of 1> testMPCSParameters('uMax', 1)

% has ny Elements
%!error <Array uMax should have \(2\) elements> testMPCSParameters('uMax', [1, 1, 1])

% can be horizontal
%!test(testMPCSParameters('uMax', [1, 1]))

% can be vertical
%!test(testMPCSParameters('uMax', [1; 1]))

% is not a matrix
%!error <Value uMax should be a horizontal or vertical array with 2 elements> (testMPCSParameters('uMax', [1, 1; 1, 1]))


%------------------------------------- duMin -----------------------------------
% isnumeric
%!error <MPCS: failed validation of DUMIN with @\(x\) isnumeric \(x\) && obj.isNegative \(x\)> testMPCSParameters('duMin', '2');

% isNegative (x < 0)
%!error <MPCS: failed validation of DUMIN with @\(x\) isnumeric \(x\) && obj.isNegative \(x\)> testMPCSParameters('duMin', 2);

% stretch single element
%!warning <Assumed array duMin consists of 2 elements with a value of -1> testMPCSParameters('duMin', -1)

% has ny Elements
%!error <Array duMin should have \(2\) elements> testMPCSParameters('duMin', [-1, -1, -1])

% can be horizontal
%!test(testMPCSParameters('duMin', [-1, -1]))

% can be vertical
%!test(testMPCSParameters('duMin', [-1; -1]))

% is not a matrix
%!error <Value duMin should be a horizontal or vertical array with 2 elements> (testMPCSParameters('duMin', [-1, -1; -1, -1]))


%------------------------------------- duMax -----------------------------------
% isnumeric
%!error <MPCS: failed validation of DUMAX with @\(x\) isnumeric \(x\) && obj.isPositive \(x\)> testMPCSParameters('duMax', '2');

% isPositive (x > 0)
%!error <MPCS: failed validation of DUMAX with @\(x\) isnumeric \(x\) && obj.isPositive \(x\)> testMPCSParameters('duMax', -1);

% stretch single element
%!warning <Assumed array duMax consists of 2 elements with a value of 1> testMPCSParameters('duMax', 1)

% has ny Elements
%!error <Array duMax should have \(2\) elements> testMPCSParameters('duMax', [1, 1, 1])

% can be horizontal
%!test(testMPCSParameters('duMax', [1, 1]))

% can be vertical
%!test(testMPCSParameters('duMax', [1; 1]))

% is not a matrix
%!error <Value duMax should be a horizontal or vertical array with 2 elements> (testMPCSParameters('duMax', [1, 1; 1, 1]))


%------------------------------------- yMin ------------------------------------
% isnumeric
%!error <MPCS: failed validation of YMIN with isnumeric> testMPCSParameters('yMin', '2');

% stretch single element
%!warning <Assumed array yMin consists of 2 elements with a value of 1> testMPCSParameters('yMin', 1)

% has ny Elements
%!error <Array yMin should have \(2\) elements> testMPCSParameters('yMin', [1, 1, 1])

% can be horizontal
%!test(testMPCSParameters('yMin', [1, 1]))

% can be vertical
%!test(testMPCSParameters('yMin', [1; 1]))

% is not a matrix
%!error <Value yMin should be a horizontal or vertical array with 2 elements> (testMPCSParameters('yMin', [1, 1; 1, 1]))

% Not accessible in analyticalAlgType
%!error <MPCS: argument 'YMIN' is not a valid parameter> testMPCSParameters('algType', Constants().analyticalAlgType);

% Not accessible in fastAlgType
%!error <MPCS: argument 'YMIN' is not a valid parameter> testMPCSParameters('algType', Constants().fastAlgType);


%------------------------------------- yMax ------------------------------------
% isnumeric
%!error <MPCS: failed validation of YMAX with isnumeric> testMPCSParameters('yMax', '2');

% stretch single element
%!warning <Assumed array yMax consists of 2 elements with a value of 1> testMPCSParameters('yMax', 1)

% has ny Elements
%!error <Array yMax should have \(2\) elements> testMPCSParameters('yMax', [1, 1, 1])

% can be horizontal
%!test(testMPCSParameters('yMax', [1, 1]))

% can be vertical
%!test(testMPCSParameters('yMax', [1; 1]))

% is not a matrix
%!error <Value yMax should be a horizontal or vertical array with 2 elements> (testMPCSParameters('yMax', [1, 1; 1, 1]))


%------------------------------------ algType ----------------------------------
% algType can be analytical, fast or numerical
%!error <validatestring: 'something' does not match any of\nanalytical, fast, numerical> testMPCSParameters('algType', 'something');


function testMPCSParameters(valueName, testValue)
    %% Object
    % Setting sampling time -> ../../obj/get2x2.m
    load(Utilities.getObjBinFilePath('2x2.mat'));

    c = Constants();

    algType = c.numericalAlgType;
    nz = nu; nxz = nx; dAz = dA; dBz = dB; dCz = dC; dDz = dD;

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
    elseif strcmp(valueName, 'nx')
        nx = testValue;
    elseif strcmp(valueName, 'nxz')
        nxz = testValue;
    elseif strcmp(valueName, 'dA')
        dA = testValue;
    elseif strcmp(valueName, 'dAz')
        dAz = testValue;
    elseif strcmp(valueName, 'dB')
        dB = testValue;
    elseif strcmp(valueName, 'dBz')
        dBz = testValue;
    elseif strcmp(valueName, 'dC')
        dC = testValue;
    elseif strcmp(valueName, 'dCz')
        dCz = testValue;
    elseif strcmp(valueName, 'dD')
        dD = testValue;
    elseif strcmp(valueName, 'dDz')
        dDz = testValue;
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
        reg = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
            'mi', mi, 'lambda', lambda,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'nz', nz,...
            'algType', algType);
    elseif strcmp(valueName, 'nxz_assign')
        reg = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
            'mi', mi, 'lambda', lambda,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'nxz', nxz,...
            'algType', algType);
    elseif strcmp(valueName, 'dAz_assign')
        reg = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
            'mi', mi, 'lambda', lambda,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'dAz', dAz,...
            'algType', algType);
    elseif strcmp(valueName, 'dBz_assign')
        reg = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
            'mi', mi, 'lambda', lambda,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'dBz', dBz,...
            'algType', algType);
    elseif strcmp(valueName, 'dCz_assign')
        reg = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
            'mi', mi, 'lambda', lambda,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'dCz', dCz,...
            'algType', algType);
    elseif strcmp(valueName, 'dDz_assign')
        reg = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
            'mi', mi, 'lambda', lambda,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'dDz', dDz,...
            'algType', algType);
    else
        % Regulator with disturbance parameters
        reg = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
            'mi', mi, 'lambda', lambda,...
            'uMin', uMin, 'uMax', uMax,...
            'duMin', duMin, 'duMax', duMax,...
            'yMin', yMin, 'yMax', yMax,...
            'nz', nz, 'nxz', nxz, 'dAz', dAz, 'dBz', dBz, 'dCz', dCz,...
            'dDz', dDz,...
            'algType', algType);
    end
end
