function runCompareDMC()
    compareDMC(true, 1.0, '1x1', 'analytical');
    compareDMC(true, 1.0, '1x1', 'numerical');
    compareDMC(true, 0, '1x1', 'analytical');
    compareDMC(true, 0, '1x1', 'numerical');

    compareDMC(true, 1.0, '1x1RelativeTest', 'analytical');
    compareDMC(true, 1.0, '1x1RelativeTest', 'numerical');
    compareDMC(true, 0, '1x1RelativeTest', 'analytical');
    compareDMC(true, 0, '1x1RelativeTest', 'numerical');
end
