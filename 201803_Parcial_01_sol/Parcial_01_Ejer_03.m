% tstFiguraCompuesta
figs    = {};
figs{1} = FiguraFuncion(@(x)exp(-(((x-2)./0.75).^2)) + exp(-(((x-4)./0.75).^2)),0.0,6.0,2.0);
figs{2} = ElipseCanonica([3;0.5],3,0.5);
clf
hold on
figs{1}.dibuja();
figs{2}.dibuja();
%return
pause(1)
inter_cta = zeros(1,4);
inter_cta(3) = 1;
fc = FiguraCompuesta(figs,inter_cta);
vxtrms = fc.valoresExtremos();
dx = vxtrms(1,2) - vxtrms(1,1);
dy = vxtrms(2,2) - vxtrms(2,1);
dxdy = dx * dy;
M = 100;
N = 50;
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

D=zeros(1,N);
for n=1:N
    D(n)=sum((mA(n)-sA(n)<=A(:,n)).*(A(:,n)<=mA(n)+sA(n)));
end
porcEnsayos = D/M;
