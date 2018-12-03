%=========== Programa Resortes_n_friccion.m ===============
%
% Simula el desplazamiento de los centros X1,X2,...,Xn (en [metros]) de 
% n masas M1,M2,...,Mn (en [Kg]) unidas por resortes.
%
% Los resortes tienen constantes K1,K2,...,Kn,Kn+1 en [Nw/metro].
%
% El sistema tiene una configuración en serie
%
%    Soporte Fijo Izquierdo-K1-M1-K2-M2-K3-...-KN-Mn-Kn+1-Soporte Fijo Derecho.
%
% Las ecusciones diferenciales del sistema son:
%
% d2X1/dt2 = -((K1+K2)/M1) * X1 +      (K2/M1) * X2
% d2X2/dt2 =       (K2/M2) * X1 - ((K2+K3)/M2) * X2 +     (K3/M2)  * X3
% D2X3/dt2 =                           (K3/M3) * X2 - ((K3+K4)/M3) * X3 + (K4/M4)*X4
% ...
% D2XN-1/dt2 =                         (Kn-1/Mn-1) * Xn-2 - ((Kn-1+Kn)/Mn-1)* Xn-1 + (Kn/Mn-1)*Xn
% d2XN/dt2 =                           (Kn/Mn) * Xn-1 - ((Kn+Kn+1)/Mn) * Xn
%
% Las condiciones iniciales son X1(0)= X10,X2(0) = X20,..., Xn(0) = Xn0,
%                              (dX1/dt)(0) = (dX2/dt)(0) = ... 0 (dXN/dt)(0) = 0
% T ... Tiempo que dura la simulación (en [seg]).
% N ... Cantidad de pasos.
% deltaT ... tamaño del paso (en[seg]).
%
% Valores de las constantes de los resortes:
%
  n = 6;
  K = 0.01*ones(n+1,1);
%
% Coeficiente de fricción alfa en Nw/(metros/seg)
%
  alfa = 0.25;
%
% Masas:
%
  M = 0.05 * ones(n,1);
%
% La representación de las variables en el vector es 
%
%   D[X1;X2;...;Xn;U1;U2;...;Un] = Md * [X1;X2;...;Xn;U1;U2;...;Un]
%
% se configura Md de esta manera para poder escribir el modelo
% de manera más simple.
%
  Md = zeros(2*n,2*n);
  Md(1:n,n+1:2*n) = eye(n);
% D(Un+1) = d2X1/dt2 
  Md(n+1,1:2) = [-(K(1) + K(2))/M(1), K(2)/M(1)];
%
% Renglones intermedios
%
  for r = 2:n-1,
    Md(n+r,r-1:r+1) = [ K(r)/M(r), - (K(r)+K(r+1))/M(r), K(r+1)/M(r)]; 
  end 
% D(U2n) = D2Xn/dt2
  Md(2*n,n-1:n) = [K(n)/M(n), -(K(n)+K(n+1))/M(n)];
%
%  Fricción
%
  Md(n+1:2*n,n+1:2*n) = - eye(n) * alfa;
%
  T      = 40;
  N      = 1000;
  deltaT = T / N;
%
% Condiciones iniciales:
%  
  S0 = [-0.025;0.025;zeros(n-2,1)];
%
% La solución se guarda en el vector S de 6xN
%  
  S = zeros(2*n,N);
%
% Guardando las condiciones iniciales en la solución
%
  S(1:n,1) = S0;
%
% Iterando para obtener las posiciones de las masas en deltaT, 2deltaT, 3deltaT, ...
%
  for k = 2:N, 
    S(:,k) = S(:,k-1) + Md * S(:,k-1) * deltaT; 
  end
%
% Graficando la solución obtenida 
%
  t = (0:N-1) * deltaT;
  hold off
  plot(t,S(1,:),'r')
  hold on
  for r = 2:n,
      plot(t,S(r,:))
  end
  
  valprop = eig(Md);
  a = real(valprop(1));
  amp = max(abs(S0));
  plot(t, amp*exp(a*t))
  plot(t,-amp*exp(a*t))
%
% Fin del código
%  