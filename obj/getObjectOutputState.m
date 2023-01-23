function [X_kp1, Y_k] = getObjectOutputState(dA, dB, dC, dD, XX, xpp, nx,...
    UU, upp, nu, ny, InputDelay, OutputDelay, k)

    for cu=1:nu
        if k - InputDelay(cu) < 1
            U_k(cu) = upp;
        else
            U_k(cu) = UU(k - InputDelay(cu), cu);
        end
    end

    X_kp1 = (dA * XX(k, :)' + dB * U_k')';

    OutputDelayVec = zeros(nx, 1);
    if nx/ny > 1
        for i=0:nx/ny-1
            OutputDelayVec(ny*i+1:ny*(i+1)) = OutputDelay;
        end
    end

    for cx=1:nx
        if k - OutputDelayVec(cx) < 1
            X_k(cx) = xpp;
        else
            X_k(cx) = XX(k - OutputDelayVec(cx), cx);
        end
    end

    Y_k = (dC * X_k' + dD * U_k')';
end
