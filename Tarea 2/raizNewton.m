function raiz = raizNewton(f,x,eps)
% Saca la raiz de un número acotado por una epsilon
fs = sym(f);
fsp = diff(fs);
fp = matlabFunction(fsp);
xv = 2*x;
while( abs(xv-x)>eps)
    xv = x;
    x = x - f(x)/fp(x);
end
raiz = x;
end

