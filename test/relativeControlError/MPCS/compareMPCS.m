%!assert(compareMPCS(false, 1.0, '1x1', 'analytical') < [10^-20, 10^-20])


%% compareMPCS
% Comparison of MPCS algorithms from libmpcalg and JMatlab libraries
function [errorYY_MPCS_JMatlab, errorUU_MPCS_JMatlab] =...
    compareMPCS(varargin)
    if size(varargin, 1) == 0 isPlotting = false;
    else isPlotting = varargin{1}; end

    dA = [0.9684, 0;
          0, 0.9684];
    dB = [0.03278, 0.00198;
          0.00198, 0.03278];
    dC = [1, 0;
          0, 1];
    dD = [0, 0;
          0, 0];
    InputDelay = [0, 0];
    st = 1;

    % Regulator parameters
    D = 99;
    N = 15;
    Nu = 10;
    ny = 2;
    nu = 2;
    nx = size(dA, 1);
    lambda = ones(1, nu); % Input importance
    mi = ones(1, ny);  % Output importance
    uMin = -inf;
    duMin = -inf;
    algType = 'analytical';

    % Trajectory in JMatlab starts from 1 and first index is at 0, hence
    % trajectory has 49 elements
    kk = 49;
    YYzad = [ones(kk, 1) * 13, ones(kk, 1) * 15];
    ypp = 0;
    upp = 0;
    xpp = 0;

    stepResponse = getStepResponsesState(nx, ny, nu, InputDelay, dA, dB, dC, dD, D);

    % Regulator MPCS
    regMPCS = MPCS(N, Nu, ny, nu, nx, dA, dB, dC, dD,...
        'mi', mi, 'lambda', lambda, 'uMin', uMin, 'uMax', -uMin,...
        'duMin', duMin, 'duMax', -duMin, 'algType', algType);

    XX_MPCS = ones(kk, nx) * xpp;
    YY_MPCS = ones(kk, ny) * ypp;
    UU_MPCS = ones(kk, nu) * upp;

    % MPCS control loop
    for k=1:kk
        regMPCS = regMPCS.calculateControl(XX_MPCS(k, :), YYzad(k, :));
        UU_MPCS(k, :) = regMPCS.getControl();
        [XX_MPCS(k + 1, :), YY_MPCS(k, :)] = getObjectOutputState(dA, dB, dC,...
            dD, XX_MPCS, xpp, nx, UU_MPCS, upp, nu, ny, InputDelay, k);
    end

    % According to this test both implementations are the same
    % Get variables from JMatlab library
    MPCSOutputJMatlab;
    errorYY_MPCS_JMatlab = Utilities.calMatrixError(YY_MPCS, YY_JMatlab);
    errorUU_MPCS_JMatlab = Utilities.calMatrixError(UU_MPCS, UU_JMatlab);
    fprintf("Output difference for JMatlab and libmpcalg MPCS: %s\n",...
        num2str(errorYY_MPCS_JMatlab));
    fprintf("Control difference for JMatlab and libmpcalg MPCS: %s\n",...
        num2str(errorUU_MPCS_JMatlab));
    
    if isPlotting
        plotRun(YY_MPCS, YY_JMatlab, UU_MPCS, st, ny, nu, 'Comparison of MPCS', algType);
    end
end
