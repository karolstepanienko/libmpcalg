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
        mi  % Output importance
        lambda  % Control weight
        uMin  % Minimal control value
        uMax  % Maximal control value
        duMin  % Minimal control change value
        duMax  % Maximal control change value
        yMin  % Minimal output value
        yMax  % Maximal output value
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
        duMinVec  % Used to enforce limits
        duMaxVec  % Used to enforce limits
        yMinVec  % Used to enforce limits
        yMaxVec  % Used to enforce limits
        YY_k_1_m  % Last output value predicted using object model
        ym  % Temporary variable with last output value predicted using object
            % model
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
            obj.duMinVec = obj.duMin * ones(1, obj.nu);
            obj.duMaxVec = obj.duMax * ones(1, obj.nu);
            obj.yMinVec = obj.yMin * ones(1, obj.ny);
            obj.yMaxVec = obj.yMax * ones(1, obj.ny);
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

        function UU_k = calculateControl(obj, YY_k_1, YYzad_k)
            % Variables with necessary past values are kept in vectors defined
            % in algorithm class
            obj.YY(obj.k - 1, :) = YY_k_1;

            % Hot start of optimisation start point
            UU_k0 = zeros(obj.nu * obj.Nu, 1);
            for i=0:obj.Nu - 2
                UU_k0(i * obj.nu + 1:(i + 1) * obj.nu) = obj.UU(i + obj.k, :)';
            end
            % Stretch last element
            UU_k0(obj.nu * (obj.Nu - 1) + 1: obj.nu * obj.Nu) =...
                obj.UU(obj.k + obj.Nu - 2, :)';

            % Prepare target function filled with necessary parameters
            f = @(x)obj.targetFunc(x, YYzad_k);
            nonlcon = @(x)obj.applyLimits(x);

            % x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)
            try
                UUopt = fmincon(f, UU_k0, [], [], [], [], obj.uMinVec,...
                    obj.uMaxVec, nonlcon, obj.c.fminconOptions);
            catch
                Warnings.removedYConstraints();
                obj.yMin = obj.c.defaultMPCNOyMin;
                obj.yMax = obj.c.defaultMPCNOyMax;
                obj.yMinVec = obj.yMin * ones(1, obj.ny);
                obj.yMaxVec = obj.yMax * ones(1, obj.ny);
                try
                    UUopt = fmincon(f, UU_k0, [], [], [], [], obj.uMinVec,...
                        obj.uMaxVec, nonlcon, obj.c.fminconOptions);
                catch
                    Warnings.removedDUConstraints();
                    obj.duMin = obj.c.defaultMPCNOduMin;
                    obj.duMax = obj.c.defaultMPCNOduMax;
                    obj.duMinVec = obj.duMin * ones(1, obj.nu);
                    obj.duMaxVec = obj.duMax * ones(1, obj.nu);
                    try
                        UUopt = fmincon(f, UU_k0, [], [], [], [],...
                            obj.uMinVec, obj.uMaxVec, nonlcon,...
                            obj.c.fminconOptions);
                    catch
                        Warnings.removedUConstraints();
                        obj.uMin = obj.c.defaultuMin;
                        obj.uMax = obj.c.defaultuMax;
                        obj.uMinVec = obj.uMin * ones(obj.Nu, obj.nu);
                        obj.uMaxVec = obj.uMax * ones(obj.Nu, obj.nu);
                        UUopt = fmincon(f, UU_k0, [], [], [], [],...
                            obj.uMinVec, obj.uMaxVec, nonlcon,...
                            obj.c.fminconOptions);
                    end
                end
            end
            obj.YY_k_1_m = obj.ym;

            obj.UU(obj.k, :) = UUopt(1:obj.nu)';
            UU_k = obj.UU(obj.k, :);
            obj.k = obj.k + 1;
        end
    end

    methods (Access = protected)
        function e = targetFunc(obj, x, YYzad_k)
            du = obj.getDU(x);

            obj.stretchUUtoN();
            obj.runPrediction();

            % Trajectory constant on prediction horizon
            e = 0;
            for cy = 1:obj.ny
                YYzadCompare = Utilities.stackVectorHorizontally(...
                    YYzad_k(cy), obj.N);
                e = e + obj.mi(cy)...
                    * (YYzadCompare - obj.YY(obj.k:obj.k + obj.N-1, cy))'...
                    * (YYzadCompare - obj.YY(obj.k:obj.k + obj.N-1, cy));
            end

            % Control change limiting with lambda penalty
            for cu = 1:obj.nu
                e = e + obj.lambda(cu) * du(:, cu)' * du(:, cu);
            end
        end

        function [c, ceq] = applyLimits(obj, x)
            % ceq = 0 limits not used
            ceq = [];

            % du limits
            du = obj.getDU(x);
            duVec = zeros(obj.Nu * obj.nu, 1);
            for i=1:obj.Nu
                duVec((i - 1) * obj.nu + 1:i*obj.nu, 1) = du(i, :)';
            end

            % y limits
            obj.stretchUUtoN();
            YYVec = zeros(obj.N * obj.ny, 1);
            obj.runPrediction();
            for p=0:obj.N-1
                YYVec(p * obj.ny + 1:(p+1)*obj.ny, 1) = obj.YY(obj.k + p, :)';
            end

            c = [ -duVec + Utilities.stackVector(obj.duMinVec, obj.Nu);
                   duVec - Utilities.stackVector(obj.duMaxVec, obj.Nu);
                  -YYVec + Utilities.stackVector(obj.yMinVec, obj.N);
                   YYVec - Utilities.stackVector(obj.yMaxVec, obj.N)
            ];
        end

        function du = getDU(obj, x)
            % Assigning control values calculated by fmincon
            for i=0:obj.Nu - 1
                obj.UU(obj.k + i, :) = x(i * obj.nu + 1:(i + 1) * obj.nu);
            end

            du = zeros(obj.Nu, obj.nu);
            for p=0:obj.Nu - 1
                % obj.k >= 2
                du(1 + p, :) = obj.UU(obj.k + p, :) - obj.UU(obj.k - 1 + p, :);
            end
        end

        function stretchUUtoN(obj)
            % Assuming control values constant between Nu and N
            obj.UU(obj.k + obj.Nu:obj.k + obj.N, :) =...
                Utilities.stackVectorHorizontally(...
                obj.UU(obj.k + obj.Nu - 1, :), obj.N - obj.Nu + 1);
        end

        function runPrediction(obj)
            % Predicting object output values for N elements ahead
            d_k = obj.YY(obj.k - 1, :) - obj.YY_k_1_m;
            for p=0:obj.N-1
                [obj.YY(obj.k + p, :)] = obj.getOutput(obj, obj.k + p);
                obj.YY(obj.k + p, :) = obj.YY(obj.k + p, :) + d_k;
            end
            obj.ym = obj.YY(obj.k, :);
        end
    end
end
