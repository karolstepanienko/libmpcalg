%% getObjectOutput
% Calculates object output
function y = getObjectOutput(ny, nu, numDen, YY, UU, ypp, upp, k)
    y = zeros(1, ny);
    y = y + getUOutput(ny, nu, numDen, UU, upp, k);
    [~, choosenU] = max(UU(k, :));
    y = y + getYOutput(ny, nu, numDen, YY, ypp, k, choosenU);
end

%% getUOutput
% Calculates part of object output value using only past control
% values
function y = getUOutput(ny, nu, numDen, UU, upp, k)
    y = zeros(1, ny);
    for cy=1:ny
        for cu=1:nu
            num = numDen{cy,cu}{1};
            uVec = getuVec(UU(:, cu), length(num), upp, k);
            y(1, cy) = y(1, cy) + num*uVec;
        end
    end
end

%% getYOutput
% Calculates part of object output value using only past output
% values
function y = getYOutput(ny, nu, numDen, YY, ypp, k, choosenU)
    y = zeros(1, ny);
    for cy=1:ny
        den = numDen{cy, choosenU}{2};
        yVec = getyVec(YY(:, cy), length(den), ypp, k);
        y(1, cy) = y(1, cy) - den(2:end) * yVec;
    end
end

%-------------------------------------------------------------------------------

%% getuVec
% Creates vector of past u values
function uVec = getuVec(U, numLen, upp, k)
    uVec = zeros(numLen, 1);
    for i=0:numLen - 1
        if k <= i
            uVec(i+1, 1) = upp;
        else
            uVec(i+1, 1) = U(k - i, 1);
        end
    end
end

%% getyVec
% Creates vector of past y values
function yVec = getyVec(Y, denLen, ypp, k)
    yVec = zeros(denLen - 1, 1);
    for i=1:denLen - 1
         if k <= i
            yVec(i, 1) = ypp;
        else
            yVec(i, 1) = Y(k - i, 1);
        end
    end
end
