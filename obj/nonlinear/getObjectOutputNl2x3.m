%% getObjectOutputNl2x3
% Nonlinear 2x3 object
function YY_k = getObjectOutputNl2x3(ypp, YY, upp, UU, k)
    ny = 2; nu = 3;
    YY_k = zeros(1, ny);
    a = [0.25, 0.02;
        0.01, 0.25];  % a(ny, 2)
    b = [0.12, 0.08;
        0.15, 0.25;
        0.7, 0.5];  % b(nu, 2)
    if k == 1
        YY_k(1, 1) = b(1, 1) * upp^3 - b(2, 1) * upp ...
            + b(3, 1) * upp ...
            - a(1, 1) * ypp - a(2, 1) * ypp;
        YY_k(1, 2) = b(1, 2) * upp^3 - b(2, 2) * upp ...
            + b(3, 2) * upp ...
            - a(1, 2) * ypp - a(2, 2) * ypp;
    else
        YY_k(1, 1) = b(1, 1) * UU(k-1, 1)^3 - b(2, 1) * UU(k-1, 2) ...
            + b(3, 1) * UU(k-1, 3) ...
            - a(1, 1) * YY(k-1, 1) - a(2, 1) * YY(k-1, 2);
        YY_k(1, 2) = b(1, 2) * UU(k-1, 2)^3 - b(2, 2) * UU(k-1, 1) ...
            + b(3, 2) * UU(k-1, 3) ...
            - a(1, 2) * YY(k-1, 1) - a(2, 2) * YY(k-1, 2);
    end
end
