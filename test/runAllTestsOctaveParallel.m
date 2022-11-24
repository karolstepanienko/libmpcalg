function runAllTestsOctaveParallel
    Utilities.loadPkgParallelInOctave();
    choosenTests = {'testDMC', 'testDMCParameters', 'testGPC', 'testMPCS',...
        'testMPCSParameters'};
    vector_y = pararrayfun(nproc - nproc*0.1, @runTestsOctaveParallel,...
        choosenTests);
end

function result = runTestsOctaveParallel(choosenTest)
    if strcmp(choosenTest, 'testDMC')
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
    end
end
