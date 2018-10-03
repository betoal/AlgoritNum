%% Polinomios de Chebyshev (interpolaci�n)

% Se obtienen de la siguiente expresi�n
% Tn(x) = cos(n arccos(x)); x in [-1,1]

% Para n=0
% T0(x) = cos(0*arccos(x)) = 1

% Para n=1
% T1(x) = cos(arccos(x)) = x

% F�rmula de Recurrencia (m<n)
% Tn+m(x) = cos((n+m)arccos(x)); cos(a+b)=cos(a)cos(b)-sin(a)sin(b)
% Tn+m(x) = cos(n*arccos(x))cos(m*arccos(x))-sin(n*arccos(x))sin(m*arccos(x))
% Tn-m(x) = cos(n*arccos(x))cos(-m*arccos(x))-sin(n*arccos(x))sin(-m*arccos(x))

% Tn+m(x)+Tn-m(x) = 2cos(n*arccos(x))cos(m*arccos(x))
% Para m=1
% Tn+1(x)+Tn-1(x) = 2Tn(x)T1(x)
% Tn+1(x) = 2*x*Tn(x) - Tn-1(x) <-- F�rmula de Recurrencia que va dando los
% polinomios

% Para obtener el polinomio de "m�s precisi�n" debemos evaluar Tn(x) en
% ciertos puntos conocidos como "nodos(ra�ces de Tn(x))"

% Los de grado impar tienen siempre al 0 como ra�z
% Los de grado par tienen un offset

% En general se requiere xk tal que: Tn(xk) = 0; k=0,...,n-1
% cos((2*(n-1)*pi)/2n); k=0,...,n-1 <-- Ra�ces

% Lagrange := Una funci�n que pase por los valores que te dan (1 en xi; 0
% en xj!=i)
% l0(x) = (x-x1)(x-x2)...(x-xn)/(x0-x1)(x0-x2)...(x0-xn)