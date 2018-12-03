function [posT1,velT1,posT2,velT2] = calcTroyanos_XY(m1,m2)
%
% [posT1,velT1,posT2,velT2] = calcTroyanos_XY(m1,m2)
%
% Cálculo de las posiciones y velocidades de los lagrangianos de 60 grados
% de la órbita de m2 alrededor de m1.
% m1 y m2 son objetos del tipo ClsMovil_2D8
%
%
  deltaPos = m2.posicion - m1.posicion;
  dist = sqrt( deltaPos * deltaPos' );
  alfa     = atan2(deltaPos(2),deltaPos(1));
  beta_1 =   2*pi/6 + alfa;
  beta_2 = - 2*pi/6 + alfa;
  
  posT1 = m1.posicion + dist * [cos(beta_1),sin(beta_1),0];
  posT2 = m1.posicion + dist * [cos(beta_2),sin(beta_2),0];

  deltaVel = m2.velocidad - m1.velocidad;
  velTan = sqrt( deltaVel * deltaVel' );
  
  gamma_1 = 5*pi/6 + alfa;
  gamma_2 = gamma_1 - 2*pi/3;
  
  velT1 = m1.velocidad + velTan*[cos(gamma_1),sin(gamma_1),0];
  velT2 = m1.velocidad + velTan*[cos(gamma_2),sin(gamma_2),0];

end