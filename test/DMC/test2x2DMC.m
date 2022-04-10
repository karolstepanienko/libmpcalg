function test2x2DMC()
    %% Object
    % Setting sampling time -> ../../obj/get2x2.m
    load(Utilities.getObjBinFilePath('2x2.mat'));
    ypp = 0;
    upp = 0;

    %% Simulation length
    c = Constants();
    kk = c.testSimulationLength; 
    
    %% Trajectory
    Yzad = getTrajectory(kk, ny);

    %% Test loop
    testSingleDMC(ny, nu, st, numDen, ypp, upp, Yzad, kk);
end

function Yzad = getTrajectory(kk, ny)
    Yzad = zeros(kk, ny);
    for i=201:400; Yzad(i, :) = [0.3 -0.3]; end
    for i=401:600; Yzad(i, :) = [-0.1 0.1]; end
    for i=601:800; Yzad(i, :) = [-0.5 0.5]; end
end
