M = 100;
N = 50;
K = 200;
Radio1 = 2;
Radio2 = 2;
cx1 = 1; cy1 = 0;
cx2 = -1; cy2 = 0;
A = zeros(M,N);
B = zeros(M,N);
for n = 1:N
	k = K*N;
	for m = 1:M
		x = rand(k,1);
		y = rand(k,1);
		A(m,n) = ((x-cx1).*(x-cx1) + (y-cy1).*(y-cy1) <=1)/k;
		
