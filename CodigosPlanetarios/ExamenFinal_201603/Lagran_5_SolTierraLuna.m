%
% Constantes a considerar
%
G    = 6.67408E-11;    %% Nw m^2 / Kg^2
MS   = 1.9891E+30;     %% Maaa del Sol en Kg
MT   = 5.9736E+24;     %% Masa de la Tierra en Kg
TaoT = 365.25 * 86400; %% Período orbital de la Tierra respecto al Sol en segundos
ML   = 7.349E+22;      %% masa de la Luna en Kg
TaoL = 27.321661*86400 %% período orbital de la Luna respecto a la Tierra en segundos
%
% Sol originalmente quieto.
%
p0_Sol = [0;0;0];
v0_Sol = [0;0;0];
%
% Cálculo del radio orbital de la Tierra
%
wT = 2*pi / TaoT; %% rad / seg
dT = ( G * MS / ( wT^2 ) ) ^(1/3);
vT = wT * dT;
format('long')
fprintf('dT: %+12.9e  VT: %+12.9e\n',dT,vT)
p0_Tierra = [dT;0;0];
v0_Tierra = [0;vT;0];
%
% Cálculo del radio orbital de la Luna respecto a la Tierra
%
wL = 2 * pi / TaoL;
dL = ( G * MT / ( wL^2 ) ) ^(1/3);
vL = wL * dL;
%
% Posición y velocidad de la Luna
%
p0_Luna = p0_Tierra + [dL;0;0];
v0_Luna = v0_Tierra + [0; dL * wL; 0]; 
%
% L1: Posterior a la Tierra
% dm es la distancia de móvil a la Tierra
%
fL1 = @(dm) (G*MS / (dT+dm)^2 + G * MT / dm^2 - (dT+dm)*wT^2);
%
dmL1 = raizPorNewton(fL1,dT,1,1000);
vtL1   = wT * ( dT + dmL1 );
fprintf('dmL1: %+12.9e      vtL1: %+12.9e\n',dmL1,vtL1)
%
p0_L1 = [dT + dmL1;0;0];
v0_L1 = [0;vtL1;0];
%
% L2: Entre la Tierra y el Sol
% dm es la distancia del móvil al Sol
%
fL2 = @(dm) (G*MS / dm^2 - G * MT / (dT- dm)^2 - dm*wT^2);
%
dmL2 = raizPorNewton(fL2,0.5*dT,1,1000);
vtL2   = wT * dmL2;
fprintf('dmL2: %+12.9e      vtL2: %+12.9e\n',dmL2,vtL2)
%
p0_L2 = [dmL2;0;0];
v0_L2 = [0;vtL2;0];
%
% L3: Opuesto de la Tierra respecto al Sol
% dm es la distancia del móvil al Sol
%
fL3 = @(dm) (G*MS / dm^2 + G * MT / (dT- dm)^2 + dm*wT^2);
%
dmL3 = raizPorNewton(fL3,-dT,1,1000);
vtL3   = wT * dmL3;
fprintf('dmL3: %+12.9e      vtL3: %+12.9e\n',dmL3,vtL3)
%
p0_L3 = [dmL3;0;0];
v0_L3 = [0;vtL3;0];
%
% L4: Triángulo equilátero superior
%
% Posición
%
theta = pi/3;
p0_L4 =    dT*[ cos(theta); sin(theta); 0];
v0_L4 = wT*dT*[-sin(theta); cos(theta); 0];
%
% L5: Triángulo equilátero inferior
%
p0_L5 =    dT*[cos(theta); -sin(theta); 0];
v0_L5 = wT*dT*[sin(theta);  cos(theta); 0];
%
% Reportando los valores de los vectores de posición y velocidad
%
fprintf('p0_Tierra: [%+12.9e %+12.9e %+12.9e]\n',p0_Tierra')
fprintf('v0_Tierra: [%+12.9e %+12.9e %+12.9e]\n\n',v0_Tierra')

fprintf('p0_Luna: [%+12.9e %+12.9e %+12.9e]\n',p0_Luna')
fprintf('v0_Luna: [%+12.9e %+12.9e %+12.9e]\n\n',v0_Luna')

fprintf('p0_L1: [%+12.9e %+12.9e %+12.9e]\n',p0_L1')
fprintf('v0_L1: [%+12.9e %+12.9e %+12.9e]\n\n',v0_L1')

fprintf('p0_L2: [%+12.9e %+12.9e %+12.9e]\n',p0_L2')
fprintf('v0_L2: [%+12.9e %+12.9e %+12.9e]\n\n',v0_L2')

fprintf('p0_L3: [%+12.9e %+12.9e %+12.9e]\n',p0_L3')
fprintf('v0_L3: [%+12.9e %+12.9e %+12.9e]\n\n',v0_L3')

fprintf('p0_L4: [%+12.9e %+12.9e %+12.9e]\n',p0_L4')
fprintf('v0_L4: [%+12.9e %+12.9e %+12.9e]\n\n',v0_L4')

fprintf('p0_L5: [%+12.9e %+12.9e %+12.9e]\n',p0_L5')
fprintf('v0_L5: [%+12.9e %+12.9e %+12.9e]\n\n',v0_L5')
%
% Agregndo los valores a los vectores iniciales:
%
% La Luna va al último
%
m  = [MS,MT,ones(1,5),ML];

r0 = [p0_Sol, p0_Tierra, p0_L1, p0_L2, p0_L3, p0_L4, p0_L5, p0_Luna];
v0 = [v0_Sol, v0_Tierra, v0_L1, v0_L2, v0_L3, v0_L4, v0_L5, v0_Luna];

T = 365.25*24*60*60; %% un año Terrestre 
deltaT=1*3600; %% 1 hora
Nk = round(T/deltaT); % un ciclo de la luna
NumMov = 8 %% 7 para sin Luna, 8 para incluir la Luna
m = m(1:NumMov);
r0 = r0(:,1:NumMov);
v0 = v0(:,1:NumMov);
%
% Guardando las posiciones iniciales
%
pos=zeros(Nk,3 * NumMov);
for k = 1:NumMov,pos(1,3*(k-1)+1:3*k)= r0(:,k)';end
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
a   = zeros(3,8);
%
for t=2:Nk,
   % disp(sprintf('t: %5d',t))
%
  Fza = zeros(3,NumMov);
  for m_r = 1:NumMov-1
    for m_s = m_r+1:NumMov
      dr_rs  = r(:,m_s) - r(:,m_r);
      dr2_rs = dr_rs'*dr_rs;
      u_rs   = dr_rs/sqrt(dr2_rs);
      Fza_rs = G * m(m_r) * m(m_s) / dr2_rs * u_rs;
      Fza(:,m_r) = Fza(:,m_r) + Fza_rs;
      Fza(:,m_s) = Fza(:,m_s) - Fza_rs;
    end    
  end  
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
  for k = 0:NumMov-1
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
  p(1,:) = ['or']; %% Sol
  p(2,:) = ['-k']; %% Tierra
  p(3,:) = ['-g']; %% L1 (posterior a la Tierra)
  p(4,:) = ['-m']; %% L2 (entre la Tierra y el Sol)
  p(5,:) = ['-y']; %% L3 (al otro lado del Sol)
  p(6,:) = ['-r']; %% L4 (equilátero superior)
  p(7,:) = ['-g']; %% L5 (equilátero inferior)
  p(8,:) = ['-r']; %% Luna
%
hold off
for k = 1:NumMov
  if k == 1
    hold off
  else
    hold on  
  end  
  plot(pos(:,3*k-2),pos(:,3*k-1),p(k,:))  
  %plot3(pos(:,3*k-2),pos(:,3*k-1),pos(:,3*k),p(k,:)) 
end    
%plot3(pos(:,1),pos(:,2),pos(:,3),'+',pos(:,4),pos(:,5),pos(:,6)'.',pos(:,7),pos(:,8),pos(:,9)'.')