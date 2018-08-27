
function prop = propAreasIntersecc
%
%% Prueba para el cálculo de la áreas de las interseciones de círculos
%%
  Xc = [ 0.0;  0.0;  0.0];
  Yc = [ 0.0;  1.0; -1.0];
  Rc = [ 1.0;  1.0;  1.0];
  
  veces  = 150;
  n_ptos = 100 * 1000;
  
  prop = calcPropAreasIntersecc(Xc,Yc,Rc,n_ptos,veces);
end
  