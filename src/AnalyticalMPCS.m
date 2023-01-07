%% AnalyticalMPCS
% Analytical MPCS also called classicMPCS
classdef AnalyticalMPCS < CoreMPCS
    methods
        %% AnalyticalMPCS
        % Creates MPCS regulator object
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
        function obj = AnalyticalMPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
            varargin)
            obj = ValidateMPCS.validateMPCSParams(obj, N, Nu, ny, nu, nx,...
                dA, dB, dC, dD, varargin);
            obj = obj.initMPCS();
        end

        %% calculateControl
        % Calculates new, current object control values
        % Should be run in a loop
        % @param X_k        horizontal vector of current state values
        % @param YYzad_k    horizontal vector of target trajectory values
        function obj = calculateControl(obj, X_k, YYzad_k)
            YYzad_k = obj.stackVectorNTimes(YYzad_k);
            V_k = X_k - (obj.dA * obj.X_k_1' + obj.dB * obj.UU_k')';

            YY_0 = obj.CC * obj.AA * X_k' + obj.CC * obj.V...
                * (obj.dB * obj.UU_k' + V_k');

            dUU_k = obj.K * (YYzad_k - YY_0);

            dU_k = obj.limitdU_k(dUU_k(1:obj.nu));

            % UU_k_1 = obj.UU_k
            obj.UU_k = obj.limitU_k(obj.UU_k + dU_k');

            obj.X_k_1 = X_k;
        end
    end
end
