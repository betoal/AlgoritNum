M = 100;
N = 50;
K = 200;
mediaTeorica = pi/4;
sdTeorica    = sqrt((pi/4)*(1-pi/4));
A = zeros(M,N);
for n = 1:N  %% cantidad de columnas
    k = K*n; %% datos de cada muestreo por ensayo de columna
    for m = 1:M
        x = rand(k,1);
        y = rand(k,1);
        A(m,n) = sum(x.*x + y.*y <=1)/k;
    end
end

%% plot(A','.') %% Se hace la gráfica transpuesta
%% hold on
%% plot((1:N),mediaTeorica*ones(1,N)) %% Para graficar la media teórica
%% mA = mean(A);
%% sdA = std(A);
%% sdTA = (sdTeorica)./sqrt(K*(1:N)); %% Para sacar la desviacion teórica de A
%% plot((1:N),mA,'o') %% Para la media experimental
%% plot((1:N),mediaTeorica+sdA,'o') %% Para la desviacion experimental
%% plot((1:N),mediaTeorica-sdA,'o')
%% plot((1:N),mA+sdA) %% Para ver la tendencia de lo experimental
%% plot((1:N),mA-sdA)
%% plot((1:N),mediaTeorica+sdTA) %% Para ver la tendencia 
%% plot((1:N),mediaTeorica-sdTA)