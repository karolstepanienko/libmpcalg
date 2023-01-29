classdef (Abstract) CoreMPCS < MPC & handle
    properties
        % Required
        dA  % Discrete-time relation between internal process variables
        dB  % Discrete-time relation between internal process variables and inputs
        dC  % Discrete-time relation between outputs and internal process variables
        dD  % Discrete-time relation between outputs and inputs
        nx  % Number of state variables

        % Optional
        dAz  % Discrete-time relation between internal disturbance process
             % variables
        dBz  % Discrete-time relation between internal disturbance process
             % variables and inputs
        dCz  % Discrete-time relation between disturbance outputs and internal
             % disturbance process variables
        dDz  % Discrete-time relation between disturbance outputs
             % and disturbance inputs
        nxz  % Number of disturbance state variables
        X_k_1  % (1, nx) past state variable values
        X_k_2  % (1, nx) past state variable values
        XXz_k  % (1, nxz) past disturbance state variable values
        UUz_k_1  % (1, nz) past disturbance control values
        V_k_1  % (1, ny) past state value disturbance
        V_k_2  % (1, ny) past state value disturbance
        UU_k_1  % (1, nu) past disturbance control value
        UU_k_2  % (1, nu) past disturbance control value
    end

    properties (GetAccess = public, SetAccess = protected)
        AA  % (N*nx, nx)
        AAz  % (N*nxz, nxz)
        Mx  % (N*nx, Nu*nu)
        V  % (N*nx, nx)
        Vz  % (N*nxz, nxz)
        CC  % (N*ny, N*nx) dC matrix on diagonal
        CCz  % (N*ny, N*nxz) dCz matrix on diagonal
    end

    methods (Access = protected)
        function obj = initMPCS(obj)
            obj.c = Constants();
            obj.N1 = obj.c.defaultN1;
            obj.UU_k_1 = zeros(1, obj.nu);
            obj.UU_k_2 = zeros(1, obj.nu);
            obj.X_k_1 = zeros(1, obj.nx);
            obj.X_k_2 = zeros(1, obj.nx);
            obj.V_k_1 = zeros(1, obj.nx);
            obj.V_k_2 = zeros(1, obj.nx);
            obj.Xi = obj.getXi();
            obj.Lambda = obj.getLambda();
            obj.AA = obj.getAA(obj.nx, obj.dA);
            obj.Mx = obj.getMx();
            obj.V = obj.getV(obj.nx, obj.dA);
            if obj.nz > 0
                obj.XXz_k = zeros(1, obj.nxz);
                obj.UUz_k_1 = zeros(1, obj.nz);
                obj.Vz = obj.getV(obj.nxz, obj.dAz);
                obj.AAz = obj.getAA(obj.nxz, obj.dAz);
                obj.CCz = obj.getCC(obj.nxz, obj.dCz);
            end
            obj.CC = obj.getCC(obj.nx, obj.dC);
            obj.M = obj.CC*obj.Mx;
            obj.K = obj.getK(obj.M, obj.Xi, obj.Lambda);
        end
    end

    methods (Access = private)
        %% getAA
        % Creates AA matrix
        function AA = getAA(obj, nx, dA)
            AA = zeros(obj.N*nx, nx);
            for i=1:obj.N
                AA((i - 1)*nx + 1:i*nx, 1:nx) = dA^i;
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
        function V = getV(obj, nx, dA)
            V = zeros(obj.N*nx, nx);
            for i=1:obj.N
                V((i-1)*nx+1:i*nx, :) = obj.getPowerSum(dA, i-1);
            end
        end

        %% getCC
        function CC = getCC(obj, nx, dC)
            CC = zeros(obj.N*obj.ny, obj.N*nx);
            for i=1:obj.N
                CC((i-1)*obj.ny+1:i*obj.ny, (i-1)*nx+1:i*nx) = dC;
            end
        end
    end
end
