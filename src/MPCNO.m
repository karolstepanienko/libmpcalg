%% MPCNO
% Nonlinear Model Predictive Control algorithm
classdef MPCNO < handle
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
        data  % Custom not validated parameter passed to getOutput function
    end

    properties (GetAccess = public, SetAccess = protected)
        c  % Constants object
        uMinVec  % Used by fmincon
        uMaxVec  % Used by fmincon
        YY_k_1_m  % Last output value predicted using object model
        ym  % Temporary variable with last output value predicted using object
            % model
        UU_k  % Current calculated control value
    end

    methods
        function obj = MPCNO(N, Nu, ny, nu, getOutput, varargin)
            obj = ValidateMPCNO.validateMPCNOParams(obj, N, Nu, ny, nu,...
                getOutput, varargin);
            obj = obj.initMPCNO();
            Utilities.loadPkgOptimInOctave();
        end

        function obj = initMPCNO(obj)
            obj.c = Constants();
            obj.uMinVec = obj.uMin * ones(obj.Nu, obj.nu);
            obj.uMaxVec = obj.uMax * ones(obj.Nu, obj.nu);
            obj.UU_k = obj.upp * ones(1, obj.nu);
            UUlength = size(obj.UU, 1);
            % Hot start
            if UUlength == 0
                obj.UU = obj.upp * ones(obj.Nu + obj.k, obj.nu);
            % Stretch last element for hot start purpose
            elseif UUlength < obj.Nu + obj.k
                for i=UUlength+1:obj.Nu + obj.k
                    obj.UU(i, :) = obj.UU(UUlength, :);
                end
            end
            obj.YY_k_1_m = obj.ypp * ones(1, obj.ny);
            obj.ym = obj.ypp * ones(1, obj.ny);
        end

        function obj = calculateControl(obj, YY_k_1, YYzad_k)
            % Variables with necessary past values are kept in vectors defined
            % in algorithm class
            obj.YY(obj.k - 1, :) = YY_k_1;

            % Hot start of optimisation start point
            UU_k0 = [obj.UU(obj.k:obj.k + obj.Nu - 2, :); obj.UU(obj.k + obj.Nu - 2, :)];

            % Prepare target function filled with necessary parameters
            f = @(x)obj.targetFunc(x, YYzad_k);

            % x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)
            UUopt = fmincon(f, UU_k0, [], [], [], [], obj.uMinVec,...
                obj.uMaxVec, [], obj.c.fminconOptions);
            obj.YY_k_1_m = obj.ym;

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
            % duLimits

            % Assuming control values constant between Nu and N
            obj.UU(obj.k + obj.Nu:obj.k + obj.N, :) =...
                Utilities.stackVectorHorizontally(...
                obj.UU(obj.k + obj.Nu - 1, :), obj.N - obj.Nu + 1);

            % Predicting object output values for N elements ahead
            d_k = obj.YY(obj.k - 1, :) - obj.YY_k_1_m;
            for p=0:obj.N-1
                [obj.YY(obj.k + p, :), data] = obj.getOutput(obj, obj.k + p);
                obj.YY(obj.k + p, :) = obj.YY(obj.k + p, :) + d_k;
                obj.data = data;
            end
            obj.ym = obj.YY(obj.k, :);

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
