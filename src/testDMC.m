function testDMC()
    addpath('../test');
    %% Object
    st = 0.1; % Sampling time
    cObj = get3x2Obj(st);
    
    %% DMC parameters
    D = 100; % Dynamic horizon
    N = 10; % Prediction horizon
    Nu = 5; % Moving horizon
    mi = ones(cObj.ny, 1); % Output importance
    lambda = ones(cObj.nu, 1); % Control weight
    
    % Get D elements of object step response
    stepResponses = cObj.getStepResponses(D);
    
    rObj = DMC(D, N, Nu, stepResponses, mi, lambda);
    rObj.run([2;3;1], [1;2;3])

    
%     Mp = getMp(obj, Sp, N, D);
%     M = getM(obj, Sp, N, Nu);
%     Xi = getXi(obj, mi, N);
%     Lambda = getLambdaMatrix(obj, lambda, Nu);
    %K = getKMatrix();
end