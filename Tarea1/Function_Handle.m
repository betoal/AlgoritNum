%% Creaci�n de funci�n handle
%  Se crea como un objeto y puede tener de argumento un vector, escalar,
%  etc.

%  Funci� handle trabaja como apuntador a otra funci�n.

sqr = @(n) n.^2;
sqr(20)
sqr([1,2,3,4])
