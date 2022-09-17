function [X_k, Y_k] = getObjectOutputState(dA, dB, dC, dD, XX, xpp, nx, UU, upp, nu, ny, k)
    if k == 1
        X_k_1 = xpp * zeros(1, nx);
        U_k_1 = upp * zeros(1, nu);
    else
        X_k_1 = XX(k - 1, :);
        U_k_1 = UU(k - 1, :);
    end
    X_k = (dA * X_k_1' + dB * U_k_1')';
    Y_k = (dC * X_k_1' + dD * U_k_1')';
end