% tstFiguraCompuesta
figs    = {};
%figs{1} = RectanguloCanonico([0;0],3,3);
figs{1} = Gauss(6,2);
figs{2} = Circulo([3;0.25],0.5); 
%figs{3} = Triangulo([0;1],[-0.5*sqrt(3);-0.5],[0.5*sqrt(3);-0.5]);
figs{3} = Gauss(2,1);
inter_cta = [1,1,0,1,1,0,0,0];
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
%AreaTeorica = 3 * sqrt(3) / 4; % 36 -  rt(K*(1:N));
mA = mean(A);
sA = std(A);
hold off
hold on
plot(A','.')
plot((1:N),ones(1,N)*AreaTeorica)
plot((1:N),mA,'o')
plot((1:N),mA + sA,'+')
plot((1:N),mA - sA,'+')
plot((1:N),AreaTeorica + stdAteorica)
plot((1:N),AreaTeorica - stdAteorica)

D=zeros(1,N);
for n=1:N
    D(n)=sum((AreaTeorica-stdAteorica(n)<=A(:,n)).*(A(:,n)<=AreaTeorica+stdAteorica(n)));
end
porcEnsayos = D/M;