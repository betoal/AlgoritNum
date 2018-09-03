function [areas,tamRect] = calcInterseccAreasFiguras_01(figs,N)
  nf = size(figs,2);
  arr_xMax = zeros(1,nf);
  arr_xMin = zeros(1,nf);
  arr_yMax = zeros(1,nf);
  arr_yMin = zeros(1,nf);

  for k = 1:nf
    tam = figs{k}.valoresExtremos();
    arr_xMin(k) = tam(1,1);
    arr_yMin(k) = tam(2,1);
    arr_xMax(k) = tam(1,2);
    arr_yMax(k) = tam(2,2);
  end
  xmin = min(arr_xMin);
  xmax = max(arr_xMax);
  ymin = min(arr_yMin);
  ymax = max(arr_yMax);

  dx = xmax - xmin;
  dy = ymax - ymin;

  p = [xmin + dx*rand(1,N);ymin + dy*rand(1,N)]; 

  c = zeros(1,nf);
  dos_a_la_nf = 2^nf;
  vd = cumprod([1;2*ones(nf-1,1)]);
  d = zeros(1,dos_a_la_nf);
  for t = 1:N
    for k = 1:nf
      c(k) = figs{k}.contiene(p(:,t));
    end
    w = c*vd;
    if w == 0, w = dos_a_la_nf; end 
    d(w) = d(w) + 1;
  end
  tamRect = dx * dy;
  areas = d * tamRect / N;
end