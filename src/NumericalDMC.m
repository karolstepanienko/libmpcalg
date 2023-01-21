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
        function UU_k = calculateControl(obj, YY_k_1, YYzad_k)
            YY_k_1 = obj.stackVectorNTimes(YY_k_1);
            YYzad_k = obj.stackVectorNTimes(YYzad_k);

            YY_k = obj.Mp * obj.dUUp_k;
            YY_0 = YY_k_1 + YY_k(obj.ny*obj.ny + 1:end);

            f = -2 * obj.M' * obj.Xi * (YYzad_k - YY_0);

            % UU_k_1 = obj.UU_k
            UU_k_1 = Utilities.stackVector(obj.UU_k, obj.Nu);

            % Quadprog optimisation problem equations
            b = [
                -obj.UUmin + UU_k_1;
                obj.UUmax - UU_k_1;
                -obj.YYmin + YY_0;
                obj.YYmax - YY_0
            ];

            Aeq = [];
            beq = [];
            x0 = [];
            dUU_k = quadprog(obj.H, f, obj.AMatrix, b, Aeq, beq, obj.duuMin,...
                obj.duuMax, x0, obj.c.quadprogOptions);

            dU_k = dUU_k(1:obj.nu);

            obj.dUUp_k = [dU_k; obj.dUUp_k(1:(length(obj.dUUp_k)-obj.nu), 1)];

            UU_k = obj.UU_k + dU_k';
            obj.UU_k = UU_k;
        end
    end
end
