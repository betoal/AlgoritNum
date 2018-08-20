%% Cálculo del área de la intersección de 2 círculos
%% Por RGGH
%% Para ANC 201803
%% 18 de agosto de 2018
%%
%% Se realizan N tandas, cada una de K * número_de_tanda puntos
%% Cada tanda tiene M ensayos con la misma cantidad de puntos
%% Los resultados del ensayo i de la tanda j se almacenan en la matriz A(i,j)
%% K =  50  %% cantidad base del numero de puntos de los ensayos de cada tanda
%% M = 100  %% número de ensayos o simulaciones de cada tanda con la misma cantidad de puntos
%% N =  50  %% cantidad de tandas de ensayos cambiando la cantidad de puntos
%%
%%
%% Se definen los centros y radios de los dos círculos
%%
tic
R = 2.0;
C = [ -0.5*R,0.5*R; 0.0,0.0;R,R]; %% C = [X0,X1; Y0,Y1;R0,R1]
%
K = 100;
M = 500;
N = 200;
A=zeros(M,N);
%%
%% Rectángulo de trabajo
%%
xmin = min( C(1,:) - C(3,:));
xmax = max( C(1,:) + C(3,:));
ymin = min( C(2,:) - C(3,:));
ymax = max( C(2,:) + C(3,:));
dx = xmax - xmin;
dy = ymax - ymin;
dxdy = dx * dy;
R12 = C(3,1)^2;
R22 = C(3,2)^2;
%
%  ciclo de tandas
%
%  parfor (paralel for)
parfor n = 1:N
    k = K * n; 
    for m = 1:M
       x = xmin + dx * rand(1,k);
       y = ymin + dy * rand(1,k);
       c1 = ( x - C(1,1) ).^ 2 + ( y - C(2,1) ) .^2 <= R12;
       c2 = ( x - C(1,2) ).^ 2 + ( y - C(2,2) ) .^2 <= R22;
       A(m,n) = sum( c1 .* c2 ) * dxdy / k;
    end
end 
toc
AreaTeorica = 2*R^2*(pi/3-sqrt(3)/4);
p = AreaTeorica / dxdy;
stdAteorica=dxdy*sqrt(p*(1-p))./sqrt(K*(1:N));
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

%% Contar cuántos puntos de las A's de cada corte caen para cada columna
D=zeros(1,N);
for n=1:N
    D(n)=sum((AreaTeorica-stdAteorica(n)<=A(:,n)).*(A(:,n)<=AreaTeorica+stdAteorica(n)));
end
porcEnsayos = D/M;
