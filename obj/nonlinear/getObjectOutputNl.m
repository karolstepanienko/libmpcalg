function YY_k = getObjectOutputNl(object, ypp, YY, upp, UU, k)
    if strcmp(object, '1x1') YY_k = getObjectOutputNl1x1(ypp, YY, upp, UU, k);
    elseif strcmp(object, '2x3') YY_k = getObjectOutputNl2x3(ypp, YY, upp, UU, k);
    else disp('Unknown nonlinear object');
    end
end
