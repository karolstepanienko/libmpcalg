classdef (Abstract) MPCUtilities
    methods (Access = protected)
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
                if U_k(i, 1) < obj.uMin
                    U_k(i, 1) = obj.uMin;
                elseif U_k(i, 1) > obj.uMax
                    U_k(i, 1) = obj.uMax;
                end
            end
        end

        %% limitdU_k
        function dU_k = limitdU_k(obj, dU_k)
            for i=1:obj.nu
                if dU_k(i, 1) < obj.duMin
                    dU_k(i, 1) = obj.duMin;
                elseif dU_k(i, 1) > obj.duMax
                    dU_k(i, 1) = obj.duMax;
                end
            end
        end

        %% stackVectorVertically
        % Tries to stack given vector N time vertically
        % @throws MalformedVector error if stacking is not possible.
        function YY = stackVectorVertically(obj, Y)
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
