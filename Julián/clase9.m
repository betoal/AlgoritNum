% Floating point
valEc = exp(l)+(0.435./l).*(exp(l)-1);
plot(l, valEc)
hold on 
plot([-2,2], [1.564, 1.564], 'Color', 'k')

valEc = @(l) exp(l)+(0.435./l).*(exp(l)-1) - 1.564;
intervalos = cambioSigno(valEc, -2, 2, 15);