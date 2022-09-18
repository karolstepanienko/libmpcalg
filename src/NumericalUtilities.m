classdef (Abstract) NumericalUtilities
    properties
        yMin  % Minimal output value
        yMax  % Maximal output value
    end

    properties (Access = protected)
        H  % Matrix used by quadprog function
        J  % Matrix used to impose control value limits
        A  % Matrix describing linear inequality constraints
        UUmin  % (nu * Nu, 1) vector of uMin values
        UUmax  % (nu * Nu, 1) vector of uMax values
        YYmin  % (ny * N, 1) vector of yMin values
        YYmax  % (ny * N, 1) vector of yMax values
        duuMin  % (nu * Nu, 1) vector of duMin values
        duuMax  % (nu * Nu, 1) vector of duMax values
    end

    methods (Access = protected)
        function obj = initNumerical(obj, M, Xi, Lambda)
            obj.H = obj.getH(M, Xi, Lambda);
            obj.J = obj.getJ();
            obj.A = obj.getA(M);
            obj.UUmin = ones(obj.nu * obj.Nu, 1) * obj.uMin;
            obj.UUmax = ones(obj.nu * obj.Nu, 1) * obj.uMax;
            obj.YYmin = ones(obj.ny * obj.N, 1) * obj.yMin;
            obj.YYmax = ones(obj.ny * obj.N, 1) * obj.yMax;
            obj.duuMin = ones(obj.nu * obj.Nu, 1) * obj.duMin;
            obj.duuMax = ones(obj.nu * obj.Nu, 1) * obj.duMax;
        end

        %% getH
        % Creates H matrix used to describe optimisation problem to quadprog
        % return H (nu x Nu, nu x Nu)
        function H = getH(obj, M, Xi, Lambda)
            H = 2 * (M' * Xi * M + Lambda);
            % Making sure, that despite to numeric errors,
            % H is still symetrical
            H = (H+H')/2;
        end

        %% getJ
        % Creates J matrix used to limit control values with quadprog function
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

        %% getA
        % Creates static A matrix describing linear inequality constraints
        function A = getA(obj, M)
            A = [-obj.J; obj.J; -M; M];
        end
    end
end
