%% Constants
% Contains various constant values used in the project
classdef Constants
    properties (Access = public)
        % Paths
        libName  % (1,9) char array
        srcPath  % (1,3) char array
        objPath  % (1,3) char array
        objBinPath  % (1,7) char array
        objNonlinearPath  % (1,13) char array
        trajectoriesPath  % (1,14) char array
        plotPath  % (1,4) char array
        runPath  % (1,3) char array
        runStepResponsePath  % (1,16) char array
        runDMCPath  % (1,7) char array
        runGPCPath  % (1,7) char array
        runMPCSPath  % (1,8) char array
        runMPCNOPath  % (1,9) char array
        mwe  % (1, 3) char array
        test  % (1, 4) char array
        testValidation  % (1,15) char array
        testAbsoluteControlError  % (1,24) char array
        testAggregate  % (1,13) char array
        testRelativeControlError  % (1,24) char array
        testRelativeControlErrorStepResponse  % (1,36) char array
        testRelativeControlErrorDMC  % (1,27) char array
        testRelativeControlErrorMPCS  % (1,28) char array
        testLambda0   % (1,11) char array
        libFolders  % (1,7) cell
        % Constant numerical values
        plotWaitSec  % (1,1) int8
        testSimulationLength  % (1,1) int8
        testYInitVal  % (1,1) int8
        testUInitVal  % (1,1) int8
        testXInitVal  % (1,1) int8
        numIdx  % (1,1) int8
        denIdx  % (1,1) int8
        % Algorithm types
        analyticalAlgType  % (1,10) char array
        fastAlgType  % (1,4) char array
        numericalAlgType  % (1,9) char array
        algTypes  % (1,3) cell
        % Variables (used in 'tagging' objects and switching between them)
        algTypeVariableName  % (1, 7) char array
        % Algorithms
        algDMC  % (1, 3) char array
        algGPC  % (1, 3) char array
        algMPCS  % (1, 4) char array
        % Constraints and default values
        defaultMi  % (1,1) double
        defaultLambda  % (1,1) double
        defaultuMin  % (1,1) double
        defaultuMax  % (1,1) double
        defaultduMin  % (1,1) double
        defaultduMax  % (1,1) double
        defaultyMin  % (1,1) double
        defaultyMax  % (1,1) double
        defaultK  % (1,1) int8
        defaultEmptyMatrix % (0, 0) double
    end

    properties (Access = private)
        u = Utilities()  % Utilities object
    end

    methods
        %% Getters
        function libName = get.libName(obj)
            libName = 'libmpcalg';
        end

        function srcPath = get.srcPath(obj)
            srcPath = 'src';
        end

        function objPath = get.objPath(obj)
            objPath = 'obj';
        end

        function objBinPath = get.objBinPath(obj)
            objBinPath = obj.u.join({'obj', 'bin'}, filesep);
        end

        function objNonlinearPath = get.objNonlinearPath(obj)
            objNonlinearPath = obj.u.join({'obj', 'nonlinear'}, filesep);
        end

        function trajectoriesPath = get.trajectoriesPath(obj)
            trajectoriesPath = obj.u.join({'obj', 'trajectory'}, filesep);
        end

        function plotPath = get.plotPath(obj)
            plotPath = 'plot';
        end

        function runPath = get.runPath(obj)
            runPath = 'run';
        end

        function runStepResponsePath = get.runStepResponsePath(obj)
            runStepResponsePath = obj.u.join({'run', 'stepResponse'}, filesep);
        end

        function runDMCPath = get.runDMCPath(obj)
            runDMCPath = obj.u.join({'run', 'DMC'}, filesep);
        end

        function runGPCPath = get.runGPCPath(obj)
            runGPCPath = obj.u.join({'run', 'GPC'}, filesep);
        end

        function runMPCSPath = get.runMPCSPath(obj)
            runMPCSPath = obj.u.join({'run', 'MPCS'}, filesep);
        end

        function runMPCNOPath = get.runMPCNOPath(obj)
            runMPCNOPath = obj.u.join({'run', 'MPCNO'}, filesep);
        end

        function mwe = get.mwe(obj)
            mwe = 'mwe';
        end

        function test = get.test(obj)
            test = 'test';
        end

        function testValidation = get.testValidation(obj)
            testValidation = obj.u.join({'test', 'validation'}, filesep);
        end

        function testAbsoluteControlError = get.testAbsoluteControlError(obj)
            testAbsoluteControlError = obj.u.join(...
                {'test', 'absoluteControlError'}, filesep);
        end

        function testAggregate = get.testAggregate(obj)
            testAggregate = obj.u.join({'test', 'aggregate'}, filesep);
        end

        function testRelativeControlError = get.testRelativeControlError(obj)
            testRelativeControlError = obj.u.join(...
                {'test', 'relativeControlError'}, filesep);
        end

        function testRelativeControlErrorStepResponse =...
            get.testRelativeControlErrorStepResponse(obj)
            testRelativeControlErrorStepResponse = obj.u.join(...
                {'test', 'relativeControlError', 'stepResponse'}, filesep);
        end

        function testRelativeControlErrorDMC =...
            get.testRelativeControlErrorDMC(obj)
            testRelativeControlErrorDMC = obj.u.join(...
                {'test', 'relativeControlError', 'DMC'}, filesep);
        end

        function testRelativeControlErrorMPCS =...
            get.testRelativeControlErrorMPCS(obj)
            testRelativeControlErrorMPCS = obj.u.join(...
                {'test', 'relativeControlError', 'MPCS'}, filesep);
        end

        function testLambda0 = get.testLambda0(obj)
            testLambda0 = obj.u.join({'test', 'lambda0'}, filesep);
        end

        function libFolders = get.libFolders(obj)
            libFolders = {
                obj.srcPath,
                obj.objPath,
                obj.objBinPath,
                obj.objNonlinearPath,
                obj.trajectoriesPath,
                obj.plotPath,
                obj.runPath,
                obj.runStepResponsePath,
                obj.runDMCPath,
                obj.runGPCPath,
                obj.runMPCSPath,
                obj.runMPCNOPath,
                obj.mwe,
                obj.test,
                obj.testValidation,
                obj.testAbsoluteControlError,
                obj.testAggregate,
                obj.testRelativeControlError,
                obj.testRelativeControlErrorStepResponse,
                obj.testRelativeControlErrorDMC,
                obj.testRelativeControlErrorMPCS,
                obj.testLambda0
            };
        end

        function plotWaitSec = get.plotWaitSec(obj)
            % Set to negative to turn off plot closing
            plotWaitSec = -1;
        end

        function testSimulationLength = get.testSimulationLength(obj)
            testSimulationLength = 1000;
        end

        function testYInitVal = get.testYInitVal(obj)
            testYInitVal = 0;
        end

        function testUInitVal = get.testUInitVal(obj)
            testUInitVal = 0;
        end

        function testXInitVal = get.testXInitVal(obj)
            testXInitVal = 0;
        end

        function numIdx = get.numIdx(obj)
            numIdx = 1;
        end

        function denIdx = get.denIdx(obj)
            denIdx = 2;
        end

        function analytical = get.analyticalAlgType(obj)
            analytical = 'analytical';
        end
 
        function fast = get.fastAlgType(obj)
            fast = 'fast';
        end
 
        function numerical = get.numericalAlgType(obj)
            numerical = 'numerical';
        end

        function algTypes = get.algTypes(obj)
            algTypes = {
                obj.analyticalAlgType,
                obj.fastAlgType,
                obj.numericalAlgType
            };
        end

        function algTypeVariableName = get.algTypeVariableName(obj)
            algTypeVariableName = 'algType';
        end

        function algDMC = get.algDMC(obj)
            algDMC = 'DMC';
        end

        function algGPC = get.algGPC(obj)
            algGPC = 'GPC';
        end

        function algMPCS = get.algMPCS(obj)
            algMPCS = 'MPCS';
        end

        function defaultMi = get.defaultMi(obj)
            defaultMi = 1;
        end

        function defaultLambda = get.defaultLambda(obj)
            defaultLambda = 1;
        end

        function defaultuMin = get.defaultuMin(obj)
            defaultuMin = -Inf;
        end

        function defaultuMax = get.defaultuMax(obj)
            defaultuMax = Inf;
        end

        function defaultduMin = get.defaultduMin(obj)
            defaultduMin = -Inf;
        end

        function defaultduMax = get.defaultduMax(obj)
            defaultduMax = Inf;
        end

        function defaultyMin = get.defaultyMin(obj)
            defaultyMin = -Inf;
        end

        function defaultyMax = get.defaultyMax(obj)
            defaultyMax = Inf;
        end

        function defaultK = get.defaultK(obj)
            defaultK = 2;
        end

        function defaultEmptyMatrix = get.defaultEmptyMatrix(obj)
            defaultEmptyMatrix = [];
        end
    end

    methods (Access = public, Static)
        function allowedNumericError = getAllowedNumericLimit(obj)
            allowedNumericError = power(10, -10);
        end

        function optimOptions = getQuadprogOptions(obj)
            optimOptions = optimset('Display', 'off');
        end

        function optimOptions = getFminconOptions(obj)
            optimOptions = optimset('Display','off','Algorithm','sqp',...
                'TolFun',1e-10,'TolX',1e-10,'MaxIter',10000);
        end
    end
end
