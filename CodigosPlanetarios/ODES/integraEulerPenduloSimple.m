function u = integraEulerPenduloSimple(w2,u,deltaT)
  u =  u + [u(2); - w2 * sin(u(1))] * deltaT;
end
