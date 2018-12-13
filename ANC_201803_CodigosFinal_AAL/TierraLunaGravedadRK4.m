G = 6.67408E-11; %%  m3 kg-1 s-2 
m=[5.9736E+24,7.349E+22, 100E+3];
%
% cada móvil en una columna
%
% r0=[[0;0;0],[6378000.0+108000.0;0;0]];
r0=[[0;0;0],[3.832557907001450e+08;0;0], [d*cos(theta);d*sin(theta);0]];
v0=[[0;0;0],[0;1.019927755507821e+03;0], [vmx; vmy; 0]];
r=[[r0;v0]];

theta = pi/3;
d = 3.832097031205720e+08;
ws  = 2.0 * pi /(27.321661*86400);
vmx = - ws * d * sin(theta);
vmy =   ws * d * cos(theta);

deltaT=1*60;  %% cada minuto
%Nk=1+2*60*60/deltaT; 
Nk = 60*24*60*60/deltaT; % un ciclo de la luna
pos=zeros(Nk+1,9);
pos(1,:)=[r0(:,1)',r0(:,2)',r0(:,3)'];
%
%  para crear el espacio para el vector unitario en la dirección de la
%  fuerza, la fuerza y la aceleración (vectoriales)
%
u = r0;
F = r0;
a = r0;
dr= r0;
%
% Variables para iterar
%
r = r0;
v = v0;
R = [v0;r0]; % velocidades y posiciones
GMM = calcGMM(m);
for t=1:Nk,
  q = R;
  fzas = calcFzas(GMM,q(4:6,:));  
  a = calcAcel(fzas,m);  
  K1 = [a;R(1:3,:)+a*deltaT];
  q = R + K1 * deltaT/2;
  fzas = calcFzas(GMM,q(4:6,:));  
  a = calcAcel(fzas,m); 
  K2 = [a;K1(1:3,:)+ a * deltaT];
  p = R + K2 * deltaT/2;
  fzas = calcFzas(GMM,q(4:6,:));  
  a = calcAcel(fzas,m); 
  K3 = [a;K2(1:3,:) + a * deltaT/2];
  q = R + K2 * deltaT/2;
  fzas = calcFzas(GMM,q(4:6,:));  
  a = calcAcel(fzas,m); 
  K4 = [a;K3(1:3,:) + a * deltaT];
  %
  % RUNGE-KUTTA
  %
  %R = R + ( K1 + 2*K2 + 2*K3 + K4) * deltaT / 6.0;
  %
  %  EULER
    R = R + K1 * deltaT; 
  %
  % Guardo la posición
  %
  pos(t+1,:) = [R(4:6,1)',R(4:6,2)',R(4:6,3)'];  %[r(:,1)',r(:,2)'];
  %
  %
  %
  %S = sprintf('pos: %12.2f,%12.2f  vel: %12.2f,%12.2f Fza: %12.2f,%12.2f Acel: %12.2f,%12.2f', ...
  %            r(1,2),r(2,2),v(1,2),v(2,2),-F(1,1),-F(2,1),a(1,2),a(2,2));
  %disp(S);
                
end

plot3(pos(:,1),pos(:,2),pos(:,3)'.','g',pos(:,4),pos(:,5),pos(:,6)'.','b',pos(:,7),pos(:,8),pos(:,9)'.','r')
