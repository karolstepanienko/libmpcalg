classdef (Abstract) CoreDMC < MPC & handle
    properties
        D  % Dynamic horizon
        Dz  % Dynamic disturbance horizon
        stepResponses  % Cell of control object step response
        stepResponsesZ  % Cell of disturbance object step response
        dUUp_k  % DUUp vector containing past control value changes
        dUUzp_k  % DZZp vector containing past and one current disturbance value
                % changes
    end

    properties (GetAccess = public, SetAccess = protected)
        Mp  % Mp matrix used by DMC algorithm
        Mzp  % Mzp matrix used by DMC algorithm compensation
        UUz_k_1  % Last known UUz disturbance value
    end

    methods (Access = protected)
        %% initCoreDMC
        % Creates necessary matrices for MPC algorithms
        function obj = initCoreDMC(obj)
            obj.c = Constants();
            obj.dUUp_k = zeros(obj.nu*(obj.D - 1), 1);
            % One element more due to knowing dZZ_k value
            obj.dUUzp_k = zeros(obj.nz*obj.Dz, 1);
            obj.UU_k = zeros(1, obj.nu);
            obj.UUz_k_1 = zeros(1, obj.nz);
            % stepResponses contains first step response element
            obj.Sp = obj.getSp(obj.stepResponses, obj.D + obj.N1);
            obj.Mp = obj.getMp();
            if obj.Dz > 0
                obj.Szp = obj.getSp(obj.stepResponsesZ, obj.Dz + obj.N1);
                obj.Mzp = obj.getMzp();
            end
            obj.M = obj.getM();
            obj.Xi = obj.getXi();
            obj.Lambda = obj.getLambda();
            obj.K = obj.getK(obj.M, obj.Xi, obj.Lambda);
        end

        %% getMp
        % Creates Mp ( ny(N - N1 + 1) x nu(D - 1) ) matrix used by DMC algorithm
        function Mp = getMp(obj)
            Mp = zeros(obj.ny*(obj.N - obj.N1 + 1), obj.nu*(obj.D - 1));
            for i=1:obj.N - obj.N1 + 1 + obj.ny
                for j=1:obj.D-1
                    Mp((i - 1)*obj.ny + 1:i*obj.ny,...
                        (j - 1)*obj.nu + 1:j*obj.nu) = ...
                        obj.Sp{min(obj.D, i + obj.N1 - 1 + j), 1}...
                            - obj.Sp{j, 1};
                end
            end
        end

        %% getMzp
        % Creates Mzp ( ny(N - N1 + 1) x nuDz ) matrix used by DMC
        % algorithm in disturbance compensation
        function Mzp = getMzp(obj)
            % Without first column
            Mzp = zeros(obj.ny*(obj.N - obj.N1 + 1), obj.nz*(obj.Dz - 1));
            for i=1:obj.N - obj.N1 + 1 + obj.ny
                for j=1:obj.Dz-1
                    Mzp((i - 1)*obj.ny + 1:i*obj.ny,...
                        (j - 1)*obj.nz + 1:j*obj.nz) = ...
                        obj.Szp{min(obj.Dz, i + obj.N1 - 1 + j), 1}...
                            - obj.Szp{j, 1};
                end
            end
            % Creating first column
            col = zeros(obj.ny*(obj.N - obj.N1 + 1), obj.nz);
            % size(obj.Szp)
            for i=1:obj.N - obj.N1 + 1 + obj.ny
                % i
                col((i - 1)*obj.ny + 1:i*obj.ny, :) =...
                    obj.Szp{min(obj.Dz, i + obj.N1 - 1), 1};
            end
            % Adding first column
            Mzp = [col, Mzp];
        end
    end
end
