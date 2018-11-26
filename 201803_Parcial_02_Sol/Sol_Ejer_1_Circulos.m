% Ejercicio 1:
% Calcular los dos puntos de intersección de los círculos:
% Círculo A: Centro en (1,1) y radio 2
% Círculo B: Centro en (2,3) y radio 3
%
% Para ello primero obtenga un gráfico con los dos círculos
%
cA = [1,1];
rA = 2;
cB = [2,3];
rB = 3;
%
% Gráfica
%
hold off
t = (0:200)*2*pi/200;
plot(cA(1) + rA * cos(t), cA(2) + rA * sin(t))
hold on
plot(cB(1) + rB * cos(t), cB(2) + rB * sin(t))
format('long')
%
% determine ahora los dos puntos de intersección
%
% Círculo: y = Cy + raiz( R^2 - ( x^2 - Cy)^2 )
%
% Punto 1:
%
f1 = @(x) ( ( cA(2) + sqrt(rA^2 - ( x - cA(1) )^2 ) ) - ( cB(2) - sqrt(rB^2 - ( x - cB(1) )^2 ) ) ); 
%
x1 = real(raizPorNewton(f1,0,0.000001,1000))
y1A = cA(2) + sqrt(rA^2 - ( x1 - cA(1) )^2 )
y1B = cB(2) - sqrt(rB^2 - ( x1 - cB(1) )^2 )
%
%%
% Punto 2:
%
f2 = @(x) ( ( cA(2) - sqrt(rA^2 - ( x - cA(1) )^2 ) ) - ( cB(2) - sqrt(rB^2 - ( x - cB(1) )^2 ) ) ); 
%
x2 = real(raizPorNewton(f2,2,0.000001,1000))
y2A = cA(2) - sqrt(rA^2 - ( x2 - cA(1) )^2 )
y2B = cB(2) - sqrt(rB^2 - ( x2 - cB(1) )^2 )
%
plot([x1,x2],[y1A,y2A],'o')
plot([x1,x2],[y1A,y2A])
%
%
% Distancia entre los puntos:
%
dist = sqrt( ( x1 - x2 )^2 + ( y2A - y1A ) ^2 )
%
% Fin del ejercicio
%
