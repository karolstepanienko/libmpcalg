function testDMC()
    addpath('../test');
    %% Object
    st = 0.1; % Sampling time
    cObj = get3x2Obj(st);
    
    %% DMC parameters
    D = 200; % Dynamic horizon
    N = D; % Prediction horizon
    Nu = D; % Moving horizon
    mi = ones(cObj.ny, 1); % Output importance
    lambda = ones(cObj.nu, 1); % Control weight
    
    % Get D elements of object step response
    stepResponses = cObj.getStepResponses(D);
    
    kk = 1000; % Simulation length
    %% Variable initialisation
    YY = zeros(kk, cObj.ny);
    UU = zeros(kk, cObj.nu);
    
    YYzad = getTrajectory3y(kk, cObj.ny);
    rObj = DMC(D, N, Nu, stepResponses, mi, lambda);
    
    for k=1:kk        
        YY(k, :) = cObj.getOutput(UU, YY, k);
        rObj = rObj.calculateControl(YY(k, :), YYzad(k, :));
        UU(k, :) = rObj.getU_k();
    end
    
    for i=1:cObj.ny
        figure;
        hold on
            plot(YYzad(:, i));
            plot(YY(:, i));
        hold off
    end
end

function YYzad = getTrajectory3y(kk, ny)
    YYzad = zeros(kk, ny);
     for i=200:400; YYzad(i, :) = [1.44, 4.62, 0.04]; end
%     for i=400:600; YYzad(i, :) = [-13.5, -2, 0.4]; end
%     for i=600:800; YYzad(i, :) = [0, 0, 0]; end

%     figure;
%     hold on
%     for i=1:ny; plot(YYzad(:, i)); end
%     hold off
end
