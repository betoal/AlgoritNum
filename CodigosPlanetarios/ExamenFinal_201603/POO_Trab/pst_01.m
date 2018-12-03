% =======================================================================
% prog pst_01.m
%
%  Simulación 2D del movimiento de los planetas del Sistema Planetario
%  Solar
%  Por R.G.G.H.
%  11 de mayo de 2015
%  para ANC
% =======================================================================
G = 6.67384E-11;
deltaT = 86400/24; % cada hora
N = 350*24;

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
% ==========================================================
plt = [];
plt = [plt; ClsMovil_2D('Sol',        1.9891E+30,[0,0],[0,0])]; 
plt = [plt; ClsMovil_2D('Mercurio',   3.302E+23, [ 69816877462.0779,0],[0,43604.9701342689])]; 
plt = [plt; ClsMovil_2D('Venus',      4.869E+24, [ 108939114216.059,0],[0,34907.9450884882])]; 
plt = [plt; ClsMovil_2D('Tierra',     5.9736E+24,[ 152098232000,0],    [0,29542.9677972225])]; 
plt = [plt; ClsMovil_2D('Marte',      6.4185E+23,[ 249209300000,0],    [0,23079.9084256538])]; 
plt = [plt; ClsMovil_2D('Jupiter',    1.899E+27, [ 816520736459.153,0],[0,12750.6579262522])]; 
plt = [plt; ClsMovil_2D('Saturno',    5.688E+26, [1513325782874.55,0], [0, 9365.9101754812])]; 
plt = [plt; ClsMovil_2D('Urano',      8.686E+25, [3004419704000,0],    [0, 6647.15648959595])]; 
plt = [plt; ClsMovil_2D('Neptuno',    1.024E+26, [4553946490000,0],    [0, 5399.1108280321])]; 
plt=  [plt; ClsMovil_2D('Pluton',     1.25E+22,  [7304300000000,0],    [0, 4263.11357451718])];
 
plt = [plt;  ClsMovil_2D( 'Luna', 7.349E+22, [152482632000,0], [0,30561.3581461602])]; 

plt = [plt;  ClsMovil_2D( 'Io', 8.94E+22, [816943736459.153,0], [0,30059.9853834724])];   
 
plt = [plt;  ClsMovil_2D( 'Europa', 4.8E+22, [817197674459.153,0], [0,26433.4879106114])]; 
plt = [plt;  ClsMovil_2D( 'Ganimedes', 1.482E+23, [817592336459.153,0], [0,23625.7771092884])]; 

np = ind_Tierra; %max(size(plt));
% ==========================================================
%                   Matriz de fuerzas
fzas = zeros(np,np,2);
fza  = zeros(np,2);
% ==========================================================
% ==========================================================

% ==========================================================
% se almacenan las posiciones iniciales del sol, planetas y demás cuerpos
% ==========================================================
pos = zeros(np,2,N);
posCol = zeros(np,2);
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
    sfza = [0,0];
    for j = 1:np  
     sfza = sfza + [fzas(i,j,1),fzas(i,j,2)];
    end
    fza(i,:) = sfza(:);
  end
 
  for i = 1:np
    actualizaEuler(plt(i),[fza(i,1),fza(i,2)],deltaT);
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

hold off
hold on
for k = np:-1:1
  x=zeros(N+1,2);
  x(:,1) = pos(k,1,:);
  x(:,2) = pos(k,2,:);
  if k == ind_Jupiter
    plot(x(:,1),x(:,2),'+r')
  elseif k == ind_Io
    plot(x(:,1),x(:,2),'og') 
  elseif k == ind_Europa
    plot(x(:,1),x(:,2),'ob')      
  else        
    plot(x(:,1),x(:,2))
  end  
end  
