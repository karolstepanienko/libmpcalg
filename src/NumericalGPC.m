%% NumericalGPC
% GPC algorithm that uses quadprog - a quadratic equations solver to calculate
% control value changes
classdef NumericalGPC < CoreGPC & NumericalUtilities
    methods
        %% NumericalGPC
        % Creates NumericalGPC regulator object
        % @param N Prediction horizon
        % @param Nu Moving horizon
        % @param ny Number of outputs
        % @param nu Number of inputs
        % @param A output value coefficients
        % @param B control value coefficients
        % @param mi Output importance
        % @param lambda Control weight
        % @param InputDelay
        % @param uMin Minimal control value
        % @param uMax Maximal control value
        % @param duMin Minimal control change value
        % @param duMax Maximal control change value
        % @param yMin Minimal output value
        % @param yMax Maximal output value
        function obj = NumericalGPC(N, Nu, ny, nu, A, B, varargin)
            obj = ValidateGPC.validateNumericalGPCParams(obj, N, Nu, ny, nu,...
                A, B, varargin);
            obj = obj.initCoreGPC();
            obj = obj.initNumerical(obj.M, obj.Xi, obj.Lambda);
        end

        %% calculateControl
        % Calculates new, current object control values
        % Should be run in a loop
        % @param YY_k_1        horizontal vector of current output values
        % @param YYzad_k     horizontal vector of target trajectory values
        function UU_k = calculateControl(obj, YY_k_1, YYzad_k, varargin)
            obj.YY(obj.k - 1, :) = YY_k_1;
            YYzad_k = obj.stackYzadVector(YYzad_k);

            if obj.nz < 0
                d_k_1 = YY_k_1 - obj.YYm_k_1;
                dd_k_1 = zeros((obj.N - obj.N1 + 1) * obj.ny, 1);
                for i=1:obj.N - obj.N1 + 1
                    dd_k_1((i - 1) * obj.ny + 1:i*obj.ny, 1) = d_k_1';
                end
                YY_0 = obj.getYY_0() + dd_k_1;
            else
                % Disturbance compensation
                obj.YYz(obj.k - 1, :) = YY_k_1;
                UUz_k = varargin{1};
                YY_0 = obj.getYY_0() + obj.getYYz_0(UUz_k);
            end

            f = -2 * obj.M' * obj.Xi * (YYzad_k - YY_0);

            % UU_k_1 = obj.UU_k
            UU_k_1 = Utilities.stackVector(obj.UU_k, obj.Nu);

            % Quadprog optimisation problem equations
            Aeq = [];
            beq = [];
            x0 = obj.dUU_k;  % Hot start
            exitFlag = -1; i = 0;
            while exitFlag < 0
                switch i
                    case 1
                        obj.removeYLimits(); Warnings.removedYConstraints();
                    case 2
                        obj.removeDULimits(); Warnings.removedDUConstraints();
                    case 3
                        obj.removeULimits(); Warnings.removedUConstraints();
                    case 4
                        Exceptions.throwOptimisationCouldNotContinue();
                end
                b = obj.getBMatrix(UU_k_1, YY_0);
                [obj.dUU_k, ~, exitFlag] = quadprog(obj.H, f, obj.AMatrix, b,...
                    Aeq, beq, obj.duuMin, obj.duuMax, x0,...
                    obj.c.quadprogOptions);
                i = i + 1;
            end

            obj.UU(obj.k, :) = obj.UU_k + obj.dUU_k(1:obj.nu, 1)';
            UU_k = obj.UU(obj.k, :);
            obj.UU_k = UU_k;

            obj.k = obj.k + 1;
        end
    end
end
