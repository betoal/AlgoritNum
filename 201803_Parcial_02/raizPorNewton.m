function raiz = raizPorNewton(hf,x,eps,maxVeces)
%
%  raiz = raizPorNewton(hf,x,eps,maxVeces)
%
% hf       ... handler de la función de la que se desea la raíz
% x        ... valor inicial para las iteraciones
% eps      ... las iteraciones se detienen cuando abs( x(n) - x(n-1)) < eps o
% maxVeces ... el número de iteracines supera maxVeces
%
% Cálculo de la raíz de una funcion f:R->R
% Se deben cumplir las condiciones de Fourier para 
% garantizar la convergencia del método.
% Por CU: 8472, Rafael G. Gamboa Hirales
% 4 de agosto de 2016
% Para ANC 201603
%
  sf  = sym(hf);
  sfp = diff(sf);
  hfp = matlabFunction(sfp);
  intervalo = 2.0 * eps;
  k = 1;
  while intervalo > eps & k < maxVeces
    x1 = x - hf(x)/hfp(x);
    intervalo = abs( x1 - x );
    x = x1;
    k = k + 1;
    sprintf('k:%d ... %f \n',k,x)
  end
  raiz = x;
end
