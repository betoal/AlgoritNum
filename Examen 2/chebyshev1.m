function polynomial = chebyshev(n, f, x)
%CHEBYSHEV Get a polinomial in a range of points
    % Get root points
    syms xC
    k = 0:(n-1);
    xK = cos(pi * (2 * k +1) / (2 * n));
    T0 = ones(n, 1);
    T1 = xK';
    T = zeros(n, n);
    for i=1:n
        if i == 1
            newT = T0;
        elseif i == 2
                newT = T1;
        else
            newT = 2 * xK' .* T(:, i - 1) - T(:, i - 2);
        end
        T(:, i) = newT;
    end
    norm = ones(1, n) * sqrt(n / 2);
    norm(1) = sqrt(n);
    fXK = f(xK);
    TUnit = T ./ norm;
    coef = vpa(fXK * TUnit);
    coefReal = coef ./ norm;
    polyVal = zeros(max(size(x)), n);
    val0 = ones(max(size(x)), 1);
    val1 = x';
    for i=1:n
        if i == 1
            newVal = val0;
        elseif i == 2
                newVal = val1;
        else
            newVal = 2 * x' .* polyVal(:, i - 1) - polyVal(:, i - 2);
        end
        polyVal(:, i) = newVal;
    end
    poly = zeros(max(size(x)), n);
    for i=1:n
        poly(:, i) = polyVal(:, i)*coef(i)/norm(i);
    end
    polynomial = sum(poly');
end

