function [ interRaiz ] = cambioSigno( f, xMin, xMax, numInter )
%   cambioSigno busca intervalos donde hay un cambio de signo de la funcion
%   f dentro del intervalo definido de [xMin xMax]. Dentro de este
%   intervalo crea numInter subintervalos si este argumento es dado, en
%   caso contrario usa un valor por defecto de numInter=10
%   Recibe la funcion simbolica f, los valores del intervalo xMin y xMax y
%   opcionalmente el numero de subintervalo a usar.

    if nargin()<3 
        error('Se necesita al menos 3 argumentos de entrada');
    end
    if nargin()<4 
        numInter=10;
    end
    %genero x 
    x=linspace(xMin,xMax,numInter);
    %evaluo la funcion en x
    fx=f(x);
    %contador para los cambios de signo
    numCambios=0;
    %defino el vector de intervalos como nulo
    interRaiz=[];
    for i=1:length(x)-1
        if fx(i)*fx(i+1)<0 %hay cambio de signo 
            numCambios=numCambios+1;
            interRaiz(numCambios,1)=x(i);
            interRaiz(numCambios,2)=x(i+1);
        end    
    end    
    if isempty(interRaiz)
        disp('No se encontraron cambios de signo de la funcion en ese intervalo.')
        disp('Cambia el intervalo o incrementa el numero de intervalos.')
    else
        fprintf('Se encontraron %d intervalos donde hubo cambio de signo.\n',numCambios);
    end    
end

