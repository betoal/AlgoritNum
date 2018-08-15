%% Para ver una distribución Normal

K=50000;
Z = zeros(100,1);
for r=1:100, Z(r) = mean(randn(K,1)); end
plot(Z,'+')
sdTZ = std(Z)
sdTeorica = 1/sqrt(K) %% Esto es la estimación de la dispersión para tener mayor precisión de la media
hist(Z)