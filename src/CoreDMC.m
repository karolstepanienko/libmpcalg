classdef (Abstract) CoreDMC < MPC
    properties (Access = public)
        % Required
        D  % Dynamic horizon
        N  % Prediction horizon
        Nu  % Moving horizon
        stepResponses  % Cell of control object step response
        ny  % Number of outputs
        nu  % Number of inputs

        % Optional
        mi  % Output importance
        lambda  % Control weight
        uMin  % Minimal control value
        uMax  % Maximal control value
        duMin  % Minimal control change value
        duMax  % Maximal control change value
    end

    properties (GetAccess = public, SetAccess = protected)
        Sp  % Sp cell of step response matrices in p moment
        Mp  % Mp matrix used by DMC algorithm
        M   % M matrix used by DMC algorithm
        Xi  % Xi matrix used by DMC algorithm
        Lambda  % Lambda matrix used by DMC algorithm
        K  % K matrix used by DMC algorithm
        dUU_k  % Vector containing current control value change
        dUUp_k  % DUUp vector containing past control value changes
        UU_k  % Current control value
        % Debugging
        YY_0  % (N*ny, 1) Object trajectory without further control changes
    end

    methods
        %% getControl
        % Returns horizontal vector of new control values
        function UU_k = getControl(obj)
            UU_k = obj.UU_k';
        end
    end

    methods (Access = protected)
        %% initCoreDMC
        % Creates necessary matrices for MPC algorithms
        function obj = initCoreDMC(obj)
            obj.YY_0 = zeros(obj.N*obj.ny, 1);
            obj.dUU_k = obj.initdUU_k();
            obj.dUUp_k = obj.initdUUp_k();
            obj.UU_k = obj.initUU_k();
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

        %% initdUUp
        function dUUp_k = initdUUp_k(obj)
            dUUp_k = zeros(obj.nu*(obj.D - 1), 1);
        end

        %% initdUU
        function dUU_k = initdUU_k(obj)
            dUU_k = zeros(obj.nu*obj.Nu, 1);
        end

        %% getUU_k
        function UU_k = initUU_k(obj)
            UU_k = zeros(1, obj.nu);
        end
    end
end
