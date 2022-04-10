classdef DMC < MPC
    properties
        %% DMC parmameters
        D % Dynamic horizon
        N % Prediction horizon
        Nu % Moving horizon
        stepResponses % Control object step response(s)
        mi % Output importance
        lambda % Control weight
        ny % Number of outputs
        nu % Number of inputs
        U_k % Current control value
        uMin % Minimal control value
        uMax % Maximal control value
        duMin % Minimal control change value
        duMax % Maximal control change value
    end

    properties (Access=private)
        dUU_k % Vector containing control values
        dUUp_k % DUUp vector containing past control value changes
    end

    methods
        function obj = DMC(D, N, Nu, stepResponses, mi, lambda,...
                uMin, uMax, duMin, duMax)
            % OCTAVE treats argument checking as parse error
            % arguments
            %     D (1,1) int8
            %     N (1,1) int8
            %     Nu (1,1) int8
            %     stepResponses
            %     mi (:,1) double
            %     lambda (:,1) double
            %     uMin (1,1) double = -1
            %     uMax (1,1) double = 1
            %     duMin (1,1) double = -0.1
            %     duMax (1,1) double = 0.1
            % end
            obj.D = D;
            obj.N = N;
            obj.Nu = Nu;
            obj.stepResponses = stepResponses;
            obj.mi = mi;
            obj.lambda = lambda;
            obj.uMin = uMin;
            obj.uMax = uMax;
            obj.duMin = duMin;
            obj.duMax = duMax;
            
            obj = obj.initMPC();
            obj = obj.initDMC();
        end

        %% calculateControl
        % Calculates new, current object control values
        % Should be run in a loop
        % @param Y_k        horizontal vector of current output values
        % @param Yzad_k     horizontal vector of target trajectory values
        function obj = calculateControl(obj, Y_k, Yzad_k)
            YY_k = obj.getYY_k(Y_k');
            YYzad_k = obj.getYYzad_k(Yzad_k');
            
            % Get YY_0
            YY_0 = YY_k + obj.Mp * obj.dUUp_k;
            % Get new control change value
            obj.dUU_k = obj.K * (YYzad_k - YY_0);
            
            % Limit control change values
            dU_k = obj.limitdU_k(obj.dUU_k(1:obj.nu));
            
            % Shift dUUp values
            obj.dUUp_k = [dU_k;...
                obj.dUUp_k(1:(length(obj.dUUp_k)-obj.nu), 1)];

            % Get new control value
            % Here U_k = U_k_1 and is updated
            obj.U_k = obj.limitU_k(obj.U_k + obj.dUU_k(1:obj.nu, 1));
        end
        
        %% Getters
        function nu = get.nu(obj)
            nu = size(obj.stepResponses, 1);
        end
        
        function ny = get.ny(obj)
            if obj.nu > 1 % For object with multiple inputs
                % Get ncolumns for first input
                ny = size(obj.stepResponses{1,1}, 2);
            else % For object with single input
                ny = size(obj.stepResponses{1,1}, 2);
            end
        end
        
        %% getControl
        % Returns horizontal vector of new control values
        function U_k = getControl(obj)
            U_k = obj.U_k';
        end
    end

    methods (Access=private)
        %% initDMC
        % Prepares neccessary vectors used by DMC algorithms
        function obj = initDMC(obj)
            obj.dUU_k = obj.initdUU_k();
            obj.dUUp_k = obj.initdUUp_k();
            obj.U_k = obj.initU_k();
        end

        %% getYYzad_k
        function YYzad_k = getYYzad_k(obj, Yzad_k)
            % Check if vector has improper number of elements
            if size(Yzad_k, 1) ~= obj.ny || size(Yzad_k, 2) ~= 1
                ME = getImproperVectorSizeException(Yzad_k);
                throw(ME);
            else
                YYzad_k = Utilities.stackVector(Yzad_k, obj.N);
            end
        end
        
        %% getYY_k
        function YY_k = getYY_k(obj, Y_k)
            % Check if vector has improper number of elements
            if size(Y_k, 1) ~= obj.ny || size(Y_k, 2) ~= 1
                ME = getImproperVectorSizeException(Y_k);
                throw(ME);
            else
                YY_k = Utilities.stackVector(Y_k, obj.N);
            end
        end
        
        %% initdUUp
        function dUUp_k = initdUUp_k(obj)
            dUUp_k = zeros(obj.nu*(obj.D - 1), 1);
        end
        
        %% initdUU
        function dUU_k = initdUU_k(obj)
            dUU_k = zeros(obj.nu*obj.Nu, 1);
        end
        
        %% getUU_k
        function U_k = initU_k(obj)
            U_k = zeros(obj.nu, 1);
        end
        
        %% limitU_k
        function U_k = limitU_k(obj, U_k)
            for i=1:obj.nu
                if U_k(i, 1) < obj.uMin
                    U_k(i, 1) = obj.uMin;
                elseif U_k(i, 1) > obj.uMax
                    U_k(i, 1) = obj.uMax;
                end
            end
        end

        %% limitdU_k
        function dU_k = limitdU_k(obj, dU_k)
            for i=1:obj.nu
                if dU_k(i, 1) < obj.duMin
                    dU_k(i, 1) = obj.duMin;
                elseif dU_k(i, 1) > obj.duMax
                    dU_k(i, 1) = obj.duMax;
                end
            end
        end
    end
end



%% getImproperVectorSizeException
function ME = getImproperVectorSizeException(V)
    ME = MException('MyComponent:improperVectorSize',...
    'Vector %s has improper size.', mat2str(V));
end
