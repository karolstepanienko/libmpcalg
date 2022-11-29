function runAllTestsOctaveParallel
    Utilities.loadPkgParallelInOctave();
    choosenTests = {'compareStepResponse', 'testDMC', 'testDMCParameters',...
        'testGPC', 'testMPCS', 'testMPCSParameters', 'compareDMC'};
    vector_y = pararrayfun(nproc - nproc*0.1, @runTestsOctaveParallel,...
        choosenTests);
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
    end
end
