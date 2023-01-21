%% getObjectOutputNl1x1
% Nonlinear 1x1 object
function Y_k = getObjectOutputNl1x1(regObj, k)
    % Example object
    a = [0.05, 0.15];
    b = [0.1, 0.2];
    if k == 1 Y_k = b(1) * regObj.upp^3 + b(2) * regObj.upp...
        - a(1) * regObj.ypp - a(2) * regObj.ypp;
    elseif k == 2 Y_k = b(1) * regObj.UU(k-1)^3 + b(2)*regObj.upp...
        - a(1) * regObj.UU(k-1) - a(2) * regObj.ypp;
    else Y_k = b(1) * regObj.UU(k-1)^3 + b(2)*regObj.UU(k-2)...
        - a(1) * regObj.YY(k-1) - a(2) * regObj.YY(k-2);
    end
end
