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
figs{6} = RectanguloCanonico([0;0],4,2);
clf
hold on
figs{1}.dibuja();
figs{2}.dibuja();
figs{3}.dibuja();
figs{4}.dibuja();
figs{5}.dibuja();
figs{6}.dibuja();
%pause(1)
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
 % == Para el número de puntos necesarios para obtener la confianza
error = 0.05;
confianza = 0.9;
i = 1;
j = 1;
while i <= N % el primer número que tenga una proporción menor al error
    if std(A(:,i))/mean(A(:,i)) < error && j == 1
        j = i;
        i = N;
    end
    i = i+1;
end

mA = mean(A); % el valor obtenido del área de la intersección
sA = std(A);

zVal = norminv(confianza + (1 - confianza) /2)
cotaInferior = mA(j) - sA(j) * zVal / sqrt(M)
cotaSuperior = mA(j) + sA(j) * zVal / sqrt(M)
numPuntos = j * K

clf
hold on
plot(A','.')

plot((1:N),mA,'o')
plot((1:N),mA + sA,'+')
plot((1:N),mA - sA,'+')

D=zeros(1,N);
for n=1:N
    D(n)=sum((mA(n) - sA(n)<=A(:,n)).*(A(:,n)<=mA(n)+sA(n)));
end
porcEnsayos = D/M;