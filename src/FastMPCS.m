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
        function UU_k = calculateControl(obj, XX_k, YY_k_1, YYzad_k, varargin)
            YYzad_k = obj.stackYzadVector(YYzad_k);
            V_k = XX_k - (obj.dA * obj.X_k_1' + obj.dB * obj.UU_k_1')';

            if obj.nz < 0
                d_k_1 = YY_k_1 - (obj.dC * (obj.dA * obj.X_k_2'...
                    + obj.dB * obj.UU_k_2' + obj.V_k_2'))';
                dd_k_1 = zeros((obj.N - obj.N1 + 1) * obj.ny, 1);
                for i=1:obj.N - obj.N1 + 1
                    dd_k_1((i - 1) * obj.ny + 1:i*obj.ny, 1) = d_k_1';
                end
                YY_0 = obj.CC * obj.AA * XX_k' + obj.CC * obj.V...
                    * (obj.dB * obj.UU_k_1' + V_k') + dd_k_1;
            else
                YY_0 = obj.CC * obj.AA * XX_k' + obj.CC * obj.V...
                    * (obj.dB * obj.UU_k_1' + V_k');

                XXz_kp1 = varargin{1}; UUz_k = varargin{2};
                Vz_k = XXz_kp1 - (obj.dAz * obj.XXz_k'...
                    + obj.dBz * obj.UUz_k_1')';

                YYz_0 = obj.CCz * obj.AAz * XXz_kp1' + obj.CCz * obj.Vz...
                    * (obj.dBz * UUz_k' + Vz_k');

                YY_0 = YY_0 + YYz_0;
                obj.XXz_k = XXz_kp1;
                obj.UUz_k_1 = UUz_k;
            end

            dU_k = obj.K(1:obj.nu, :) * (YYzad_k - YY_0);
            dU_k = obj.limitdU_k(dU_k(1:obj.nu));
            UU_k = obj.limitU_k(obj.UU_k_1 + dU_k');

            obj.UU_k_2 = obj.UU_k_1;
            obj.UU_k_1 = UU_k;

            obj.X_k_2 = obj.X_k_1;
            obj.X_k_1 = XX_k;
            obj.V_k_2 = obj.V_k_1;
            obj.V_k_1 = V_k;
        end
    end
end
