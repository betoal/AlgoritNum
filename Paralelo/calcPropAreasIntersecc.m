function p = calcPropAreasIntersecc(Xc,Yc,Rc,N_puntos,M_veces)
  p = zeros(max(size(Rc)),M_veces);
  for vez = 1:M_veces
    q = zeros(max(size(Rc)),1); 
    r = Rc(1) .* sqrt(rand(N_puntos,1));
    t = 2*pi*rand(N_puntos,1);
    x = r .* cos(t);
    y = r .* sin(t);
    for k = 1:N_puntos
      d=sum(( x(k) - Xc ).^2 + ( y(k) - Yc ).^2 <= Rc.^2 );
      q(d) = q(d) + 1;
    end
    p(:,vez) = q;
  end
  p = p ./ N_puntos;
  p = mean(p');
end
