%% NumericalDMC
% DMC algorithm that uses quadprog - a quadratic equations solver to calculate
% control value changes
classdef NumericalDMC < CoreDMC & NumericalUtilities
    methods
        %% NumericalDMC
        % Creates NumericalDMC regulator object
        % @param D Dynamic horizon
        % @param N Prediction horizon
        % @param Nu Moving horizon
        % @param ny Number of outputs
        % @param nu Number of inputs
        % @param stepResponses Cell of control object step response(s)
        % @param mi Output importance
        % @param lambda Control weight
        % @param uMin Minimal control value
        % @param uMax Maximal control value
        % @param duMin Minimal control change value
        % @param duMax Maximal control change value
        % @param yMin Minimal output value
        % @param yMax Maximal output value
        function obj = NumericalDMC(D, N, Nu, ny, nu, stepResponses, varargin)
            obj = ValidateDMC.validateNumericalDMCParams(obj, D, N, Nu,...
                ny, nu, stepResponses, varargin);
            obj = obj.initCoreDMC();
            obj = obj.initNumerical(obj.M, obj.Xi, obj.Lambda);
        end

        %% calculateControl
        % Calculates new, current object control values
        % Should be run in a loop
        % @param YY_k_1     horizontal vector of most recent output values
        % @param YYzad_k     horizontal vector of target trajectory values
        function UU_k = calculateControl(obj, YY_k_1, YYzad_k, varargin)
            YY_k_1 = obj.stackVectorNN1Times(YY_k_1);
            YYzad_k = obj.stackYzadVector(YYzad_k);

            if obj.nz < 0
                YY_k = obj.Mp * obj.dUUp_k;
            else
                % Disturbance compensation
                UUz_k = varargin{1};
                dUUz_k = UUz_k - obj.UUz_k_1;
                obj.UUz_k_1 = UUz_k;
                obj.dUUzp_k = [dUUz_k';...
                    obj.dUUzp_k(1:(length(obj.dUUzp_k)-obj.nz), 1)];
                YY_k = obj.Mp * obj.dUUp_k + obj.Mzp * obj.dUUzp_k;
            end
            YY_0 = YY_k_1 + YY_k(obj.ny*obj.ny + 1:end);

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

            dU_k = obj.dUU_k(1:obj.nu);

            obj.dUUp_k = [dU_k; obj.dUUp_k(1:(length(obj.dUUp_k)-obj.nu), 1)];

            UU_k = obj.UU_k + dU_k';
            obj.UU_k = UU_k;
        end
    end
end
