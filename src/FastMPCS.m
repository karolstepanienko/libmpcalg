%% FastMPCS
% Analytical MPCS that only calculates one set of nu control values
% Also called fast MPCS
classdef FastMPCS < CoreMPCS
    methods
        %% FastMPCS
        % Creates FastMPCS regulator object
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
        function obj = FastMPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD, varargin)
            obj = ValidateMPCS.validateMPCSParams(obj, N, Nu, ny, nu, nx,...
                dA, dB, dC, dD, varargin);
            obj = obj.initMPCS();
        end

        %% calculateControl
        % Calculates new, current object control values
        % Should be run in a loop
        % @param XX_k        horizontal vector of current state values
        % @param YYzad_k     horizontal vector of target trajectory values
        function UU_k = calculateControl(obj, XX_k, YYzad_k)
            YYzad_k = obj.stackVectorNTimes(YYzad_k);

            YY_0 = obj.CC * obj.AA * XX_k' + obj.CC * obj.V *...
                (obj.dB * obj.UU_k');

            dU_k = obj.K(1:obj.nu, :) * (YYzad_k - YY_0);

            dU_k = obj.limitdU_k(dU_k(1:obj.nu));
            % UU_k_1 = obj.UU_k
            UU_k = obj.limitU_k(obj.UU_k + dU_k');
            obj.UU_k = UU_k;
        end
    end
end
