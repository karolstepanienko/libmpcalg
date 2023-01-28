%% get1x1Disturbance
% Returns stable SISO object used as a measured disturbance
function obj = get1x1Disturbance(st)
    arguments
        st (1,1) { mustBeNumeric } = 0.1  % Sampling time
    end

    %% Single inertial object
    % Object's continuous transmittance
    %    K           1
    % -------- = ---------
    %  Ts + 1     2s + 1

    K = 0.1;  % Gain
    T = 1;  % Time constant

    cNum = [K];
    cDen = [T, 1];

    Gs = tf(cNum, cDen);  % Continuous transmittance
    obj = MIMOObj(Gs, st);   % Object
    step(obj.Gz)

    fileName = '1x1Disturbance';
    obj.save(fileName);

    m = matfile(Utilities.getObjBinFilePath(fileName), 'Writable',true);
    m.D = 150;
    m.N1 = 1;
    m.nz = 1;
end
