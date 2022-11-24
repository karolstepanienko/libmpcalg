function [obj, Gz, InputDelay] = get1x1RelativeTestObj()
    st = 1;  % Sampling time
    InputDelay = 0;
    K = 1;  % Gain
    T1 = 50;  % Time constant
    Gs = tf(K, [T1, 1], 'InputDelay', InputDelay);  % Continuous transmittance
    Gz = c2d(Gs, st, 'zoh');  % Discrete transmittance
    obj = MIMOObj(Gs, st);   % Object
end
