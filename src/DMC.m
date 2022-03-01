% TODO create a DMC class
function DMC()
    %load('../test/MIMO3x4StepResponses.mat', 'stepResponses');
    addpath('../test');
    
    %% DMC parmameters
    D = 100; % Dynamic horizon
    N = 10; % Prediction horizon
    Nu = 2; % Moving horizon
    lambda = 1; % Control weight
    mi = [1, 2, 3]; % Enables choosing which output is more important
    
    st = 0.1; % Sampling time
    obj = get3x2Obj(st);
    Sp = getSp(obj, D);
    Mp = getMp(obj, Sp, N, D);
    M = getM(obj, Sp, N, Nu);
end

%% getSp
% Creates Sp matix from step response data
% in cell format
function Sp = getSp(obj, D)    
    % Variable initialisation
    Sp = cell(D, 1);
    sp = zeros(obj.ny, obj.nu); % Step response matrix in moment p

    for p=1:D % Step response moment
        for i=1:obj.nu
            for j=1:obj.ny
                sp(j,i) = obj.stepResponses{i}(p,j);
            end
        end
        Sp{p, 1} = sp;
    end
end

%% getMp
% Creates Mp matrix used by DMC algorithm
function Mp = getMp(obj, Sp, N, D)
    % Variable initialisation
    Mp = zeros(obj.ny*N, obj.nu*(D - 1));
    for i=1:N
        for j=1:D-1
            Mp((i - 1)*obj.ny + 1:i*obj.ny, (j - 1)*obj.nu + 1:j*obj.nu) = ...
                Sp{ min(D, i+j), 1} - Sp{j, 1};
        end
    end
end

%% getM
% Creates M matrix used by DMC algorithm
function M = getM(obj, Sp, N, Nu)
    % Variable initialisation
    M = zeros(obj.ny*N, obj.nu*Nu);
    for j=1:Nu
        for i=j:N
            M((i - 1)*obj.ny + 1:i*obj.ny, (j - 1)*obj.nu + 1:j*obj.nu) =...
                Sp{i-j+1, 1};
        end
    end
end
