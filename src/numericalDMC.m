%% NumericalDMC
% DMC algorithm that uses quadproc - a auqdratic equations solver to calculate
% control value changes
classdef NumericalDMC < MPC & coreDMC
    properties
        yMin  % Minimal output value
        yMax  % Maximal output value 
    end

    properties (Access = private)
        H  % Matrix used by quadprog function
        f  % Vector used by quadprog function
        J  % Matrix used to impose control value limits
        UUmin  % (nu * Nu, 1) vector of uMin values
        UUmax  % (nu * Nu, 1) vector of uMax values
        YYmin  % (ny * N, 1) vector of yMin values
        YYmax  % (ny * N, 1) vector of yMax values
        duuMin  % (nu * Nu, 1) vector of duMin values
        duuMax  % (nu * Nu, 1) vector of duMax values
    end

    methods
        %% NumericalDMC
        % Creates NumericalDMC regulator object
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
        % TODO
        % @param yMin Minimal output value
        % @param yMax Maximal output value
        function obj = NumericalDMC(D, N, Nu, ny, nu, stepResponses, varargin)
            obj = obj.validateNumericalDMCParams(D, N, Nu, ny, nu,...
                stepResponses, varargin);
            obj = obj.initMPC();
            obj = obj.initNumericalDMC();
        end

        function obj = initNumericalDMC(obj)
            obj.H = obj.getH();
            obj.J = obj.getJ();
            obj.UUmin = ones(obj.nu * obj.Nu, 1) * obj.uMin;
            obj.UUmax = ones(obj.nu * obj.Nu, 1) * obj.uMax;
            obj.YYmin = ones(obj.ny * obj.N, 1) * obj.yMin;
            obj.YYmax = ones(obj.ny * obj.N, 1) * obj.yMax;
            obj.duuMin = ones(obj.nu * obj.Nu, 1) * obj.duMin;
            obj.duuMax = ones(obj.nu * obj.Nu, 1) * obj.duMax;
        end

        %% calculateControl
        % Calculates new, current object control values
        % Should be run in a loop
        % @param Y_k        horizontal vector of current output values
        % @param Yzad_k     horizontal vector of target trajectory values
        function obj = calculateControl(obj, Y_k, Yzad_k)
            YY_k = obj.getYYFromY(Y_k);
            YYzad_k = obj.getYYFromY(Yzad_k);
            
            % Get YY_0
            YY_0 = YY_k + obj.Mp * obj.dUUp_k;

            % f vector used by quadproc
            f = -2 * obj.M' * obj.Xi * (YYzad_k - YY_k - obj.Mp * obj.dUUp_k);

            % Most recent control values
            UU_k_1 = Utilities.stackVector(obj.U_k, obj.Nu);

            % Quadproc optimalisation problem equations
            A = [-obj.J; obj.J; -obj.M; obj.M];
            b = [
                -obj.UUmin + UU_k_1;
                obj.UUmax - UU_k_1;
                -obj.YYmin + YY_0;
                obj.YYmax - YY_0
            ];

            % Run quadproc function to calculate control change values
            Aeq = [];
            beq = [];
            x0 = [];
            obj.dUU_k = quadprog(obj.H, f, A, b, Aeq, beq, obj.duuMin,...
                obj.duuMax, x0);

            % New control change value
            dU_k = obj.dUU_k(1:obj.nu);

            % Shift dUUp values
            obj.dUUp_k = [dU_k; obj.dUUp_k(1:(length(obj.dUUp_k)-obj.nu), 1)];

            % New control value
            obj.U_k = obj.U_k + obj.dUU_k(1:obj.nu, 1);
        end

        %% getH
        % Creates H matrix used to describe optimalisation problem to quadproc
        % return H (nu x Nu, nu x Nu)
        function H = getH(obj)
            H = 2 * (obj.M' * obj.Xi * obj.M + obj.Lambda);
            % Making sure, that despite to numeric errors,
            % H is still symetrical
            H = (H+H')/2;
        end

        %% getJ
        % Creates J matrix used to limit control values with quadproc function
        % @return J (nu x Nu, nu x Nu)
        function J = getJ(obj)
            I = eye(obj.nu);
            J = zeros(obj.nu * obj.Nu);
            % Iterating vertically
            for i = 1:obj.Nu
                % Iterating horizontally
                col_number = 1;
                for j = 1:col_number
                    J((i-1) * obj.nu + 1:i*obj.nu, ...
                        (j-1) *obj.nu + 1:j*obj.nu) = I;
                    col_number = col_number + 1;
                end
            end
        end
    end
end
