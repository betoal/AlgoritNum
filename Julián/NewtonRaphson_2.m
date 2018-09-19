%% Ecuación de Redlich-Kwong

a = 12.5577822;
b = 0.0018626;
P = 65000;
T = -40 + 273.15;
R = 0.518;

syms v
f = sym(-P + (R*T)/(v-b) -a/(v*(v+b)*sqrt(T)));
df = diff(f);

iMax = 100;
tol = 1e-7;
x0 = 2e-3;

rSol = zeros(iMax,1);
rSol(1) = x0;
nIter = 1;
err = 1000;
errV = zeros(iMax,1);
while nIter<iMax && err>tol
    razon = double(subs(f,x0))/double(subs(df,x0));
    xn = x0 - razon;
    rSol(nIter+1) = xn;
    err = abs(xn-x0);
    errV(nIter+1) = err;
    x0 = xn;
    nIter = nIter+1;
end

fprintf('La raíz es: %.9f [m^3/kg] \n', rSol(nIter));
plot(1:nIter-1,errV(1:nIter-1),'b*--')
xlabel('num iteracion')
ylabel('|x_{n+1}-x_{n}|')

% valVol = linspace(-1,1,5e3);
% g = (R*T)./(valVol-b) -a./(valVol.*(valVol+b).*sqrt(T));
% 
% figure()
% plot(valVol,g,'r-')
% xlabel('vol especifico [m^3/kg]')
% ylabel('presion [kPa]')
