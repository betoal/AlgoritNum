%% Forma para encontrar raíces de manera gráfica

% Se grafica un intervalo del dominio en el cuál la función contiene al 0.
% No es una forma exacta de obtener la raíz, simplemente buscas una
% aproximación gráfica de la misma.

l = linspace(-2,2,300);
valEc = exp(l) + (0.435./l).*(exp(l)-1);
plot(l,valEc,'r-')
hold on
line([-2,2],[1.564 1.564],'Color','k')