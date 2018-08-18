M = 100;
N = 50;
K = 200;
R1 = 2; R2 = 2;
c1 = [1 0]; c2 = [-1 0];
A = zeros(M,N);
B = zeros(M,N);
Ans = zeros(M,N);
for n = 1:N		%%Cantidad de columnas
	k = K*N;	%%Cantidad de renglones
	for m = 1:M
		x = rand(k,1);
		y = rand(k,1);
		A(m,n) = ((x-c1(1)).*(x-c1(1)) + (y-c1(2)).*(y-c1(2)) <=(R1.*R1))/k;
		B(m,n) = ((x-c2(1)).*(x-c2(1)) = (y-c2(2)).*(y-c2(2)) <=(R2.*R2))/k;
		Ans(m,n) = sum(A(m,n).*B(m,n));
	end
end

pos1 = [c1-R1, 2*R1 2*R1];
pos2 = [c2-R2, 2*R2 2*R2];

hold on
plot(pos1)
plot(pos2)
plot(Ans','.')
hold off
