%% FastDMC
% Analytical DMC that only calculates one set of nu control values
% Also called fast DMC
classdef FastDMC < CoreDMC & ValidateDMC
    methods
        %% FastDMC
        % Creates FastDMC regulator object
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
        function obj = FastDMC(D, N, Nu, ny, nu, stepResponses, varargin)
            obj = obj.validateDMCParams(D, N, Nu, ny, nu, stepResponses,...
                varargin);
            obj = obj.initCoreDMC();
        end

        %% calculateControl
        % Calculates new, current object control values
        % Should be run in a loop
        % @param YY_k_1        horizontal vector of most recent output values
        % @param Yzad_k     horizontal vector of target trajectory values
        function obj = calculateControl(obj, YY_k_1, Yzad_k)
            YY_k_1 = obj.stackVectorNTimes(YY_k_1);
            YYzad_k = obj.stackVectorNTimes(Yzad_k);

            YY_0 = YY_k_1 + obj.Mp * obj.dUUp_k;

            obj.dUU_k = obj.K(1:obj.nu, :) * (YYzad_k - YY_0);

            dU_k = obj.limitdU_k(obj.dUU_k);
            % UU_k_1 = obj.UU_k
            UU_k = obj.limitU_k(obj.UU_k + dU_k');
            dU_k = UU_k - obj.UU_k;

            obj.dUUp_k = [dU_k'; obj.dUUp_k(1:(length(obj.dUUp_k)-obj.nu), 1)];

            obj.UU_k = UU_k;
        end
    end
end
