%% NumericalMPCS
% MPCS algorithm that uses quadprog - a quadratic equations solver to calculate
% control value changes
classdef NumericalMPCS < CoreMPCS & NumericalUtilities
    methods
        %% NumericalMPCS
        % Creates NumericalMPCS regulator object
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
        % @param yMin Minimal output value
        % @param yMax Maximal output value
        function obj = NumericalMPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
            varargin)
            obj = ValidateMPCS.validateNumericalMPCSParams(obj, N, Nu,...
                ny, nu, nx, dA, dB, dC, dD, varargin);
            obj = obj.initMPCS();
            obj = obj.initNumerical(obj.M, obj.Xi, obj.Lambda);
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

                YY_0 = obj.CC * obj.AA * XX_k' + obj.CC * obj.V...
                    * (obj.dB * obj.UU_k_1' + V_k')...
                    + ones(obj.ny * (obj.N - obj.N1 + 1), obj.ny) * d_k_1';
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

            f = -2 * obj.M' * obj.Xi * (YYzad_k - YY_0);

            % UU_k_1 = obj.UU_k
            UU_k_1 = Utilities.stackVector(obj.UU_k_1', obj.Nu);

            % Quadprog optimisation problem equations
            Aeq = [];
            beq = [];
            x0 = obj.dUU_k;  % Hot start
            exitFlag = -1; i = 0;
            while exitFlag < 0
                switch i
                    case 1
                        obj.removeYLimits(); Warnings.removedYConstraints();
                    case 2
                        obj.removeDULimits(); Warnings.removedDUConstraints();
                    case 3
                        obj.removeULimits(); Warnings.removedUConstraints();
                    case 4
                        Exceptions.throwOptimisationCouldNotContinue();
                end
                b = obj.getBMatrix(UU_k_1, YY_0);
                [obj.dUU_k, ~, exitFlag] = quadprog(obj.H, f, obj.AMatrix, b,...
                    Aeq, beq, obj.duuMin, obj.duuMax, x0,...
                    obj.c.quadprogOptions);
                i = i + 1;
            end

            UU_k = obj.UU_k_1 + obj.dUU_k(1:obj.nu, 1)';
            obj.UU_k_2 = obj.UU_k_1;
            obj.UU_k_1 = UU_k;

            obj.X_k_2 = obj.X_k_1;
            obj.X_k_1 = XX_k;
            obj.V_k_2 = obj.V_k_1;
            obj.V_k_1 = V_k;
        end
    end
end
