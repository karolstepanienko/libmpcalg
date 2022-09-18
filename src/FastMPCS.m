%% FastMPCS
% Analytical MPCS that only calculates one set of nu control values
% Also called fast MPCS
classdef FastMPCS < CoreMPCS & ValidateMPCS
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
            obj = obj.validateMPCSParams(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
                varargin);
            obj = obj.initMPCS();
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

            % Get new control change value
            dU_k = obj.K(1:obj.nu, :) * (YYzad_k - YY_0);

            % Limit control change values
            dU_k = obj.limitdU_k(dU_k(1:obj.nu));

            % Get new control value
            obj.U_k = obj.limitU_k(obj.U_k + dU_k(1:obj.nu, 1));
        end
    end
end