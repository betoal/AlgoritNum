function [areas,tamRect] = calcInterseccAreasFiguras_01(figs,N)
  nf = size(figs,2);
  arr_xMax = zeros(1,nf);
  arr_xMin = zeros(1,nf);
  arr_yMax = zeros(1,nf);
  arr_yMin = zeros(1,nf);

  % Sacas valores extremos y se guardan como vectores
  for k = 1:nf
    tam = figs{k}.valoresExtremos();
    arr_xMin(k) = tam(1,1);
    arr_yMin(k) = tam(2,1);
    arr_xMax(k) = tam(1,2);
    arr_yMax(k) = tam(2,2);
  end
  % Dimensiones de la caja
  xmin = min(arr_xMin);
  xmax = max(arr_xMax);
  ymin = min(arr_yMin);
  ymax = max(arr_yMax);

  dx = xmax - xmin;
  dy = ymax - ymin;

  % Se generan los puntos de x,y en una matriz
  p = [xmin + dx*rand(1,N);ymin + dy*rand(1,N)]; 

  % Hay 2^n posibles intersecciones en las figuras.
  % Se van prendiendo los bits dependiendo la figura donde cae el punto
  c = zeros(1,nf);
  dos_a_la_nf = 2^nf;
  vd = cumprod([1;2*ones(nf-1,1)]); % Sabe donde cayeron los puntos
  d = zeros(1,dos_a_la_nf);
  for t = 1:N % Ciclo para cada punto
    for k = 1:nf % Ciclo para cada figura.
      c(k) = figs{k}.contiene(p(:,t)); % Se checa si el punto cae dentro de la figura.
    end
    w = c*vd; % Se hace producto punto del valor de los puntos prendidos.
    if w == 0, w = dos_a_la_nf; end % Si no hay intersección, se manda al último.
    d(w) = d(w) + 1; % En este vector se guarda lo que sucedió en todas las figuras.
  end
  tamRect = dx * dy;
  areas = d * tamRect / N;
end