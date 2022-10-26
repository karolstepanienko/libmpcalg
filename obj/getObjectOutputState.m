function [X_k, Y_k] = getObjectOutputState(dA, dB, dC, dD, XX, xpp, nx, UU, upp, nu, ny, InputDelay, k)
    for cu=1:nu
        if k - InputDelay(cu) - 1 < 1
            U_k_1(cu) = upp;
        else
            U_k_1(cu) = UU(k - InputDelay(cu) - 1, cu);
        end
    end

    if k - 1 < 1
        X_k_1 = xpp * zeros(1, nx);
    else
        X_k_1 = XX(k - 1, :);
    end

    X_k = (dA * X_k_1' + dB * U_k_1')';
    Y_k = (dC * X_k_1' + dD * U_k_1')';
end
