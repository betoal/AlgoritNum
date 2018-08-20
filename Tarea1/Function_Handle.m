%% Creación de función handle
%  Se crea como un objeto y puede tener de argumento un vector, escalar,
%  etc.

%  Funció handle trabaja como apuntador a otra función.

sqr = @(n) n.^2;
sqr(20)
sqr([1,2,3,4])
