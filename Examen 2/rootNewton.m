function xRoot = rootNewton(f, x0, tolerance)
%ROOTNEWTON Usar el método de Newton Raphson
    fp = diff(f);
    xOld = x0;
    contIterations = 0;
    maxIterations = 300;
    errorA = 1e6;
    while errorA > tolerance && contIterations < maxIterations
        xNew = xOld - double(subs(f, xOld) / subs(fp, xOld));
        contIterations = contIterations + 1;
        errorA = abs(1 - xOld / xNew) * 100;
        xOld = xNew;
    end
    xRoot = xNew;
end

