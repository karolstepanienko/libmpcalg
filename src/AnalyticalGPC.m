%% AnalyticalGPC
% Analytical GPC also called classicGPC
classdef AnalyticalGPC < CoreGPC & ValidateGPC
    methods
        %% AnalyticalGPC
        % Creates AnalyticalGPC regulator object
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
        function obj = AnalyticalGPC(N, Nu, ny, nu, A, B, varargin)
            obj = obj.validateGPCParams(N, Nu, ny, nu, A, B, varargin);
            obj = obj.initCoreGPC();
        end

        %% calculateControl
        % Calculates new, current object control values
        % Should be run in a loop
        % @param YY_k_1     horizontal vector of most recent output values
        % @param Yzad_k     horizontal vector of target trajectory values
        function obj = calculateControl(obj, YY_k_1, YYzad_k)
            obj.YY(obj.k - 1, :) = YY_k_1;
            YYzad_k = obj.stackVectorNTimes(YYzad_k);

            YY_0 = obj.getYY_0();

            dUU_k = obj.K * (YYzad_k - YY_0);

            dU_k = obj.limitdU_k(dUU_k(1:obj.nu));
            % UU_k_1 = obj.UU_k
            obj.UU(obj.k, :) = obj.limitU_k(obj.UU_k' + dU_k);
            obj.UU_k = obj.UU(obj.k, :);

            obj.k = obj.k + 1;
        end
    end
end
