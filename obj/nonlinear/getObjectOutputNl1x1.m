%% getObjectOutputNl1x1
% Nonlinear 1x1 object
function [Y_k, varargout] = getObjectOutputNl1x1(data, k)
    % Example object
    a = [0.05, 0.15];
    b = [0.1, 0.2];
    if k == 1 Y_k = b(1) * data.upp^3 + b(2) * data.upp...
        - a(1) * data.ypp - a(2) * data.ypp;
    elseif k == 2 Y_k = b(1) * data.UU(k-1)^3 + b(2)*data.upp...
        - a(1) * data.UU(k-1) - a(2) * data.ypp;
    else Y_k = b(1) * data.UU(k-1)^3 + b(2)*data.UU(k-2)...
        - a(1) * data.YY(k-1) - a(2) * data.YY(k-2);
    end
    varargout{1} = data.data;
end
