classdef (Abstract) MPC
    properties
        N  % Prediction horizon
        Nu  % Moving horizon
        ny  % Number of outputs
        nu  % Number of inputs

        % Optional
        mi  % Output importance
        lambda  % Control weight
        uMin  % Minimal control value
        uMax  % Maximal control value
        duMin  % Minimal control change value
        duMax  % Maximal control change value
    end

    properties (GetAccess = public, SetAccess = protected)
        c  % Constants object
        Sp  % Sp cell of step response matrices in p moment
        M   % M (ny*N, ny*Nu) dynamic matrix
        Xi  % Xi (ny*N, ny*N) output importance matrix
        Lambda  % Lambda (nu*Nu, nu*Nu) input importance matrix
        K  % K (nu*Nu, ny*N) feedback coefficients matrix
        UU_k  % (1, nu) Current control value
    end

    methods
        %% getControl
        % Returns horizontal vector of new control values
        function UU_k = getControl(obj)
            UU_k = obj.UU_k;
        end
    end

    methods (Access = protected)
        %% getSp
        % Creates Sp matrix from step response data in cell format
        function Sp = getSp(obj, stepResponses, D)
            % Variable initialisation
            Sp = cell(D, 1);
            sp = zeros(obj.ny, obj.nu); % Step response matrix in moment p

            for p=1:D % Step response moment
                for i=1:obj.nu
                    for j=1:obj.ny
                        if p <= size(stepResponses{i}(:, j), 1)
                            sp(j,i) = stepResponses{i}(p,j);
                        else
                            % Stretch the step response assuming that elements
                            % after D are equal to last known step response
                            % value
                            sp(j,i) = stepResponses{i}(end,j);
                        end
                    end
                end
                Sp{p, 1} = sp;
            end
        end

        %% getM
        % Creates M matrix used by DMC and GPC algorithm
        function M = getM(obj)
            % Variable initialisation
            M = zeros(obj.ny*obj.N, obj.nu*obj.Nu);
            for j=1:obj.Nu
                for i=j:obj.N
                    M((i - 1)*obj.ny + 1:i*obj.ny,...
                        (j - 1)*obj.nu + 1:j*obj.nu) = obj.Sp{i-j+1, 1};
                end
            end
        end

        %% getKMatrix
        % Creates full K matrix used by DMC algorithm
        function K = getK(obj, M, Xi, Lambda)
            K = (M' * Xi * M + Lambda) \ (M' * Xi);
        end

        %% getXi
        % Creates Xi matrix used by DMC algorithm
        function Xi = getXi(obj)
            Xi = zeros(obj.ny*obj.N);
            for i=1:obj.N
                Xi((i - 1)*obj.ny + 1:i*obj.ny,...
                    (i - 1)*obj.ny + 1:i*obj.ny) = ...
                    diag(obj.mi); % square ny x ny matrix
            end
        end

        %% getLambdaMatrix
        % Creates Lambda matrix used by DMC algorithm
        function Lambda = getLambda(obj)
            Lambda = zeros(obj.nu*obj.Nu);
            for i=1:obj.Nu
                Lambda((i - 1)*obj.nu + 1:i*obj.nu,...
                    (i - 1)*obj.nu + 1:i*obj.nu) = ...
                    diag(obj.lambda); % square nu x nu matrix
            end
        end

        %% limitU_k
        function U_k = limitU_k(obj, U_k)
            for i=1:obj.nu
                if U_k(i) < obj.uMin
                    U_k(i) = obj.uMin;
                elseif U_k(i) > obj.uMax
                    U_k(i) = obj.uMax;
                end
            end
        end

        %% limitdU_k
        function dU_k = limitdU_k(obj, dU_k)
            for i=1:obj.nu
                if dU_k(i) < obj.duMin
                    dU_k(i) = obj.duMin;
                elseif dU_k(i) > obj.duMax
                    dU_k(i) = obj.duMax;
                end
            end
        end

        %% stackVectorNTimes
        % Tries to stack given vector N time vertically
        % @throws MalformedVector error if stacking is not possible.
        function YY = stackVectorNTimes(obj, Y)
            if size(Y, 1) == obj.ny && size(Y, 2) == 1  % Vertical vector
                YY = Utilities.stackVector(Y, obj.N);
            elseif size(Y, 1) == 1 && size(Y, 2) == obj.ny  % Horizontal vector
                YY = Utilities.stackVector(Y', obj.N);
            else
                error("Malformed vector. Cannot be stacked.");
            end
        end
    end
end
