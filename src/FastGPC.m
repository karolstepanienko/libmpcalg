%% FastGPC
% Analytical GPC that only calculates one set of nu control values
% Also called fast GPC
classdef FastGPC < CoreGPC & ValidateGPC
    methods
        %% FastGPC
        % Creates FastGPC regulator object
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
        function obj = FastGPC(N, Nu, ny, nu, A, B, varargin)
            obj = obj.validateGPCParams(N, Nu, ny, nu, A, B, varargin);
            obj = obj.initCoreGPC();
        end

        function obj = calculateControl(obj, YY_k_1, YYzad_k)
            obj.YY(obj.k - 1, :) = YY_k_1;
            YYzad_k = obj.stackVectorNTimes(YYzad_k);

            % Get YY_0
            YY_0 = obj.getYY_0();

            % Get new control change value
            dUU_k = obj.K(1:obj.nu, :) * (YYzad_k - YY_0);

            % Limit control change values
            dU_k = obj.limitdU_k(dUU_k);
            % Limit control values
            obj.UU(obj.k, :) = obj.limitU_k(obj.UU_k' + dU_k);
            obj.UU_k = obj.UU(obj.k, :);

            obj.k = obj.k + 1;
        end
    end
end
