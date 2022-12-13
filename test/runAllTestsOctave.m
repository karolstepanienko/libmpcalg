function runAllTestsOctave()
    % Start time measurement
    tic

    if Utilities.isMatlab()
        disp('These tests can only be run in Octave');
        return
    end

    % Step responses
    fprintf('Comparing step responses')
    test compareStepResponse

    %% DMC
    fprintf('Testing DMC regulator implementation:\n')
    test testDMC
    fprintf('\nTesting DMC regulator parameter validation:\n')
    test testDMCParameters

    %% GPC
    fprintf('\nTesting GPC regulator implementation:\n')
    test testGPC

    %% MPCS
    fprintf('\nTesting MPCS regulator implementation:\n')
    test testMPCS
    fprintf('\nTesting MPCS regulator parameter validation:\n')
    test testMPCSParameters

    % Compare DMC algorithms
    fprintf('Comparing DMC regulator implementations:\n')
    test compareDMC

    % Lambda0 DMC algorithm
    fprintf('Lambda0 DMC:\n')
    test lambda0DMC

    % Lambda0 MPCS algorithm
    fprintf('Lambda0 MPCS:\n')
    test lambda0MPCS

    % Compare MPCS algorithms
    fprintf('Comparing MPCS regulator implementations:\n')
    test compareMPCS

    % End time measurement
    toc
end
