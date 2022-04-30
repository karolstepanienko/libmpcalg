%% Constants
% Contains various constant values used in the project
classdef Constants
    properties (Access = public)
        % Paths
        libName  % (1,9) char array
        objPath  % (1,3) char array
        objBinPath  % (1,7) char array
        trajectoriesPath  % (1,14) char array
        plotPath  % (1,4) char array
        testPath  % (1,4) char array
        testStepResponsePath  % (1,17) char array
        testDMCPath  % (1,8) char array
        libFolders  % (1,7) cell
        % Constant numerical values
        plotWaitSec  % (1,1) int8
        testSimulationLength  % (1,1) int8
        testYInitVal  % (1,1) int8
        testUInitVal  % (1,1) int8
        % Algorithm types
        analyticalAlgType  % (1,10) char array
        fastAlgType  % (1,4) char array
        numericalAlgType  % (1,9) char array
        algTypes  % (1,3) cell
        % Constraints
        defaultMi  % (1,1) int8
        defaultLambda  % (1,1) int8
        defaultuMin  % (1,1) double
        defaultuMax  % (1,1) double
        defaultduMin  % (1,1) double
        defaultduMax  % (1,1) double
        defaultyMin  % (1,1) double
        defaultyMax  % (1,1) double
    end

    properties (Access = private)
        u = Utilities()  % Utilities object
    end

    methods
        %% Getters
        function libName = get.libName(obj)
            libName = 'libmpcalg';
        end

        function objPath = get.objPath(obj)
            objPath = 'obj';
        end

        function objBinPath = get.objBinPath(obj)
            objBinPath = obj.u.join({'obj', 'bin'}, filesep);
        end

        function trajectoriesPath = get.trajectoriesPath(obj)
            trajectoriesPath = obj.u.join({'obj', 'trajectory'}, filesep);
        end

        function plotPath = get.plotPath(obj)
            plotPath = 'plot';
        end

        function testPath = get.testPath(obj)
            testPath = 'test';
        end

        function testStepResponsePath = get.testStepResponsePath(obj)
            testStepResponsePath = obj.u.join({'test', 'stepResponse'}, filesep);
        end

        function testDMCPath = get.testDMCPath(obj)
            testDMCPath = obj.u.join({'test', 'DMC'}, filesep);
        end

        function libFolders = get.libFolders(obj)
            libFolders = {
                obj.objPath,
                obj.objBinPath,
                obj.trajectoriesPath,
                obj.plotPath,
                obj.testPath,
                obj.testStepResponsePath,
                obj.testDMCPath
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
    end
end
