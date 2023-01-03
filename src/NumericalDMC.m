%% NumericalDMC
% DMC algorithm that uses quadprog - a quadratic equations solver to calculate
% control value changes
classdef NumericalDMC < CoreDMC & NumericalUtilities & ValidateDMC
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
            obj = obj.validateNumericalDMCParams(D, N, Nu, ny, nu,...
                stepResponses, varargin);
            obj = obj.initCoreDMC();
            obj = obj.initNumerical(obj.M, obj.Xi, obj.Lambda);
        end

        %% calculateControl
        % Calculates new, current object control values
        % Should be run in a loop
        % @param Y_k        horizontal vector of current output values
        % @param Yzad_k     horizontal vector of target trajectory values
        function obj = calculateControl(obj, Y_k, Yzad_k)
            YY_k = obj.stackVectorNTimes(Y_k);
            YYzad_k = obj.stackVectorNTimes(Yzad_k);

            % Get YY_0
            YY_0 = YY_k + obj.Mp * obj.dUUp_k;

            % f vector used by quadprog
            f = -2 * obj.M' * obj.Xi * (YYzad_k - YY_0);

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
            obj.dUU_k = quadprog(obj.H, f, obj.AMatrix, b, Aeq, beq, obj.duuMin,...
                obj.duuMax, x0, Constants.getQuadprogOptions());

            % New control change value
            dU_k = obj.dUU_k(1:obj.nu);

            % Shift dUUp values
            obj.dUUp_k = [dU_k; obj.dUUp_k(1:(length(obj.dUUp_k)-obj.nu), 1)];

            % New control value
            obj.UU_k = obj.UU_k + dU_k';
        end
    end
end
