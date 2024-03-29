%% FastDMC
% Analytical DMC that only calculates one set of nu control values
% Also called fast DMC
classdef FastDMC < CoreDMC
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
            obj = ValidateDMC.validateDMCParams(obj, D, N, Nu, ny, nu,...
                stepResponses, varargin);
            obj = obj.initCoreDMC();
        end

        %% calculateControl
        % Calculates new, current object control values
        % Should be run in a loop
        % @param YY_k_1      horizontal vector of most recent output values
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

            dUU_k = obj.K(1:obj.nu, :) * (YYzad_k - YY_0);

            dU_k = obj.limitdU_k(dUU_k);
            % UU_k_1 = obj.UU_k
            UU_k = obj.limitU_k(obj.UU_k + dU_k');
            dU_k = UU_k - obj.UU_k;

            obj.dUUp_k = [dU_k'; obj.dUUp_k(1:(length(obj.dUUp_k)-obj.nu), 1)];

            obj.UU_k = UU_k;
        end
    end
end
