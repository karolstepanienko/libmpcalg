classdef (Abstract) MPC
    properties
        % Required
        D  % Dynamic horizon
        N  % Prediction horizon
        Nu  % Moving horizon
        stepResponses  % Cell of control object step response(s)
        ny  % Number of outputs
        nu  % Number of inputs

        % Optional
        mi  % Output importance
        lambda  % Control weight
        uMin  % Minimal control value
        uMax  % Maximal control value
        duMin  % Minimal control change value
        duMax  % Maximal control change value

        % Calculated internally
        U_k  % Current control value
    end

    properties (Access = protected)
        Sp  % Sp cell of step response matrixes in p moment
        Mp  % Mp matrix used by DMC algorithm
        M   % M matrix used by DMC algorithm
        Xi  % Xi matrix used by DMC algorithm
        Lambda  % Lambda matrix used by DMC algorithm
        K  % K matrix used by DMC algorithm
        dUU_k  % Vector containing control values
        dUUp_k  % DUUp vector containing past control value changes
    end

    methods
        %% Getters
        function ny = get.ny(obj)
            ny = obj.ny;
        end

        function nu = get.nu(obj)
            nu = obj.nu;
        end
    end

    methods (Access = protected)

        %% initMPC
        % Creates necessary matrices for MPC algorithms
        function obj = initMPC(obj)
            obj.dUU_k = obj.initdUU_k();
            obj.dUUp_k = obj.initdUUp_k();
            obj.U_k = obj.initU_k();
            obj.Sp = obj.getSp();
            obj.Mp = obj.getMp();
            obj.M = obj.getM();
            obj.Xi = obj.getXi();
            obj.Lambda = obj.getLambda();
            obj.K = obj.getK();
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
                        if p <= size(obj.stepResponses{i}(:, j), 1)
                            sp(j,i) = obj.stepResponses{i}(p,j);
                        else
                            % Stretch the step response assuming that elements
                            % after D are equal to last known step response
                            % value
                            sp(j,i) = obj.stepResponses{i}(end,j);
                        end
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
        % Creates full K matrix used by DMC algorithm
        function K = getK(obj)
            K =...
            (obj.M' * obj.Xi * obj.M + obj.Lambda) \ (obj.M' * obj.Xi);
        end

        %% getYYFromY
        % Tries to stack given vector N time vertically
        % @throws MalformedVector error if stacking is not possible.
        function YY = getYYFromY(obj, Y)
            if size(Y, 1) == obj.ny && size(Y, 2) == 1  % Vertical vector
                YY = Utilities.stackVector(Y, obj.N);
            elseif size(Y, 1) == 1 && size(Y, 2) == obj.ny  % Horizontal vector
                YY = Utilities.stackVector(Y', obj.N);
            else
                error("Malformed vector. Cannot be stacked.");
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
