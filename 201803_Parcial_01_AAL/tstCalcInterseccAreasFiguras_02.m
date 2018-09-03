%tstCalcInterseccAreasFiguras_02
%
N = 10000;
figs = {};
% figs(1) = {Circulo([0.0;0.0],1.0)};
% figs(2) = {Circulo([0.0;1.0],1.0)};
% figs(3) = {Circulo([0.5;0.5*sqrt(3)],1.0)};
 figs(1) = {ElipseCanonica([1.0;0.0],2.0,1.0)};
% figs(4) = {RectanguloCanonico([2.0;1.0],2.0,3.0)};
% figs(1) = {RomboCanonico([0.0;0.0],2.0,3.0)};
% figs(6) = {Triangulo([0.0;0.0],[1.0;0.0],[0.0;1.0])};
veces = 500;
nf   = size(figs,2);
area = zeros(veces,2^nf);
tic
k = 1;
for vez = 1:veces
    [a,tamRect] = calcInterseccAreasFiguras_01(figs,N);
    area(vez,:) = a;
    if mod(vez,50) == 0
        %for k = 1:2^nf
           fprintf('vez: %4d, area(%3d): %12.6f\n',vez,k,a(k))
        %end     
    end
end    
toc
prom_area    = mean(area);
desvStd_area = std(area);
for k = 1:2^nf
    fprintf('para intersección %3d, promedio de area: %12.6f,   desvStd: %12.6f\n', ...
         k,prom_area(k), desvStd_area(k))
end
%
% ================= Fin de tst ====================
%
