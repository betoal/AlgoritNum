% =======================================================================
% prog pst_03.m
%
%  Simulación 3D del movimiento de los planetas del Sistema Planetario
%  Solar
%  Por R.G.G.H.
%  26 de mayo de 2015
%  para ANC
% =======================================================================
G = 6.67384E-11;
deltaT = 86400/(60*24); % cada 1 minuto
N      = 86400/(4*deltaT);  % un día

ind_Sol       = 1;
ind_Mercurio  = 2;
ind_Venus     = 3;
ind_Tierra    = 4;
ind_Marte     = 5;
ind_Jupiter   = 6;
ind_Saturno   = 7;
ind_Urano     = 8;
ind_Neptuno   = 9;
ind_Pluton    = 10;
ind_Luna      = 11;
ind_Io        = 12;
ind_Europa    = 13;
ind_Ganimedes = 14;
ind_satCIA    = 15;
% ==========================================================
plt = [];
%plt = [plt; ClsMovil_3D('Sol',        1.9891E+30,[0,0,0],[0,0,0])]; 
%plt = [plt; ClsMovil_3D('Mercurio',   3.302E+23, [ 69816877462.0779,0,0],[0,43604.9701342689, 0])]; 
%plt = [plt; ClsMovil_3D('Venus',      4.869E+24, [ 108939114216.059,0,0],[0,34907.9450884882, 0])]; 
%plt = [plt; ClsMovil_3D('Tierra',     5.9736E+24,[ 152098232000,    0,0],[0,29542.9677972225, 0])]; 
plt = [plt; ClsMovil_3D('Tierra_quieta',     5.9736E+24,[0,0,0],[0,0,0])];
ind_Tierra_quieta = 1;
ind_Tierra = ind_Tierra_quieta;

% plt = [plt; ClsMovil_3D('Marte',      6.4185E+23,[ 249209300000,    0,0],[0,23079.9084256538, 0])]; 
% plt = [plt; ClsMovil_3D('Jupiter',    1.899E+27, [ 816520736459.153,0,0],[0,12750.6579262522, 0])]; 
% plt = [plt; ClsMovil_3D('Saturno',    5.688E+26, [1513325782874.55, 0,0],[0, 9365.9101754812, 0])]; 
% plt = [plt; ClsMovil_3D('Urano',      8.686E+25, [3004419704000,    0,0],[0, 6647.15648959595,0])]; 
% plt = [plt; ClsMovil_3D('Neptuno',    1.024E+26, [4553946490000,    0,0],[0, 5399.1108280321, 0])]; 
% plt=  [plt; ClsMovil_3D('Pluton',     1.25E+22,  [7304300000000,    0,0],[0, 4263.11357451718,0])];
%  
% plt = [plt;  ClsMovil_3D( 'Luna', 7.349E+22, [152482632000,0,0], [0,30561.3581461602,0])]; 
% 
% plt = [plt;  ClsMovil_3D( 'Io', 8.94E+22, [816943736459.153,0,0], [0,30059.9853834724,0])];   
%  
% plt = [plt;  ClsMovil_3D( 'Europa', 4.8E+22, [817197674459.153,0,0], [0,26433.4879106114,0])]; 
% plt = [plt;  ClsMovil_3D( 'Ganimedes', 1.482E+23, [817592336459.153,0,0], [0,23625.7771092884,0])]; 

% ===================================================================================================
% Satélites de la tierra
% ===================================================================================================
plt = [plt;  ClsMovil_3D( 'SatCIA',10e4,plt(ind_Tierra).posicion  + [0.00001, -6.52e6, 0],...
                                        plt(ind_Tierra).velocidad + [0,       0,       7.819557303145614e3])]; 
ind_SatCia = max(size(plt)) + 1;

r_GeoEstac  = ( G * plt(ind_Tierra).masa / ( 2 * pi / 86400 )^2 )^(1/3);
vt_GeoEstac = 2*pi*r_GeoEstac/86400;

ang_eje_Tierra = pi * ( 23 + 27/60 ) / 180;
cosang = cos(ang_eje_Tierra);
sinang = sin(ang_eje_Tierra);

plt = [plt;  ClsMovil_3D( 'GeoEstac_1',10e4, plt(ind_Tierra).posicion  + [-r_GeoEstac,0,0], ...
                 plt(ind_Tierra).velocidad + vt_GeoEstac*[0,-cosang,-sinang])]; 
ind_GeoEstac_1    =  max(size(plt)) + 1;

 plt = [plt;  ClsMovil_3D( 'GeoEstac_2',10e4, plt(ind_Tierra).posicion  + [r_GeoEstac,0,0], ...
                 plt(ind_Tierra).velocidad + vt_GeoEstac*[0,cosang,sinang])]; 
 ind_GeoEstac_2    = max(size(plt)) + 1;

%ind_GeoEstac_3    = ind_GeoEstac_2 + 1;
%ind_GeoEstac_4    = ind_GeoEStac_3 + 1;

np = max(size(plt));

% ==========================================================
%                   Matriz de fuerzas
fzas = zeros(np,np,3);
fza  = zeros(np,3);
% ==========================================================
% ==========================================================


% ==========================================================
% se almacenan las posiciones iniciales del sol, planetas y demás cuerpos
% ==========================================================
pos = zeros(np,3,N);
posCol = zeros(np,3);
for k=1:np, posCol(k,:) = plt(k).posicion; end
pos(:,:,1) = posCol;
% ==========================================================

for t = 1:N
    
  for i = 2:np
    for j = 1:(i-1)
      r = plt(j).posicion - plt(i).posicion;
      r2 = r * r';
      u = r / r2^0.5;
      
      fzas(i,j,:) = ( G * plt(i).masa * plt(j).masa / r2 ) * u;
      fzas(j,i,:) = - fzas(i,j,:);
      
    end  
  end
  
  %fzas
  
  for i = 1:np
    sfza = [0,0,0];
    for j = 1:np  
     sfza = sfza + [fzas(i,j,1),fzas(i,j,2), fzas(i,j,3)];
    end
    fza(i,:) = sfza(:);
  end
 
  for i = 1:np
    actualizaEuler(plt(i),[fza(i,1),fza(i,2),fza(i,3)],deltaT);
  end  
  %
  %  se almacenan las posiciones de los cuerpos celestes
  %
  for k=1:np, posCol(k,:) = plt(k).posicion; end
  pos(:,:,t+1) = posCol;
end

% ================================================================
% Se grafican las trayectorias de las órbitas de los cuerpos celestes
% ================================================================


figure
hold on

for k = np:-1:1
%for k = 6:-1:3
  x=zeros(N+1,3);
  x(:,1) = pos(k,1,:);
  x(:,2) = pos(k,2,:);
  x(:,3) = pos(k,3,:);
  if strcmpi(plt(k).nombre,'Jupiter')
    plot3(x(:,1),x(:,2),x(:,3),'+r')
  elseif strcmpi(plt(k).nombre,'Io')
    plot3(x(:,1),x(:,2),x(:,3),'og') 
  elseif strcmpi(plt(k).nombre,'Europa')
      plot3(x(:,1),x(:,2),x(:,3),'ob')
  elseif strcmpi(plt(k).nombre,'GeoEstac_1')
      plot3(x(:,1),x(:,2),x(:,3),'r') 
  elseif strcmpi(plt(k).nombre,'GeoEstac_2')
      plot3(x(:,1),x(:,2),x(:,3),'g')     
  else        
    plot3(x(:,1),x(:,2),x(:,3))
  end  
end  
hold off
