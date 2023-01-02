classdef (Abstract) CoreMPCS < MPC
    properties (Access = public)
        % Required
        D  % Dynamic horizon
        N  % Prediction horizon
        Nu  % Moving horizon
        dA % Discrete-time relation between internal process variables
        dB % Discrete-time relation between internal process variables and inputs
        dC % Discrete-time relation between outputs and internal process variables
        dD % Discrete-time relation between outputs and inputs
        ny  % Number of outputs
        nu  % Number of inputs
        nx  % Number of state variables

        % Optional
        mi  % Output importance
        lambda  % Control weight
        uMin  % Minimal control value
        uMax  % Maximal control value
        duMin  % Minimal control change value
        duMax  % Maximal control change value
    end

    properties (GetAccess = public, SetAccess = protected)
        U_k  % (nu, 1) current control value
        X_k_1  % (nx, 1) past state variable values
        Xi  % (N*ny, N*ny)
        Lambda  % (Nu*nu, Nu*nu)
        M  % (N, Nu)
        K  % (Nu*nu, N*ny)
        AA  % (N*nx, nx)
        Mx  % (N*nx, Nu*nu)
        V  % (N*nx, nx)
        CC  % (N*ny, N*nx) dC matrix on diagonal
        % Debugging
        YY_0  % (N*ny, 1) Object trajectory without further control changes
    end

    methods
        %% getControl
        % Returns horizontal vector of new control values
        function U_k = getControl(obj)
            U_k = obj.U_k';
        end
    end

    methods (Access = protected)
        function obj = initMPCS(obj)
            obj.U_k = zeros(obj.nu, 1);
            obj.X_k_1 = zeros(1, obj.nx);
            obj.Xi = obj.getXi();
            obj.Lambda = obj.getLambda();
            obj.AA = obj.getAA();
            obj.Mx = obj.getMx();
            obj.V = obj.getV();
            obj.CC = obj.getCC();
            obj.M = obj.CC*obj.Mx;
            obj.K = obj.getK(obj.M, obj.Xi, obj.Lambda);
            obj.YY_0 = zeros(obj.N*obj.ny, 1);
        end
    end

    methods (Access = private)
        %% getAA
        % Creates AA matrix
        function AA = getAA(obj)
            AA = zeros(obj.N*obj.nx, obj.nx);
            for i=1:obj.N
                AA((i - 1)*obj.nx + 1:i*obj.nx, 1:obj.nx) = obj.dA^i;
            end
        end

        %% getMx
        % Creates Mx matrix
        function Mx = getMx(obj)
            Mx = zeros(obj.N*obj.nx, obj.Nu*obj.nu);
            % Get first column
            firstColumn = zeros(obj.nx*obj.N, obj.nu);
            for i=1:obj.N
                firstColumn((i-1)*obj.nx+1:i*obj.nx,:) =...
                    obj.getPowerSum(obj.dA, i-1)*obj.dB;
            end
            % Delete bottom (nx, nx) matrix, shift down and fill with zeros on
            % top
            for i=1:obj.Nu
                Mx(:, (i-1)*obj.nu+1:i*obj.nu) =...
                    [zeros((i-1)*obj.nx, obj.nu);...
                    firstColumn(1:(obj.N-(i - 1))*obj.nx,:)];
            end
        end

        %% getPowerSum
        % Returns matrix that is a sum of n matrices raised to the consecutive
        % power: m^n + m(n-1) + ... + m^(1) + I
        function r = getPowerSum(obj, m, n)
            r = eye(size(m, 1));
            for i=1:n
                r = r + m^i;
            end
        end

        %% getV
        function V = getV(obj)
            V = zeros(obj.N*obj.nx, obj.nx);
            for i=1:obj.N
                V((i-1)*obj.nx+1:i*obj.nx,:) = obj.getPowerSum(obj.dA, i-1);
            end
        end

        %% getCC
        function CC = getCC(obj)
            CC = zeros(obj.N*obj.ny, obj.N*obj.nx);
            for i=1:obj.N
                CC((i-1)*obj.ny+1:i*obj.ny, (i-1)*obj.nx+1:i*obj.nx) = obj.dC;
            end
        end
    end
end
