syms t A
format
cMax = 0.05;
cMin = 0.005;
B = 1 / 5;
c = A * t * exp(-t * B); % Before finding solution of A
tMax = rootNewton(diff(c), 0, 1)
A = cMax / (tMax * exp(-tMax * B)); % After findinf solution of A
c = A * t * exp(-t * B);
t2 = rootNewton2(c - cMin, tMax + 0.1, 1);
min = mod(t2, 1);
hrs = t2 - min
min = min * 60 - mod(min * 60, 1)
c = matlabFunction(c);
x = linspace(0,40);
plot(x, c(x))
hold on
plot(x, ones(1, 100) * cMin)
hold off