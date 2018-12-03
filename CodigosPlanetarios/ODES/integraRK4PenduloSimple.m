function u = integraRK4PenduloSimple(w2,u,deltaT)
  dts2 = 0.5 * deltaT;
  k1 = [u(2);                - w2 * sin(u(1))];
  k2 = [u(2) + dts2   * k1(2); - w2 * sin( u(1) + dts2   * k1(1))];
  k3 = [u(2) + dts2   * k2(2); - w2 * sin( u(1) + dts2   * k2(1))];
  k4 = [u(2) + deltaT * k3(2); - w2 * sin( u(1) + deltaT * k3(1))];
  u =  u + ( k1 + 2.0 * k2 + 2.0 * k3 + k4 ) * deltaT / 6.0;
end
