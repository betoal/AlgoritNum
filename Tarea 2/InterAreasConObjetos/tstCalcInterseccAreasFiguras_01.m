%tstCalcInterseccAreasFiguras_01
%
N = 10000;
figs = {};
figs(1) = {Circulo([-2.0;3.0],1.0)};
figs(2) = {Circulo([-1.0;3.0],1.0)};
figs(3) = {ElipseCanonica([1.0;0.0],2.0,1.0)};
figs(4) = {RectanguloCanonico([2.0;1.0],2.0,3.0)};
figs(5) = {RomboCanonico([-1.0;-1.0],2.0,3.0)};
veces = 500;
area3 = zeros(veces,1);
tic
parfor vez = 1:veces
    [a,tamRectGral] = calcInterseccAreasFiguras_01(figs,N);
    area3(vez) = a(3);
    if mod(vez,10) == 0
      fprintf('vez: %4d, area(3): %12.6f\n', vez,area3(vez))  
    end
end    
toc
prom_area3s    = mean(area3);
desvStd_area3s = std(area3);
fprintf('promedio(area3): %12.6f,    desvStd(area3s): %12.6f\n', ...
         prom_area3s, desvStd_area3s)
%
% ================= Fin de tst ====================
%
