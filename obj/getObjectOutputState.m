function [X_kp1, Y_k] = getObjectOutputState(dA, dB, dC, dD, XX, xpp, nx,...
    UU, upp, nu, ny, InputDelay, k)
    for cu=1:nu
        if k - InputDelay(cu) < 1
            U_k(cu) = upp;
        else
            U_k(cu) = UU(k - InputDelay(cu), cu);
        end
    end

    X_kp1 = (dA * XX(k, :)' + dB * U_k')';
    Y_k = (dC * XX(k, :)' + dD * U_k')';
end
