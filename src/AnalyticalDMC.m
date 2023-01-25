%% AnalyticalDMC
% Analytical DMC also called classicDMC
classdef AnalyticalDMC < CoreDMC
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
            obj = ValidateDMC.validateDMCParams(obj, D, N, Nu, ny, nu,...
                stepResponses, varargin);
            obj = obj.initCoreDMC();
        end

        %% calculateControl
        % Calculates new, current object control values
        % Should be run in a loop
        % @param YY_k_1     horizontal vector of most recent output values
        % @param YYzad_k    horizontal vector of target trajectory values
        function UU_k = calculateControl(obj, YY_k_1, YYzad_k)
            YY_k_1 = obj.stackVectorNN1Times(YY_k_1);
            YYzad_k = obj.stackYzadVector(YYzad_k);

            YY_k = obj.Mp * obj.dUUp_k;
            YY_0 = YY_k_1 + YY_k(obj.ny*obj.ny + 1:end);

            dUU_k = obj.K * (YYzad_k - YY_0);

            dU_k = obj.limitdU_k(dUU_k(1:obj.nu));
            % UU_k_1 = obj.UU_k
            UU_k = obj.limitU_k(obj.UU_k + dU_k');
            dU_k = UU_k - obj.UU_k;

            obj.dUUp_k = [dU_k'; obj.dUUp_k(1:(length(obj.dUUp_k)-obj.nu), 1)];

            obj.UU_k = UU_k;
        end
    end
end
