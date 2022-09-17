function runAllTestsOctave()
    if Utilities.isMatlab()
        disp('These tests can only be run in Octave');
        return
    end
    disp('Testing DMC regulator implementation:')
    test testDMC
    disp('Testing DMC regulator parameter validation:')
    test testDMCParameters
    
    disp('Testing GPC regulator implementation:')
    test testGPC
    
    disp('Testing MPCS regulator implementation:')
    test testMPCS
    disp('Testing MPCS regulator parameter validation:')
    test testMPCSParameters
end
