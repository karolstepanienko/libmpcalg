%% NumericalGPC
% GPC algorithm that uses quadprog - a quadratic equations solver to calculate
% control value changes
classdef NumericalGPC < CoreGPC & NumericalUtilities & ValidateGPC
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
            obj = obj.validateNumericalGPCParams(N, Nu, ny, nu, A, B, varargin);
            obj = obj.initCoreGPC();
            obj = obj.initNumerical(obj.M, obj.Xi, obj.Lambda);
        end

        %% calculateControl
        % Calculates new, current object control values
        % Should be run in a loop
        % @param YY_k_1        horizontal vector of current output values
        % @param YYzad_k     horizontal vector of target trajectory values
        function obj = calculateControl(obj, YY_k_1, YYzad_k)
            obj.YY(obj.k - 1, :) = YY_k_1;
            YY_k = obj.stackVectorNTimes(YY_k_1);
            YYYzad_k = obj.stackVectorNTimes(YYzad_k);

            % Get YY_0
            YY_0 = obj.getYY_0();

            % f vector used by quadprog
            f = -2 * obj.M' * obj.Xi * (YYYzad_k - YY_0);

            % Most recent control values
            UU_k_1 = Utilities.stackVector(obj.UU_k, obj.Nu);

            % Quadprog optimisation problem equations
            b = [
                -obj.UUmin + UU_k_1;
                obj.UUmax - UU_k_1;
                -obj.YYmin + YY_0;
                obj.YYmax - YY_0
            ];

            % Run quadprog function to calculate control change values
            Aeq = [];
            beq = [];
            x0 = [];
            dUU_k = quadprog(obj.H, f, obj.AMatrix, b, Aeq, beq,...
                obj.duuMin, obj.duuMax, x0, Constants.getQuadprogOptions());

            % New control value
            obj.UU(obj.k, :) = obj.UU_k + dUU_k(1:obj.nu, 1)';
            obj.UU_k = obj.UU(obj.k, :);

            obj.k = obj.k + 1;
        end
    end
end
