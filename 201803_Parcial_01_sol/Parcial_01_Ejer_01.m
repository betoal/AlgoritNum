% tstFiguraCompuesta
figs    = {};
figs{1} = Circulo([0;0],2);
tam_trian = 5;
figs{2} = Triangulo(tam_trian * [0;1], ...
                    tam_trian * [-0.5*sqrt(3);-0.5], ...
                    tam_trian * [0.5*sqrt(3);-0.5]);
figs{3} = Circulo( tam_trian * [0;1],1);
figs{4} = Circulo( tam_trian * [-0.5*sqrt(3);-0.5],1);
figs{5} = Circulo( tam_trian * [ 0.5*sqrt(3);-0.5],1);
figs{6} = RectanguloCanonico([0;0],4,2)
clf
hold on
figs{1}.dibuja();
figs{2}.dibuja();
figs{3}.dibuja();
figs{4}.dibuja();
figs{5}.dibuja();
figs{6}.dibuja();
pause(1)
%return
inter_cta = zeros(1,64);
inter_cta(34) = 1;

fc = FiguraCompuesta(figs,inter_cta);
vxtrms = fc.valoresExtremos();
dx = vxtrms(1,2) - vxtrms(1,1);
dy = vxtrms(2,2) - vxtrms(2,1);
dxdy = dx * dy;
M = 50;
N = 40;
K = 100;
A = zeros(M,N);
tic
parfor n = 1:N  % para cada columna
    k = K * n;
    for m = 1:M
      puntos = [vxtrms(1,1) + dx * rand(1,k); vxtrms(2,1) + dy * rand(1,k)];
      cuenta = 0;
      for w = 1:k
       cuenta = cuenta + fc.contiene(puntos(:,w));   
      end
      proporcion = cuenta / k;
      A(m,n) = dxdy * proporcion;
    end   
end
toc

mA = mean(A);
sA = std(A);
clf
hold on
plot(A','.')

plot((1:N),mA,'o')
plot((1:N),mA + sA,'+')
plot((1:N),mA - sA,'+')

mAp = mean(mA);
D=zeros(1,N);
for n=1:N
    D(n)=sum((mAp - 1.64*sA(n)<=A(:,n)).*(A(:,n)<=mAp+1.64*sA(n)));
end
porcEnsayos = D/M;
%
%  Para el ejercicio 2 calculemos primeramente el valor teórico de la
%  desviación estandar de cada una de las columnas ( M medias de K*j puntos
%  cada una)
%
p = mAp/dxdy;
sAt = dxdy * sqrt(p*(1-p)./(K*(1:N)));
%
% Agregamos las líneas superior e inferior de la desvStd al dibujo
%
plot((1:N),mAp + sAt)
plot((1:N),mAp - sAt)
%
%  y calculamos el valor de la jmin tal que se cumplan las condiciones de
%  error solicitadas: menos del 10% de variación relativa en el 905 de los casos
%  Es decir:
%   Para 90% de los casos alrededor de la media se requiere un intervalo de
%   [ -1.64 * sAt(j) + mAp, mAp + 1.64 * sAt(j)]
% y
%   |-1.64 * sAt(j) + mAp, mAp + 1.64 * sAt(j)| <= 0.10 * mAp
%  resultando
%   2 * 1.64 * (dxdy/mAp) * sqrt(p*(1-p)/(K*jmin)) <= 0.1
% despejando jmin
%               jmin >= enteroSup((2*1.64/0.1*(dxdy/mAp))^2 * p*(1-p)/K)
%
  jmin = ceil((2*1.64/0.1 *(dxdy/mAp))^2 * p*(1-p)/K)
% 2*1.64*sA'./mAp <-- con lo que estimas el valor (error relativo)