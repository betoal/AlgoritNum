%% Inyecciones

% Determinar la cantidad de concentración de una medicina en cierta
% inyección

% c2(t) = o antes de t2; c(t-t2) para t>=t2

t = 3;
B = 1/5;
Cmax = 0.05;
A = Cmax ./ (1:t) .* ( exp ( (1:t) .* -B));
C = A.*(1:t).*exp(-(1:t).*(B));
format('long'); C
A


%% Escaleras
% Se tienen 2 escaleras e1 = 30 ^ e2 = 20, las cuales se intersecan a una
% altura de 10




%% ISR

% neto(x) = x - isr
% isr(x) = cuota_fija_c(x) + %_c(x) * (x - lim_inf_c(x))
% siendo c la categoría con lim_inf_c < x < lim_sup_c

% Problema: Dado una cantidad de ingreso neto, obtener x