% Ejercicio Nomina
%
%
TarifaISR2018 = readtable('TarifaISR2018.csv');
sueldos = readtable('sueldos.csv');
%
% Ejemplo de cálculo del nuevo sueldo para un aumento neto del 3% para un
% sueldo de 80,000
%
sdo = 80000;
neto_sdo = neto_isr(sdo,TarifaISR2018);
nuevo_neto = neto_sdo * 1.03;
g = @(x)(neto_isr(x,TarifaISR2018)-nuevo_neto);
nuevo_sdo = secante(g,1000,1e6,1);
%
% 
%
