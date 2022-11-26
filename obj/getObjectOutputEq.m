function Y_k = getObjectOutputEq(A, B, YY, ypp, UU, upp, ny, nu, InputDelay, k)
    Y_k = zeros(1, ny);
    na = size(A{1, 1}(2:end), 2);  % First element is always one, so discard it
    nb = size(B{1, 1}, 2) - 1;  % vector in B matrix has nb + 1 elements
    for cy=1:ny
        a = A{cy, cy}(2:end);
        % Output - A matrix part
        if k - na < 1
            % In a loop
            for i=1:na
                if k - i >= 1
                    Y_k(1, cy) = Y_k(1, cy) - a(i) * YY(k - i, cy);
                else
                    Y_k(1, cy) = Y_k(1, cy) - a(i) * ypp;
                end
            end

        else
            % Using vectors
            Y_k(1, cy) = Y_k(1, cy) - a * flip(YY(k-na:k-1, cy));
        end

        % Input - B matrix part
        for cu=1:nu
            b = B{cy, cu};
            if k - nb - InputDelay(cu) < 1

                % In a loop
                for i=0:nb
                    if k - i - InputDelay(cu) >= 1
                        Y_k(1, cy) = Y_k(1, cy) + b(i + 1)...
                            * UU(k - i + 1 - InputDelay(cu), cu);
                    else
                        Y_k(1, cy) = Y_k(1, cy) + b(i + 1) * upp;
                    end
                end

            else
                % Using vectors
                Y_k(1, cy) = Y_k(1, cy) + b...
                    * flip(UU(k - nb - InputDelay(cu):k - InputDelay(cu), cu));
            end
        end
    end
end
