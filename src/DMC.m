classdef DMC
    properties
        %% DMC parmameters
        D % Dynamic horizon
        N % Prediction horizon
        Nu % Moving horizon
        stepResponses % Control object step response(s)
        mi % Output importance
        lambda % Input importance
        ny % Number of outputs
        nu % Number of inputs
        U_k % Current control value
        uMin % Minimal control value
        uMax % Maximal control value
        duMin % Minimal control change value
        duMax % Maximal control change value
    end

    properties (Access = private)
        Sp % Sp - cell of step response matrixes in p moment
        Mp % Mp matrix used by DMC algorithm
        M  % M matrix used by DMC algorithm
        Xi % Xi matrix used by DMC algorithm
        Lambda % Lambda matrix used by DMC algorithm
        K % K matrix used by DMC algorithm
        dUU_k % Vector containing control values
        dUUp_k % DUUp vector containing past control value changes
    end

    methods
        function obj = DMC(D, N, Nu, stepResponses, mi, lambda, ...
                uMin, uMax, duMin, duMax)
            arguments
                % enforce integers
                D (1,1) double
                N (1,1) double
                Nu (1,1) double
                stepResponses
                mi (:,1) double
                lambda (:,1) double
                uMin (1,1) double = -1;
                uMax (1,1) double = 1;
                duMin (1,1) double = -0.1
                duMax (1,1) double = 0.1;
            end
            obj.D = D;
            obj.N = N;
            obj.Nu = Nu;
            obj.stepResponses = stepResponses;
            obj.mi = mi;
            obj.lambda = lambda;
            obj.uMin = uMin;
            obj.uMax = uMax;
            obj.duMin = duMin;
            obj.duMax = duMax;
            
            obj = obj.runPreloop();
        end

        %% calculateControl
        % Calculates new, current object control values
        % Should be run in a loop
        % @param Y_k        horizontal vector of current output values
        % @param Yzad_k     horizontal vector of target trajectory values
        function obj = calculateControl(obj, Y_k, Yzad_k)
            YY_k = obj.getYY_k(Y_k');
            YYzad_k = obj.getYYzad_k(Yzad_k');
            
            % Get YY_0
            YY_0 = YY_k + obj.Mp * obj.dUUp_k;
            % Get new control change value
            obj.dUU_k = obj.K * (YYzad_k - YY_0);
            
            % Limit control change values
            dU_k = obj.limitdU_k(obj.dUU_k(1:obj.nu));
            
            % Shift dUUp values
            obj.dUUp_k = [dU_k;...
                obj.dUUp_k(1:(length(obj.dUUp_k)-obj.nu), 1)];

            % Get new control value
            % Here U_k = U_k_1 and is updated
            obj.U_k = obj.limitU_k(obj.U_k + obj.dUU_k(1:obj.nu, 1));
        end
        
        %% Getters
        function nu = get.nu(obj)
            nu = size(obj.stepResponses, 1);
        end
        
        function ny = get.ny(obj)
            if obj.nu > 1 % For object with multiple inputs
                % Get ncolumns for first input
                ny = size(obj.stepResponses{1,1}, 2);
            else % For object with single input
                ny = size(obj.stepResponses, 2);
            end
        end
        
        %% getControl
        % Returns horizontal vector of new control values
        function U_k = getControl(obj)
            U_k = obj.U_k';
        end
    end

    methods (Access=private)
        %% runPreloop
        % Prepares necessary matrices
        function obj = runPreloop(obj)
            obj.Sp = obj.getSp();
            obj.Mp = obj.getMp();
            obj.M = obj.getM();
            obj.Xi = obj.getXi();
            obj.Lambda = obj.getLambda();
            obj.K = obj.getK();
            obj.dUU_k = obj.initdUU_k();
            obj.dUUp_k = obj.initdUUp_k();
            obj.U_k = obj.initU_k();
        end
        
        %% getSp
        % Creates Sp matix from step response data in cell format
        function Sp = getSp(obj)
            % Variable initialisation
            Sp = cell(obj.D, 1);
            sp = zeros(obj.ny, obj.nu); % Step response matrix in moment p

            for p=1:obj.D % Step response moment
                for i=1:obj.nu
                    for j=1:obj.ny
                        sp(j,i) = obj.stepResponses{i}(p,j);
                    end
                end
                Sp{p, 1} = sp;
            end
        end
        
        %% getMp
        % Creates Mp matrix used by DMC algorithm
        function Mp = getMp(obj)
            % Variable initialisation
            Mp = zeros(obj.ny*obj.N, obj.nu*(obj.D - 1));
            for i=1:obj.N
                for j=1:obj.D-1
                    Mp((i - 1)*obj.ny + 1:i*obj.ny,...
                        (j - 1)*obj.nu + 1:j*obj.nu) = ...
                        obj.Sp{ min(obj.D, i+j), 1} - obj.Sp{j, 1};
                end
            end
        end
        
        %% getM
        % Creates M matrix used by DMC algorithm
        function M = getM(obj)
            % Variable initialisation
            M = zeros(obj.ny*obj.N, obj.nu*obj.Nu);
            for j=1:obj.Nu
                for i=j:obj.N
                    M((i - 1)*obj.ny + 1:i*obj.ny,...
                        (j - 1)*obj.nu + 1:j*obj.nu) = obj.Sp{i-j+1, 1};
                end
            end
        end
        %% getXi
        % Creates Xi matrix used by DMC algorithm
        function Xi = getXi(obj)
            Xi = zeros(obj.ny*obj.N);
            for i=1:obj.N
                Xi((i - 1)*obj.ny + 1:i*obj.ny,...
                    (i - 1)*obj.ny + 1:i*obj.ny) = ...
                    diag(obj.mi); % square ny x ny matrix
            end
        end

        %% getLambdaMatrix
        % Creates Lambda matrix used by DMC algorithm
        function Lambda = getLambda(obj)
            Lambda = zeros(obj.nu*obj.Nu);
            for i=1:obj.Nu
                Lambda((i - 1)*obj.nu + 1:i*obj.nu,...
                    (i - 1)*obj.nu + 1:i*obj.nu) = ...
                    diag(obj.lambda); % square ny x ny matrix
            end
        end

        %% getKMatrix
        % Creates K matrix used by DMC algorithm
        function K = getK(obj)
            K =...
            (obj.M' * obj.Xi * obj.M + obj.Lambda)^(-1) * obj.M' * obj.Xi;
        end

        %% getYYzad_k
        function YYzad_k = getYYzad_k(obj, Yzad_k)
            % Check if vector has improper number of elements
            if size(Yzad_k, 1) ~= obj.ny || size(Yzad_k, 2) ~= 1
                ME = getImproperVectorSizeException(Yzad_k);
                throw(ME);
            else
                YYzad_k = stackVector(Yzad_k, obj.N);
            end
        end
        
        %% getYY_k
        function YY_k = getYY_k(obj, Y_k)
            % Check if vector has improper number of elements
            if size(Y_k, 1) ~= obj.ny || size(Y_k, 2) ~= 1
                ME = getImproperVectorSizeException(Y_k);
                throw(ME);
            else
                YY_k = stackVector(Y_k, obj.N);
            end
        end
        
        %% initdUUp
        function dUUp_k = initdUUp_k(obj)
            dUUp_k = zeros(obj.nu*(obj.D - 1), 1);
        end
        
        %% initdUU
        function dUU_k = initdUU_k(obj)
            dUU_k = zeros(obj.nu*obj.Nu, 1);
        end
        
        %% getUU_k
        function U_k = initU_k(obj)
            U_k = zeros(obj.nu, 1);
        end
        
        %% limitU_k
        function U_k = limitU_k(obj, U_k)
            for i=1:obj.nu
                if U_k(i, 1) < obj.uMin
                    U_k(i, 1) = obj.uMin;
                elseif U_k(i, 1) > obj.uMax
                    U_k(i, 1) = obj.uMax;
                end
            end
        end

        %% limitdU_k
        function dU_k = limitdU_k(obj, dU_k)
            for i=1:obj.nu
                if dU_k(i, 1) < obj.duMin
                    dU_k(i, 1) = obj.duMin;
                elseif dU_k(i, 1) > obj.duMax
                    dU_k(i, 1) = obj.duMax;
                end
            end
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

%% getImproperVectorSizeException
function ME = getImproperVectorSizeException(V)
    ME = MException('MyComponent:improperVectorSize',...
    'Vector %s has improper size.', mat2str(V));
end










