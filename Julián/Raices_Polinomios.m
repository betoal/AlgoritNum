%% Método para sacar raíces de polinomios

% altura = @(h) h^3-3*h^2+3.2;
% c = [1 -3 0 3.2] % Coeficientes del polinomio
% 
% roots(c) % Sacar raíces del polinomio

a = 12.5577822;
b = 0.0018626;
P = 65000;
T = -40 + 273.15;
R = 0.518;

fun1 = @(v) -P + (R*T)/(v-b) -a/(v*(v+b)*sqrt(T));
raiz = (fzero(fun1,0.002)) % El punto donde la función es cero