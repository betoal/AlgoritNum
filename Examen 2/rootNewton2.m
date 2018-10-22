function xRoot = rootNewton2(f, x0, tolerance)
%ROOTNEWTON Usar el método de Newton Raphson
    fp = diff(f);
    fpp = diff(fp);
    xOld = x0;
    contIterations = 0;
    maxIterations = 300;
    errorA = 1e6;
    while errorA > tolerance && contIterations < maxIterations
        xNew = xOld - double(subs(f, xOld) * subs(fp, xOld) / (subs(fp, xOld)^2 - (subs(f, xOld)*subs(fpp, xOld))));
        contIterations = contIterations + 1;
        errorA = abs(1 - xOld / xNew) * 100;
        xOld = xNew;
    end
    xRoot = xNew;
end

