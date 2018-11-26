% Ejercicio Nomina
%
%
tic
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
nvo_sdo = zeros(1000,1);
for k = 1:1000,
  neto_k = neto_isr( sueldos.sueldo(k),TarifaISR2018);  
  g = @(x)(neto_isr(x,TarifaISR2018)- neto_k * 1.045);
  nvo_sdo(k) = secante(g,1,1e6,1);
end
format('short')
nomina_actual = sum(sueldos.sueldo)
nueva_nomina = sum(nvo_sdo)
porc_aum_en_nomina = nueva_nomina / nomina_actual
toc
