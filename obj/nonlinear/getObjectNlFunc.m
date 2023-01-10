function getOutput = getObjectNlFunc(object)
    if strcmp(object, '1x1')
        getOutput = @(data, k) getObjectOutputNl1x1(data, k);
    elseif strcmp(object, '2x3')
        getOutput = @(data, k) getObjectOutputNl2x3(data, k);
    else disp('Unknown nonlinear object');
    end
end
