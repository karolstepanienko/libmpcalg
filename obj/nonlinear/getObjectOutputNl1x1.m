%% getObjectOutputNl1x1
% Nonlinear 1x1 object
function Y_k = getObjectOutputNl1x1(ypp, Y, upp, U, k)
    % Example object
    a = [0.05, 0.15];
    b = [0.1, 0.2];
    if k == 1 Y_k = b(1) * upp^3 + b(2) * upp - a(1) * ypp - a(2) * ypp;
    elseif k == 2 Y_k = b(1) * U(k-1)^3 + b(2)*upp - a(1) * U(k-1) - a(2) * ypp;
    else Y_k = b(1) * U(k-1)^3 + b(2)*U(k-2) - a(1) * Y(k-1) - a(2) * Y(k-2);
    end
end
