%% sym2tf
% Creates continuous-time transfer function model from symbolic expression.
function Gs = sym2tf(symGs)
    [ny, nu] = size(symGs);
    Gs = tf('s');
    for i=1:ny
        for j=1:nu
            [numerator, denominator] = numden(symGs(i, j));
            numerator_vec = sym2poly(numerator);
            denominator_vec = sym2poly(denominator);
            Gs(i,j) = tf(numerator_vec, denominator_vec);
        end
    end
end