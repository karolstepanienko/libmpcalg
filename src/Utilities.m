%% Utilities
% Class providing universal utilities
classdef Utilities
    methods (Access = public, Static = true)
        %% isOctave
        % Checks if script is run in OCTAVE
        function r = isOctave()
            persistent x;
            if (isempty (x))
                x = exist ('OCTAVE_VERSION', 'builtin');
            end
            r = x;
        end

        %% isMatlab
        % Checks if script is run in MATLAB
        function r = isMatlab()
            r = ~Utilities.isOctave();
        end

        %% sym2tf
        % Creates continuous-time transfer function model from symbolic expression.
        function Gs = sym2tf(symGs)
            [ny, nu] = size(symGs);
            Gs = tf('s');
            for i=1:ny
                for j=1:nu
                    [numerator, denominator] = numden(symGs(i, j));
                    numerator_vec = sym2poly(numerator);
                    denominator_vec = sym2poly(denominator);
                    Gs(i,j) = tf(numerator_vec, denominator_vec);
                end
            end
        end

        %% getGzFromNumDen
        % Creates discrete transmittance from discrete numerators
        % and denominators
        function Gz = getGzFromNumDen(numDen, st)
            [ny, nu] = size(numDen);
            allNum = {};
            allDen = {};
            for cy = 1:ny
                num = {};
                den = {};
                for cu = 1:nu
                    num = {num{:}, numDen{cy,cu}{1}};
                    den = {den{:}, numDen{cy,cu}{2}};
                end
                if size(allNum, 2) == 0
                    allNum = num;
                    allDen = den;
                else
                    allNum = {allNum{:}; num{:}};
                    allDen = {allDen{:}; den{:}};
                end
            end
            Gz = tf(allNum, allDen, st);
        end

        %% stackVector
        % Returns vertical vector containing n V vectors stacked on top of
        % each other
        % @param V must be a vertical vector
        function newVec = stackVector(V, n)
            newVec = zeros(n * length(V), 1);
            for i=1:n
                newVec((i-1)*length(V) + 1:i*length(V), 1) = V;
            end
        end

        %% addAllPaths
        % Adds all paths used by library
        % Platform independent
        function addAllPaths()
            c = Constants();
            absPath = getAbsPathToLib();
            for iPath=1:length(c.libFolders)
                relativePath = c.libFolders{iPath};
                fullPath = join({absPath, relativePath}, filesep);
                addpath(fullPath);
            end 
        end

        %% cdf
        % Create destination folder if it does not exist
        function cdf(savePath)
            [pathstr,~,~] = fileparts(savePath);
            if ~exist(pathstr, 'dir')
                mkdir(pathstr)
            end
        end

        %% getObjBinPath
        % Returns absolute path to obj/bin .mat file woth a given name
        function filePath = getObjBinFilePath(fileName)
            c = Constants();
            absPath = getAbsPathToLib();
            relativePath = c.objBinPath;
            filePath = join({absPath, relativePath, fileName}, filesep);
        end

        %% getYStepResponses
        % Returns all step responses collected on cy output
        function YstepResponses = getYStepResponses(cy, nu, ny, stepResponses, kk)
            YstepResponses = zeros(kk, ny);
            yIndex = 1;
            for iu=1:nu
                YstepResponses(:, yIndex) = stepResponses{iu, 1}(:,cy);
                yIndex = yIndex + 1;
            end
        end

        %% sortAxesList
        % Sort axes descending for every output
        function sortedAxesList = sortAxesList(nu, kk, YstepResponses, axesList)
            maxSRValues = zeros(1, nu);
            for iu=1:nu
                maxSRValues(1, iu) = max(abs(YstepResponses(:, iu)));
            end
            [~, sortIdx] = sort(maxSRValues, 2, 'descend');
            % Using sorting index to sort another array accordingly
            sortedAxesList = axesList(sortIdx);
        end

        %% sortAxes
        % Sorts axes so the axis with biggest values is first
        function sortedAxesList = sortAxes(maxYValues, axesList)
            [~, sortIdx] = sort(maxYValues, 2, 'descend');
            % Using sorting index to sort another array accordingly
            sortedAxesList = axesList(sortIdx);
        end

        function closeFigAfterTimeout(fig)
            % Figure timeout
            c = Constants();
            if c.plotWaitSec > 0
                pause(c.plotWaitSec);
                close(fig);
            end
        end

        % Wrapper for function out of class. Otherwise static methods in
        % one class do not see each other.
        function absPath = getAbsPathToLib()
            absPath = getAbsPathToLib();
        end

        %% join
        function joinedStr = join(strCellArr, delimiter)
            joinedStr = join(strCellArr, delimiter);
        end

        function returnVar = joinText(varargin)
            % Joins character arrays or strings together
            % @return char or string based on given parameters
            returnChar = ischar(varargin{1});
            if returnChar || Utilities.isOctave()
                % Concatenate chars in MATLAB or Octave
                returnVar = '';
                for i=1:length(varargin)
                    tmp = returnVar;
                    tmp = strcat({tmp}, {varargin{i}});
                    returnVar = tmp{1};
                end
            else
                returnVar = "";
                for i=1:length(varargin)
                    returnVar = strcat(returnVar, varargin{i});
                end
            end
        end

        function plotTitle = getPlotTitle(alg, algType)
            % Returns plot tile for given algorithm and it's type
            plotTitle = Utilities.joinText(...
                algType, ' ', upper(alg), ' ', 'algorithm');
        end

        function value = extractFromVarargin(charArray, vararginVar)
            % Extracts specific parameter with a name in charArray from varargin
            nout = max(nargout, 1) - 1;  % Get number of outputs
            value = '';
            for i=1:length(vararginVar)
                if strcmp(vararginVar{i}, charArray)
                    value = vararginVar{i + 1};
                end
            end
        end

        function varargin_ = replaceInVarargin(valueName, newValue, varargin_)
            % Replaces value of a parameter in varargin type variable
            for i=1:length(varargin_)
                if strcmp(varargin_{i}, valueName)
                    varargin_{i + 1} = newValue;
                end
            end
        end

        function choosenConstructorFunc = chooseAlgorithm(c, algorithm, algType)
            if strcmp(algorithm, c.algDMC)
                if strcmp(algType, c.analyticalAlgType)
                    choosenConstructorFunc = @AnalyticalDMC;
                elseif strcmp(algType, c.fastAlgType)
                    choosenConstructorFunc = @FastDMC;
                elseif strcmp(algType, c.numericalAlgType)
                    choosenConstructorFunc = @NumericalDMC;
                end
            elseif strcmp(algorithm, c.algMPCS)
                if strcmp(algType, c.analyticalAlgType)
                    choosenConstructorFunc = @AnalyticalMPCS;
                elseif strcmp(algType, c.fastAlgType)
                    choosenConstructorFunc = @FastMPCS;
                elseif strcmp(algType, c.numericalAlgType)
                    choosenConstructorFunc = @NumericalMPCS;
                end
            end
        end

        function e = calculateError(YY, Yzad)
            ny_YY = size(YY, 2);
            ny_Yzad = size(Yzad, 2);
            % Matrix sizes have to match
            assert(ny_YY == ny_Yzad)
            ny = ny_YY;
            e = 0;
            for cy = 1:ny
                e = e + (Yzad(:, cy) - YY(:, cy))' * (Yzad(:, cy) - YY(:, cy));
            end
        end

        function [algType, varargin_] = resolveAlgType(c, varargin_)
            % Validation object with data validation functions
            v = Validation();

            algType = Utilities.extractFromVarargin(c.algTypeVariableName,...
                varargin_);
            if strcmp(algType, '') ~= 1
                % Algorithm type was defined
                v.validAlgType(algType);  % Validate algorithm type
            else
                % Algorithm type was not defined, use analytical algorithm type
                algType = c.analyticalAlgType;
                varargin_ = Utilities.replaceInVarargin(...
                    c.algTypeVariableName, algType, varargin_);
            end
        end

        function loadPkgOptimInOctave()
            if Utilities.isOctave()
                pkg load optim
            end
        end

        function loadPkgParallelInOctave()
            if Utilities.isOctave()
                pkg load parallel
            end
        end

        function loadPkgControlInOctave()
            if Utilities.isOctave()
                pkg load control
            end
        end
    end
