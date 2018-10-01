%% interpolación

y = @(x) x.^4 -3.4*x.^3 -4.5*x-10;
xdat = [-2 0 1.5 3.4 10];
ydat = y(xdat);
%polyfit(xdat,ydat,4); % Interpolación del polinomio
coef = polyfit(xdat,ydat,4) % Saca el valor de los coeficientes de un polinomio

polyval(coef,2) % Da el valor del polinomio evaluado en x punto.

%% Lagrange
x = [1 1.3 1.6 1.9 2.2];
y = [0.1411 -0.6878 -0.9962 -0.5507 0.3115];
interpLagrange(x,y,1.5)


%% Segundo Método Lagrange
xVal = linspace(1,2.2);
yVal = zeros(length(xVal),1);

% x = [1 1.3 1.6 1.9 2.2];
% y = [0.1411 -0.6878 -0.9962 -0.5507 0.3115];

for t = 1:length(xVal)
    yVal(t) = interpLangrange(x,y,xVal)
end

y2 = interpLagrange(x,y,xVal);
plot(xVal,yVal,'ro');
hold on
plot(xVal,y2,'bx');