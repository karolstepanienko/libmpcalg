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
        function sortedAxesList = sortAxesList(iy, nu, kk, YstepResponses, axesList)
            maxSRValues = zeros(1, nu);
            for iu=1:nu
                maxSRValues(1, iu) = max(abs(YstepResponses(:, iu)));
            end
            [~, sortIdx] = sort(maxSRValues, 2, 'descend');
            % Using sorting index to sort another array accordingly
            sortedAxesList = axesList(sortIdx);
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
