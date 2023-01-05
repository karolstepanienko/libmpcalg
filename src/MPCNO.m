%% MPCNO
% Nonlinear Model Predictive Control algorithm
classdef MPCNO < ValidateMPCNO
    properties
        N  % Prediction horizon
        Nu  % Moving horizon
        ny  % Number of outputs
        nu  % Number of inputs
        getOutput  % Function handle for function allowing nonlinear object
                   % output calculation

        % Optional
        lambda  % Control weight
        uMin  % Minimal control value
        uMax  % Maximal control value
        ypp  % Output initial value
        upp  % Control initial value
        YY  % Output values
        UU  % Control values
        k  % Control loop iterator
    end

    properties (GetAccess = public, SetAccess = protected)
        uMinVec  % Used by fmincon
        uMaxVec  % Used by fmincon
        UU_k  % Current calculated control value
    end

    methods
        function obj = MPCNO(N, Nu, ny, nu, getOutput, varargin)
            obj = obj.validateMPCNOParams(N, Nu, ny, nu, getOutput, varargin);
            obj = obj.initMPCNO();
            Utilities.loadPkgOptimInOctave();
        end

        function obj = initMPCNO(obj)
            obj.uMinVec = obj.uMin * ones(obj.Nu, obj.nu);
            obj.uMaxVec = obj.uMax * ones(obj.Nu, obj.nu);
            obj.UU_k = obj.upp * ones(1, obj.nu);
        end

        function obj = calculateControl(obj, YY_k_1, YYzad_k)
            % Variables with necessary past values are kept in vectors defined
            % in algorithm class
            obj.YY(obj.k - 1, :) = YY_k_1;

            UU_k0 = obj.upp * ones(obj.Nu, obj.nu);  % Optimisation start point

            % Prepare target function filled with necessary parameters
            f = @(x)obj.targetFunc(x, YYzad_k);

            % x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)
            UUopt = fmincon(f, UU_k0, [], [], [], [], obj.uMinVec,...
                obj.uMaxVec, [], Constants.getFminconOptions());

            obj.UU(obj.k, :) = UUopt(1, :);
            obj.UU_k = obj.UU(obj.k, :);
            obj.k = obj.k + 1;
        end

        function UU_k = getControl(obj)
            UU_k = obj.UU_k;
        end
    end

    methods (Access = protected)
        function e = targetFunc(obj, x, YYzad_k)
            % Assigning control values calculated by fmincon
            obj.UU(obj.k:obj.k + obj.Nu - 1, :) = x;

            du = zeros(obj.Nu, obj.nu);
            if obj.k == 1 du(obj.k, :) = obj.UU(obj.k, :)...
                - ones(1, obj.nu) * obj.upp;
            else du(obj.k, :) = obj.UU(obj.k, :) - obj.UU(obj.k - 1, :); end
            du(obj.k + 1:obj.k + obj.Nu - 1, :) =...
                obj.UU(obj.k + 1:obj.k + obj.Nu - 1, :)...
                - obj.UU(obj.k:obj.k + obj.Nu - 2, :);
            % Above same as:
            % for p=1:Nu-1 du(k + p, :) = UU(k + p, :) - UU(k + p - 1, :); end

            % Assuming control values constant between Nu and N
            obj.UU(obj.k + obj.Nu:obj.k + obj.N, :) =...
                Utilities.stackVectorHorizontally(...
                obj.UU(obj.k + obj.Nu - 1, :), obj.N - obj.Nu + 1);

            % Predicting object output values for N elements ahead
            for p=0:obj.N-1
                obj.YY(obj.k + p, :) = obj.getOutput(obj.ypp, obj.YY,...
                    obj.upp, obj.UU, obj.k + p);
            end

            % Trajectory constant on prediction horizon
            e = 0;
            for cy = 1:obj.ny
                YYzadCompare = Utilities.stackVectorHorizontally(...
                    YYzad_k(cy), obj.N);
                e = e + (YYzadCompare - obj.YY(obj.k:obj.k + obj.N-1, cy))'...
                    * (YYzadCompare - obj.YY(obj.k:obj.k + obj.N-1, cy));
            end

            % Control change limiting with lambda penalty
            for cu = 1:obj.nu
                e = e + obj.lambda(cu) * du(obj.k:obj.k + obj.Nu - 1, cu)'...
                    *(du(obj.k:obj.k + obj.Nu-1, cu));
            end
        end
    end
end
