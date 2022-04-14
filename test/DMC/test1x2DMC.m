function test1x2DMC(funcDMC)
    %% Object
    % Setting sampling time -> ../../obj/get1x2.m
    load(Utilities.getObjBinFilePath('1x2.mat'));
    ypp = 0;
    upp = 0;

    %% Simulation length
    c = Constants();
    kk = c.testSimulationLength;
    
    %% Trajectory
    Yzad = getTrajectory(kk, ny);

    %% Test loop
    testSingleDMC(funcDMC, ny, nu, st, numDen, ypp, upp, Yzad, kk);
end

function Yzad = getTrajectory(kk, ny)
    Yzad = zeros(kk, ny);
    Yzad(201:400, :) = 1;
    Yzad(401:600, :) = -1;
    Yzad(601:800, :) = 0.5;
end
