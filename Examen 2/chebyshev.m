function polynomial = chebyshev(n, f)
%CHEBYSHEV Get a polinomial in a range of points
    % Get root points
    syms xC
    %% Sin números
    T0 = 1;
    T1 = xC;
    T = sym(zeros(1, n));
    for i=1:n
        if i == 1
            newT = T0;
        elseif i == 2
                newT = T1;
        else
            newT = 2 * xC .* T(i - 1) - T(i - 2);
        end
        T(i) = newT;
    end
    %% Con números
    k = 0:(n-1);
    xK = cos(pi * (2 * k +1) / (2 * n));
    T0 = ones(n, 1);
    T1 = xK';
    TN = zeros(n, n);
    for i=1:n
        if i == 1
            newT = T0;
        elseif i == 2
                newT = T1;
        else
            newT = 2 * xK' .* TN(:, i - 1) - TN(:, i - 2);
        end
        TN(:, i) = newT;
    end
    norm = ones(1, n) * sqrt(n / 2);
    norm(1) = sqrt(n);
    fXK = f(xK);
    TUnitN = TN ./ norm;
    coef = fXK * TUnitN;
    coefReal = coef ./ norm;
    %% Final
    polynomial = 0;
    for i = 1:n
        polynomial = polynomial + coefReal(i) * T(i);
    end
end

