%% Constants
% Contains various constant values used in the project
classdef Constants
    properties (Access = public)
        libName % (1,1) string
        objPath % (1,1) string
        objBinPath % (1,1) string
        plotPath % (1,1) string
        testPath % (1,1) string
        testStepResponsePath % (1,1) string
        testDMCPath % (1,1) string
        libFolders % (:, 1) cell
        plotWaitSec % (1,1) int8
        testSimulationLength % (1,1) int8
    end

    properties (Access = private)
        u = Utilities() % Utilities object
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
                obj.objPath;
                obj.objBinPath;
                obj.plotPath;
                obj.testPath;
                obj.testStepResponsePath;
                obj.testDMCPath;
            };
        end

        function plotWaitSec = get.plotWaitSec(obj)
            % Set to negative to turn off plot closing
            plotWaitSec = -1;
        end

        function testSimulationLength = get.testSimulationLength(obj)
            testSimulationLength = 1000;
        end
    end
end
