%
% Se va a suministrar una medicina a un paciente de 60 Kg.
% La cantidad de sangre es la treceava parte del peso de la persona.
% La concentración en mg/ml corresponde la la siguiente expresión:
%
% C(t) = A * t^alfa * exp(t/5).... en mg/ml
%        A en mg/ml
%
% a) determine la cantidad A ( en mg/ml y en gramos) que debe
% suministrársele a la persona para que la concentración máxima sea de 1.25
% mg/ml
% b) no se debe dejar que la concentración baje de 0.15 mg/ml. Determine a
% que hora debe suministrarse una segunda inyección.
% c) Determine de cuanto debe ser la segunda inyección en mg/ml y en gramos
% para que en el momento de mayor concentración no exceda del valor
% anteriormente señalado.
%
% Solución:
% Primeramente obtengamos la gráfica cuando A = 1, para t = 0:0.0.01:10
%
  A = 1; B = 5; alfa = 1.25;
  Cmax = 1.25; % en mg / ml
%
  C = @(t) ( A * t.^alfa .* exp( - t ./ B ));
  t = 0:0.05:50;
  hold off
  plot(t, C(t))
  pause(1)
%  
% a) El momento de mayor concentración se obtiene por cálculo 
% y es t_cmax = B * alfa horas.
%
  t_cmax = alfa * B
%
% el valor de la concentración en este momento es 
% C(t_max) = A*t_cmax^alfa*exp(-t_cmax/B) <= Cmax = 1.25 mg / ml
% de donde despejando A resulta
%
% A1_mg_cc <= Cmax / ( t_cmax^alfa * exp( -t_cmax/B))
%
  A1_mg_cc = Cmax / ( t_cmax^alfa * exp( -t_cmax/B))
  A = A1_mg_cc;
% y en gramos
A1_gr = A1_mg_cc * 60 /13 % se compensan los milis de los miligramos con los ml de los litros
%
  C = @(t) ( A1_mg_cc * t.^alfa .* exp( - t ./ B ));
  plot(t, C(t))
  pause(1)
%
% b) Para obtener el momento de la segunda inyección se elabora un handler de
% una función y se utiliza el método de Newton
%
hf=@(t)(A1_mg_cc * t^alfa * exp(-t/B) - 0.15)
%
% Calculando el tiempo de la segunda inyacción para que la concentración no
% baje de 0.15 mg/ml
% t2 en horas
%
t2 = raizPorNewton(hf,10,0.001,1000)
%
hold on
plot(t,0.15*ones(size(t)))
plot([t2],[0.15],'o')
%
% c) Suponga que el efecto de las inyecciones es aditivo y proceda por
% "cálculo", solamente que en este caso el momento del máximo ya no es
% posible despejarlo y lo debe estimar numéricamente y depende del valor de
% la A2 inyectada. Por ello debe definir una estrategia para estimar el
% valor del momento y en última instancia el valor de la segunda dosis.
%

