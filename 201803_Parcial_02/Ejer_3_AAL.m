% Ejercicio Nomina
%
%
TarifaISR2018 = readtable('TarifaISR2018.csv');
sueldos = readtable('sueldos.csv');
%
% Ejemplo de cálculo del nuevo sueldo para un aumento neto del 4.5% para un
% sueldo de 80,000
%
aumento = 0.045;
sdo = 80000;
salario = sueldos.sueldo;
nom_or = zeros(1,1000);
nom_nuev = zeros(1,1000);
for i = 1:1000
    nom_or(i) = salario(i);
    neto_sdo = neto_isr(salario(i),TarifaISR2018);
    nuevo_neto = neto_sdo * (1 + aumento);
    g = @(x)(neto_isr(x,TarifaISR2018)-nuevo_neto);
    nuevo_sdo = secante(g,1000,1e6,1);
    nom_nuev(i) = nuevo_sdo;
end
nomOr = sum(nom_or)
nomNuev = sum(nom_nuev)
aumento = (nomNuev-nomOr)/nomOr
%
% 
%