end

%% getAbsPathToLib
% Returns absolute path to the library with system correct file
% delimiters
function absLibPath = getAbsPathToLib()
    c = Constants();
    currentFile = mfilename('fullpath');
    splitted = split(currentFile, filesep);
    
    % Find where library name folder is
    for i=1:length(splitted)
        if strcmp(splitted{i}, c.libName)
            iLib= i;
        end
    end

    % Creates cell with absolute path to libmpcalg folders
    absPathToLibArr = splitted(1:iLib, 1);
    absLibPath = join(absPathToLibArr, filesep);
end

%% split
% Splits string on occurences of the separator
% Not in OCTAVE
function splitted = split(str, sep)
    tmpStr = "";
    splitted = cell(0, 1);
    for i=1:length(str)
        % Assuming strings are always horizontal
        if strcmp(str(1, i), filesep)
            splitted{end+1, 1} = tmpStr;
            tmpStr = "";
        else
            if Utilities.isOctave()
                % Does not trim trailing spaces
                tmpStr = cstrcat(tmpStr, str(1, i));
            else
                tmpStr = tmpStr + str(1, i);
            end
        end
    end
end

%% join
% Joins strings in an array with given delimiter
% Not in OCTAVE
function joinedStr = join(strCellArr, delimiter)
    tmpStr = "";
    for i=1:length(strCellArr)
        if i == 1
            tmpStr = strCellArr{i};
        else
            tmpStr = strcat(tmpStr, delimiter, strCellArr{i});
        end
    end
    joinedStr = tmpStr;
end
