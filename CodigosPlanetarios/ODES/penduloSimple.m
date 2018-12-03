%Programa penduloSimple
%
g = 9.81; % m / s^2
l = 1.0;  % m
w2 = g / l; % rad / s^2
theta0 =  pi/10.0;
thetap0 = 0.0;
u0 = [theta0;thetap0];
n = 2000;
T = 5.0; % seg
deltaT = T / n;
t = (0:deltaT:5.0);
U = zeros(2,n+1);
U(:,1) = u0;
for k = 2:size(U,2),
   U(:,k) = integraEulerPenduloSimple(w2,U(:,k-1),deltaT);
   %U(:,k) = integraRK4PenduloSimple(w2,U(:,k-1),deltaT);
end
ET = 0.5 * l^2 * U(2,:).^2 + g * l * (1 - cos(U(1,:)));
deltaEt = max(ET) - min(ET)
plot(t,U(1,:))
pause(2)
plot(t,ET)
