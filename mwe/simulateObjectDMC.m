function Y_k = simulateObjectDMC(ny, nu, Y, ypp, U, upp, k)
    %% Load object
    load(Utilities.getObjBinFilePath(Utilities.joinText(num2str(ny), 'x', num2str(nu), '.mat')));
    Y_k = getObjectOutputEq(A, B, Y, ypp, U, upp, ny, nu, k);
end
