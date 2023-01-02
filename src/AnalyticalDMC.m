%% AnalyticalDMC
% Analytical DMC also called classicDMC
classdef AnalyticalDMC < CoreDMC & ValidateDMC
    methods
        %% AnalyticalDMC
        % Creates DMC regulator object
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
        function obj = AnalyticalDMC(D, N, Nu, ny, nu, stepResponses, varargin)
            obj = obj.validateDMCParams(D, N, Nu, ny, nu, stepResponses,...
                varargin);
            obj = obj.initCoreDMC();
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
            obj.YY_0 = YY_k + obj.Mp * obj.dUUp_k;

            % Get new control change value
            obj.dUU_k = obj.K * (YYzad_k - obj.YY_0);

            % Limit control change values
            dU_k = obj.limitdU_k(obj.dUU_k(1:obj.nu));
            % Limit control values, U_k_1 = obj.U_k
            U_k = obj.limitU_k(obj.U_k + dU_k);
            % Limit control change value after limiting control value
            dU_k = U_k - obj.U_k;

            % Shift dUUp values
            obj.dUUp_k = [dU_k; obj.dUUp_k(1:(length(obj.dUUp_k)-obj.nu), 1)];

            % Get new control value
            obj.U_k = U_k;
        end
    end
end
