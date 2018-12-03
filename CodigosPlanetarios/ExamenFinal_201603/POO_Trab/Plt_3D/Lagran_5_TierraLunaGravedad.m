G = 6.67408E-11; %%  Nw m^2 / Kg^2
T = 4*28; % simular T días
%
% Masa de la Tierra, la Luna y los móviles lagrangianos
%
m = [5.9736E+24,7.349E+22,100.0E+3*ones(1,5)];
%
% dL es la distancia Tierra - Luna
% wL es la velocidad angular de la luna para tal distancia (órbita circular)
%
dL = 3.832097031205720e+08; % en metros
wL  = 2.0 * pi /(27.321661*86400); %% rad/seg
%
% cada móvil en una columna
%
% dm son las posiciones de los 5 móviles lagrangianos
%  
% dm = 6.442580581092797e+07;   % Posterior a la Luna ( dL + dm )
% dm = - 5.790539998830593e+07; % Anterior a la Luna  ( dL - abs(dm) )
% dm = - 7.668119951105596e+08;   % Opuesto a la Luna
%
dm = zeros(3,5);
theta = pi/3; % Para los langrangianos 4 y 5
%
dm(:,1) = [ dL + 6.442580581092797e+07;0;0];
dm(:,2) = [ dL - 5.790539998830593e+07;0;0];
dm(:,3) = [ dL - 7.668119951105596e+08;0;0];
dm(:,4) = dL * [cos(theta); sin(theta);0];
dm(:,5) = dL * [cos(theta);-sin(theta);0];
%
% Vector de posiciones iniciales
%
r0 = [[0;0;0],[dL;0;0],dm(:,:)];
%
% velocidades de los móviles
%
vm = zeros(3,5);
vm(:,1) = wL * [0;dm(1,1);0];
vm(:,2) = wL * [0;dm(1,2);0];
vm(:,3) = wL * [0;dm(1,3);0];
vm(:,4) = wL * dL * [-sin(theta);cos(theta);0];
vm(:,5) = wL * dL * [ sin(theta);cos(theta);0];

vLy = wL * dL; % velocidad de la Luna
v0 = [[0;0;0],[0;vLy;0],vm(:,:)];

deltaT=1*60;
Nk = T*24*60*60/deltaT; % un ciclo de la luna
% Nk = Nk / 2;
pos=zeros(Nk,3*7);
for k = 1:7,pos(1,3*(k-1)+1:3*k)= r0(:,k)';end
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
%
% Iteraciones
%
a   = zeros(3,7);
%
for t=2:Nk,
   % disp(sprintf('t: %5d',t))
%
  Fza = zeros(3,7);
  for m_r = 1:6
    for m_s = m_r+1:7
      dr_rs  = r(:,m_s) - r(:,m_r);
      dr2_rs = dr_rs'*dr_rs;
      u_rs   = dr_rs/sqrt(dr2_rs);
      Fza_rs = G * m(m_r) * m(m_s) / dr2_rs * u_rs;
      Fza(:,m_r) = Fza(:,m_r) + Fza_rs;
      Fza(:,m_s) = Fza(:,m_s) - Fza_rs;
    end    
  end  
  %
  %  Tiera fija
  %
  % Fza(:,1) = [0;0;0];
  %
  % Aceleración de cada móvil
  %
  a = Fza ./ [m;m;m]; 
  %
  % Velocidad
  %
  v = v + a * deltaT;
  %
  % Posición
  %
  r = r + v * deltaT;
  %
  % Guardo la posición
  %
  for k = 0:6
    pos(t,3*k+1:3*(k+1)) = r(:,k+1)';
  end
  %
  %
  %
  %S = sprintf('pos: %12.2f,%12.2f  vel: %12.2f,%12.2f Fza: %12.2f,%12.2f Acel: %12.2f,%12.2f', ...
  %            r(1,2),r(2,2),v(1,2),v(2,2),-F(1,1),-F(2,1),a(1,2),a(2,2));
  %disp(S);
                
end
%
% Pintando los móviles
%
  p(1,:) = ['or'];
  p(2,:) = ['-b'];
  p(3,:) = ['-w'];
  p(4,:) = ['-w'];
  p(5,:) = ['-w'];
  p(6,:) = ['-k'];
  p(7,:) = ['-r'];
%
hold off
for k = 1:7
  if k == 1
    hold off
  else
    hold on  
  end  
  plot3(pos(:,3*k-2),pos(:,3*k-1),pos(:,3*k),p(k,:))  
end    
%plot3(pos(:,1),pos(:,2),pos(:,3),'+',pos(:,4),pos(:,5),pos(:,6)'.',pos(:,7),pos(:,8),pos(:,9)'.')
