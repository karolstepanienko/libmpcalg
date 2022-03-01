% TODO create a DMC class
function DMC()
    %load('../test/MIMO3x4StepResponses.mat', 'stepResponses');
    addpath('../test');
    
    %% DMC parmameters
    D = 100; % Dynamic horizon
    N = 5; % Prediction horizon
    Nu = 2; % Moving horizon

    %% Object
    st = 0.1; % Sampling time
    obj = get3x2Obj(st);
    
    %% DMC parameters
    % Enables choosing which output is more important
    % Here all are equally important
    mi = ones(obj.ny, 1); 
    lambda = ones(obj.nu, 1); % Control weight
    
    Sp = getSp(obj, D);
    Mp = getMp(obj, Sp, N, D);
    M = getM(obj, Sp, N, Nu);
    Xi = getXi(obj, mi, N);
    Lambda = getLambdaMatrix(obj, lambda, Nu);
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

%% getXi
% Creates Xi matrix used by DMC algorithm
function Xi = getXi(obj, mi, N)
    Xi = zeros(obj.ny*N);
    for i=1:N
        Xi((i - 1)*obj.ny + 1:i*obj.ny, (i - 1)*obj.ny + 1:i*obj.ny) = ...
            diag(mi); % square ny x ny matrix
    end
end

%% getLambdaMatrix
% Creates Lambda matrix used by DMC algorithm
function Lambda = getLambdaMatrix(obj, lambda, Nu)
    Lambda = zeros(obj.nu*Nu);
    for i=1:Nu
        Lambda((i - 1)*obj.nu + 1:i*obj.nu, (i - 1)*obj.nu + 1:i*obj.nu) = ...
            diag(lambda); % square ny x ny matrix
    end
end
