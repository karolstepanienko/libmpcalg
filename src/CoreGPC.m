classdef (Abstract) CoreGPC < MPC & handle
    properties
        A  % (ny, ny) cell containing nA sized vectors describing relation
           % between output value(s) and past output value(s)
        B  % (nu, nu) cell containing nB sized vectors describing relation
           % between current control value(s) and past control value(s)

        % Optional
        IODelay  % Input-Output delay
        ypp  % Output initial value
        upp  % Control initial value
        YY  % Output values
        UU  % Control values
        k  % Control loop iterator
    end

    properties (GetAccess = public, SetAccess = protected)
        stepResponses  % Cell of control object step response
    end

    methods (Access = protected)
        function obj = initCoreGPC(obj)
            obj.c = Constants();
            obj.stepResponses = getStepResponsesEq(obj.ny, obj.nu,...
                obj.IODelay, obj.A, obj.B, obj.N + 1);
            obj.Sp = obj.getSp(obj.stepResponses, obj.N + 1);
            obj.M = obj.getM();
            obj.Xi = obj.getXi();
            obj.Lambda = obj.getLambda();
            obj.K = obj.getK(obj.M, obj.Xi, obj.Lambda);
            obj.UU_k = obj.upp * ones(1, obj.nu);
        end
    end

    methods
        function YY_0 = getYY_0(obj)
            YY_0_tmp = zeros(obj.N - obj.N1 + 1 + 1, obj.ny);
            UU_tmp = obj.UU;
            YY_tmp = obj.YY;
            % Assumed last known control value to be constant for next
            % N elements
            for i=obj.k:obj.k + obj.N + 1
                UU_tmp(i, :) = obj.UU_k;
            end
            for i=0:obj.N
                YY_0_tmp(i + 1, :) = getObjectOutputEq(obj.A, obj.B,...
                    YY_tmp, obj.ypp, UU_tmp, obj.upp, obj.ny, obj.nu,...
                    obj.IODelay, obj.k + i);
                YY_tmp(obj.k + i, :) = YY_0_tmp(i + 1, :);
            end
            % Prediction from YY_0(k+1) to remove the need for M matrix shift
            YY_0_tmp = YY_0_tmp(obj.N1 + 1:end, :);
            YY_0 = zeros(obj.ny * (obj.N - obj.N1 + 1), 1);
            for p=1:obj.N - obj.N1 + 1
                YY_0((p-1) * obj.ny + 1:p * obj.ny, 1) = YY_0_tmp(p, :)';
            end
        end
    end
end
