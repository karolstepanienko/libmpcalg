%% NumericalMPCS
% MPCS algorithm that uses quadprog - a quadratic equations solver to calculate
% control value changes
classdef NumericalMPCS < CoreMPCS & NumericalUtilities & ValidateMPCS
    methods
        %% NumericalMPCS
        % Creates NumericalMPCS regulator object
        % @param N Prediction horizon
        % @param Nu Moving horizon
        % @param ny Number of outputs
        % @param nu Number of inputs
        % @param nx Number of state variables
        % @param dA Discrete-time relation between internal process variables
        % @param dB Discrete-time relation between internal process variables and inputs
        % @param dC Discrete-time relation between outputs and internal process variables
        % @param dD Discrete-time relation between outputs and inputs
        % @param mi Output importance
        % @param lambda Control weight
        % @param uMin Minimal control value
        % @param uMax Maximal control value
        % @param duMin Minimal control change value
        % @param duMax Maximal control change value
        % @param yMin Minimal output value
        % @param yMax Maximal output value
        function obj = NumericalMPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
            varargin)
            obj = obj.validateNumericalMPCSParams(N, Nu, ny, nu, nx, dA, dB,...
                dC, dD, varargin);
            obj = obj.initMPCS();
            obj = obj.initNumerical(obj.M, obj.Xi, obj.Lambda);
        end

        %% calculateControl
        % Calculates new, current object control values
        % Should be run in a loop
        % @param X_k        horizontal vector of current state values
        % @param Yzad_k     horizontal vector of target trajectory values
        function obj = calculateControl(obj, X_k, Yzad_k)
            YYzad_k = obj.stackVectorNTimes(Yzad_k);

            % Get YY_0
            YY_0 = obj.CC * obj.AA * X_k' + obj.CC * obj.V * (obj.dB * obj.U_k);

            % f vector used by quadprog
            f = -2 * obj.M' * obj.Xi * (YYzad_k - YY_0);

            % Most recent control values
            UU_k_1 = Utilities.stackVector(obj.U_k, obj.Nu);

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
            dUU_k = quadprog(obj.H, f, obj.A, b, Aeq, beq, obj.duuMin,...
                obj.duuMax, x0, Constants.getOptimOptions());

            % New control change value
            dU_k = dUU_k(1:obj.nu);

            % New control value
            obj.U_k = obj.U_k + dUU_k(1:obj.nu, 1);
        end
    end
end
