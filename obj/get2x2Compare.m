function obj = get2x2Compare()
    obj.dA = [0.9684, 0;
          0, 0.9684];
    obj.dB = [0.03278, 0.00198;
          0.00198, 0.03278];
    obj.dC = [1, 0;
          0, 1];
    obj.dD = [0, 0;
          0, 0];
    obj.InputDelay = [0, 0];
    obj.st = 1;
    obj.osf = 1;

    % Regulator parameters
    obj.D = 99;
    obj.N = 15;
    obj.Nu = 10;
    obj.ny = 2;
    obj.nu = 2;
    obj.nx = size(obj.dA, 1);
    obj.lambda = ones(1, obj.nu); % Input importance
    obj.mi = ones(1, obj.ny);  % Output importance
    obj.uMin = -inf;
    obj.duMin = -inf;
    obj.getOutput = @getOutput2x2Compare;
end

function [YY_k, varargout] = getOutput2x2Compare(data, k)
    ny = 2; nu = 2;
    YY_k = ones(1, ny);
    if k == 1
        YY_k(1, 1) = 0.9684 * data.ypp + 0.03278 * data.upp...
            + 0.00198 * data.upp;
        YY_k(1, 2) = 0.9684 * data.ypp + 0.00198 * data.upp...
            + 0.03278 * data.upp;
    else
        YY_k(1, 1) = 0.9684 * data.YY(k - 1, 1)...
            + 0.03278 * data.UU(k - 1, 1) + 0.00198 * data.UU(k - 1, 2);
        YY_k(1, 2) = 0.9684 * data.YY(k - 1, 2)...
            + 0.00198 * data.UU(k - 1, 1) + 0.03278 * data.UU(k - 1, 2);
    end
    varargout{1} = data.data;
end
