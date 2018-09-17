%% Método de Punto Fijo

%g = @(h) h^3-3*h^2+3.2+h; % Sin despejar h
%g = @(h) sqrt((h^3+3.2)/3); % Se despeja h^2

g = @(x) x*exp(0.5*x) + 1.2*x -5;

x0 = 0.6;
errorA = 1e6;
iterMax =100;
tol = 1e-6;
nIter = 0;
tic
while errorA>tol && nIter<iterMax
    xn = g(x0);
    errorA = abs(xn-x0);
    nIter = nIter+1;
    x0 = xn;
end
toc
x0