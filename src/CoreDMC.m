classdef (Abstract) CoreDMC < MPC
    properties
        D  % Dynamic horizon
        stepResponses  % Cell of control object step response
    end

    properties (GetAccess = public, SetAccess = protected)
        Mp  % Mp matrix used by DMC algorithm
        dUUp_k  % DUUp vector containing past control value changes
    end

    methods (Access = protected)
        %% initCoreDMC
        % Creates necessary matrices for MPC algorithms
        function obj = initCoreDMC(obj)
            obj.c = Constants();
            obj.dUUp_k = zeros(obj.nu*(obj.D - 1), 1);
            obj.UU_k = zeros(1, obj.nu);
            obj.Sp = obj.getSp(obj.stepResponses, obj.D);
            obj.Mp = obj.getMp();
            obj.M = obj.getM();
            obj.Xi = obj.getXi();
            obj.Lambda = obj.getLambda();
            obj.K = obj.getK(obj.M, obj.Xi, obj.Lambda);
        end

        %% getMp
        % Creates Mp matrix used by DMC algorithm
        function Mp = getMp(obj)
            Mp = zeros(obj.ny*obj.N, obj.nu*(obj.D - 1));
            for i=1:obj.N
                for j=1:obj.D-1
                    Mp((i - 1)*obj.ny + 1:i*obj.ny,...
                        (j - 1)*obj.nu + 1:j*obj.nu) = ...
                        obj.Sp{ min(obj.D, i+j), 1} - obj.Sp{j, 1};
                end
            end
        end
    end
end
