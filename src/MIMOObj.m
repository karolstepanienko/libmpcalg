%% MIMOObj
% Class delivering MIMO object functionalities
% TODO
% Probably git reset this
% switch from creating yCell and uCell to getting vectors while rotating
% over inputs and outputs
% denominators are the same for one INPUT
classdef MIMOObj
    properties (Access = public)
        A; % Relation between internal process variables
        B; % Relation between internal process variables and inputs
        C; % Relation between outputs and internal process variables
        D; % Relation between outputs and inputs
        st; % Sampling time
        ny; % Number of outputs
        nu; % Number of inputs
    end
    
    properties (Access = private)
        u % Utilities object
        Gs % Continuous transmittance
        Gz % Discrete transmittance
        numDen % Numerators and denominators
    end
    
    methods
        %% MIMOObj
        % Creates MIMO object model using differential equations
        function obj = MIMOObj(A, B, C, D, st)
            obj.A = A;
            obj.B = B;
            obj.C = C;
            obj.D = D;
            obj.st = st;
            obj.u = Utilities();
            obj = getModel(obj);
        end
    
        %% Getters
        function ny = get.ny(obj)
            ny = size(obj.C, 1);
        end
        function nu = get.nu(obj)
            nu = max([size(obj.B, 2), size(obj.D, 2)]);
        end
        function Gs = getGs(obj)
            Gs = obj.Gs;
        end
        function Gz = getGz(obj)
            Gz = obj.Gz;
        end
        
        function numDen = getnumDen(obj)
            numDen = obj.numDen;
        end
        
        %% getStepResponses
        function stepResponses = getStepResponses(obj, kk)
            stepResponses = cell(obj.nu, 1);
            for i=1:obj.nu % for every input
                stepResponses{i, 1} = obj.getStepResponse(i, kk);
            end
        end
        %% getOutput
        function y = getOutput(obj, YY, UU, ypp, upp, k)
            y = zeros(1, obj.ny);
            y = y + obj.getUOutput(UU, upp, k);
            y = y + obj.getYOutput(YY, ypp, k);
        end
        
        %% getOutput DEPRECIATED
        % Calculate output of a MIMO object
        % @return   y         vector of output values
        function y = getOutput1(obj, YY, UU, k)
            [uCell, yCell] = obj.getObjectData(UU, YY, k);
            y = zeros(obj.ny, 1); % output values

            for i=1:obj.ny % for every output
                for j=1:obj.nu % for every input
                    cnum = obj.numDen{i,j}{1};
                    cden = obj.numDen{i,j}{2};
                    % Numerator changes in every input and output
                    % combination
%                     num
%                     uCell{j,1}
                    
                    y(i,1) = y(i,1) + cnum*uCell{j, 1};
                end
%                 den
%                 yCell{i,1}
                % Denominator is the same across one output
                y(i, 1) = y(i,1) - cden*yCell{i, 1};
            end    
        end
    end
    
    methods (Access = private)
        %% getStepResponse
        % Returns output response for a step on a given input
        function YY = getStepResponse(obj, choosenU, kk)
            [obj.ny, obj.nu] = size(obj.numDen);
            %% Variable initialisation
            YY = zeros(kk, obj.ny);
            UU = zeros(kk, obj.nu);
            ypp = 0;
            upp = 0;

            %% Add control step
            % Step starts at k = 1 (matlab indexing),
            % so step response will start at k = 2
            UU(:, choosenU) = ones(kk, 1);

            for k=1:kk
                YY(k, :) = obj.getOutput(YY, UU, ypp, upp, k);
            end
        end
        
        function y = getUOutput(obj, UU, upp, k)
            y = zeros(1, obj.ny);
            for cy=1:obj.ny
                for cu=1:obj.nu
                    num = obj.numDen{cy,cu}{1};
                    uVec = obj.getuVec(UU(:, cu), length(num), upp, k);
                    y(1, cy) = y(1, cy) + num*uVec;
                end
            end
        end
        
        function y = getYOutput(obj, YY, ypp, k)
            denominators = cell(obj.nu, 1);
            for cu=1:obj.nu
                denominators{cu, 1} = obj.numDen{1, cu}(2);
            end
            % Assert if there is exactly one denominator for every input
%             for cy=1:obj.ny
%                 for cu=1:obj.nu
%                     obj.numDen{cy, cu}{2}
%                     cell2mat(denominators{cu, 1})
%                     assert(isequal(obj.numDen{cy, cu}{2},...
%                         cell2mat(denominators{cu, 1})));
%                 end
%             end
            % Calculate the outputs
            y = zeros(1, obj.ny);
            for cy=1:obj.ny
                den = obj.numDen{cy, 1}{2};
                yVec = obj.getyVec(YY(:, cy), length(den), ypp, k);
                y(1, cy) = y(1, cy) - den(2:end) * yVec;
            end
        end

        %% getuVec
        % Creates vector of past u values
        function uVec = getuVec(obj, U, numLen, upp, k)
            uVec = zeros(numLen, 1);
            for i=0:numLen - 1
                if k <= i
                    uVec(i+1, 1) = upp;
                else
                    uVec(i+1, 1) = U(k - i, 1);
                end
            end
        end
        
        %% getyVec
        % Creates vector of past y values
        function yVec = getyVec(obj, Y, denLen, ypp, k)
            yVec = zeros(denLen - 1, 1);
            for i=1:denLen - 1
                 if k <= i
                    yVec(i, 1) = ypp;
                else
                    yVec(i, 1) = Y(k - i, 1);
                end
            end
        end
        
        %% getModel
        % Returns an object with model info when run in MATLAB.
        % Loads object model data from file when run in OCTAVE.
        function obj = getModel(obj)
            if obj.u.isOctave() ~= 0
               if isfile('./model.mat') % Try opening saved model
                    load('./model.mat', 'numDen');
                    obj.Gz = tf(1, 1, 1);
                    obj.numDen = numDen;
               else
                    disp("Cannot create model in octave.");
                    disp("Required function c2d is not implemented.");
                    exit;
               end
            else % If running in MATLAB
                obj = getDiscreteTransmittance(obj);
                obj.numDen = getNumDen(obj);
                numDen = obj.numDen;
                save('model.mat', 'numDen');
            end
        end
        
        %% getDiscreteTransmittance
        % Returns discrete transmittance
        % Due to lack of implementation in octave of c2d method, this can
        % be run only in MATLAB
        function obj = getDiscreteTransmittance(obj)
            I = eye(size(obj.C, 1));
            syms s; % Create symbolic variable
            if obj.D ~= 0
                symEq = obj.C*((s*I - obj.A)^-1)*obj.B + obj.D;
            else
                symEq = obj.C*((s*I - obj.A)^-1)*obj.B;
            end
            obj.Gs = obj.u.sym2tf(symEq);
            obj.Gz = c2d(obj.Gs, obj.st);
        end
        
        %% getNumDen
        % Returns numerators and denumerators cell for every transmittance 
        % for every combination of output and input
        % numDen{current y, current u}{1 for nominator / 2 for denominator}
        function numDen = getNumDen(obj)
            numDen = cell(obj.ny, obj.nu);
            for i=1:obj.ny
                for j=1:obj.nu
                    num = obj.Gz(i,j).Num{1}(1:end);
                    % value in front of y(k) is always 1
                    % therefore it is not needed
                    den = obj.Gz(i,j).Den{1}(1:end); 
                    numDen{i, j} = {num; den};
                end
            end
        end
    end
end