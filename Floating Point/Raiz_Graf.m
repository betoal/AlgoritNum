%% Forma para encontrar ra�ces de manera gr�fica

% Se grafica un intervalo del dominio en el cu�l la funci�n contiene al 0.
% No es una forma exacta de obtener la ra�z, simplemente buscas una
% aproximaci�n gr�fica de la misma.

l = linspace(-2,2,300);
valEc = exp(l) + (0.435./l).*(exp(l)-1);
plot(l,valEc,'r-')
hold on
line([-2,2],[1.564 1.564],'Color','k')