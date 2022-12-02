function runAllTestsOctaveParallel
    % Start time measurement
    tic

    Utilities.loadPkgParallelInOctave();
    choosenTests = {'compareStepResponse', 'testDMC', 'testDMCParameters',...
        'testGPC', 'testMPCS', 'testMPCSParameters', 'compareDMC',...
        'lambda0DMC', 'lambda0MPCS'};
    vector_y = pararrayfun(nproc - nproc*0.1, @runTestsOctaveParallel,...
        choosenTests);

    % End time measurement
    toc
end

function result = runTestsOctaveParallel(choosenTest)
    if strcmp(choosenTest, 'compareStepResponse')
        test compareStepResponse
        result = 1;
    elseif strcmp(choosenTest, 'testDMC')
        test testDMC
        result = 1;
    elseif strcmp(choosenTest, 'testDMCParameters')
        test testDMCParameters
        result = 1;
    elseif strcmp(choosenTest, 'testGPC')
        test testGPC
        result = 1;
    elseif strcmp(choosenTest, 'testMPCS')
        test testMPCS
        result = 1;
    elseif strcmp(choosenTest, 'testMPCSParameters')
        test testMPCSParameters
        result = 1;
    elseif strcmp(choosenTest, 'compareDMC')
        test compareDMC
        result = 1;
    elseif strcmp(choosenTest, 'lambda0DMC')
        test lambda0DMC
        result = 1;
    elseif strcmp(choosenTest, 'lambda0MPCS')
        test lambda0MPCS
        result = 1;
    end
end
