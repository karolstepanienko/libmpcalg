classdef MPC
    properties (Access=protected)
        Sp % Sp - cell of step response matrixes in p moment
        Mp % Mp matrix used by DMC algorithm
        M  % M matrix used by DMC algorithm
        Xi % Xi matrix used by DMC algorithm
        Lambda % Lambda matrix used by DMC algorithm
        K % K matrix used by DMC algorithm
    end

    methods (Access=protected)

        %% initMPC
        % Creates necessary matrices for MPC algorithms
        function obj = initMPC(obj)
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
            (obj.M' * obj.Xi * obj.M + obj.Lambda) \ (obj.M' * obj.Xi);
        end
    end
end
