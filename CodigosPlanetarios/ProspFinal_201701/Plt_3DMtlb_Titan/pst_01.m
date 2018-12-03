clear all
% =======================================================================
% prog pst_01.m
%
%  Simulación 2D del movimiento de los planetas del Sistema Planetario
%  Solar
%  Por R.G.G.H.
%  12 de diciembre de 2015
%  para ANC
% =======================================================================
G = 6.67384E-11;
%deltaT = 86400/24; % cada hora
T = 0.0; % Tiempo transcurrido
deltaT = 15; % deltaT en segundos
N = 4.5*86400/deltaT; %cantidad de cálculos a llevarse a cabo
GuardarCadaCuantos = 5; %% cada cuantos cálculos (daos por el valor de t)  hay que guardar las posiciones
N_GuardaPosiciones = 1 + N / GuardarCadaCuantos;
% ===================== Variables para distancias mínimas del Apolo a la
% Tierra inicial, Luna en general y Tierra al regresar =====================

dMinApoloTierraInicial = 150e9;
tiempoInicial_dMinApoloTierraInicial = 0;
tiempoFinal_dMinApoloTierraInicial   = 1000 * deltaT;

dMinApoloTierraFinal   = 150E9;
tiempoInicial_dMinApoloTierraFinal   =  1000*deltaT;
tiempoFinal_dMinApoloTierraFinal     = ( N + 1 ) * deltaT;

dMinApoloLuna          = 150E9;
tiempoInicial_dMinApoloLuna          = 0;
tiempoFinal_dMinApoloLuna            = ( N + 1 ) * deltaT;
% ========================= Alternativa de Navegación ======================
Alternativa = 1;
% tiempos de inicio y fin de galletazo
if Alternativa == 1
  T0_Apollo = 465*deltaT;
  T1_Apollo = T0_Apollo + 30*deltaT;
  Acel0 = 9.8*0.75; % en m/s^2 en la direccón de la velocidad

  T2_Apollo = 1768*GuardarCadaCuantos*deltaT;
  T3_Apollo = T2_Apollo + 16 * deltaT;
  Acel2 = - 9.8 * 0.75;

  T4_Apollo = 2000*GuardarCadaCuantos*deltaT;
  T5_Apollo = T4_Apollo + 10 * deltaT;
  Acel4 = - 9.8 * 0.25;
  
  T6_Apollo = 2015*GuardarCadaCuantos*deltaT;
  T7_Apollo = T6_Apollo + 10 * deltaT;
  Acel6 = - 9.8 * 0.25;
  
  T8_Apollo = 2257 * GuardarCadaCuantos*deltaT;
  T9_Apollo = T8_Apollo + 11 * deltaT;
  Acel8 = 9.8 * 0.758;

  %% ¡¡¡ FRENA !!!
  T10_Apollo = 4800 * GuardarCadaCuantos*deltaT;
  T11_Apollo = T10_Apollo + 15 * deltaT;
  Acel10 = - 9.8 * 1.0;   
  
end

% ==========================================================================

%
% ================================ índices de los móviles ====================
%
ind_Sol       = 1;
ind_Mercurio  = 2;
ind_Venus     = 3;
ind_Tierra    = 4;
ind_Luna      = 5;
ind_Apollo    = 6;
ind_Marte     = 7;
ind_Jupiter   = 8;
ind_Saturno   = 9;
ind_Urano     = 10;
ind_Neptuno   = 11;
ind_Pluton    = 12;
ind_Io        = 13;
ind_Europa    = 14;
ind_Ganimedes = 15;

ind_Tierra    = 1;
ind_Luna      = 2;
ind_Apollo    = 3;

np = ind_Apollo;
% ==============================================================================
ind_Referencia = ind_Tierra; %% el ind_Referencia marca el punto fijo referencial
% ==============================================================================
plt = [];
%plt = [plt; ClsMovil_2D8('Sol',        1.9891E+30,[0,0],[0,0])]; 
%plt = [plt; ClsMovil_2D8('Mercurio',   3.302E+23, [ 69816877462.0779,0],[0,43604.9701342689])]; 
%plt = [plt; ClsMovil_2D8('Venus',      4.869E+24, [ 108939114216.059,0],[0,34907.9450884882])]; 
%plt = [plt; ClsMovil_2D8('Tierra',     5.9736E+24,[ 152098232000,0],    [0,29542.9677972225])]; 
%plt = [plt; ClsMovil_2D8( 'Luna',      7.349E+22, [152482632000,0], [0,30561.3581461602])]; 
%plt = [plt; ClsMovil_2D8('Apollo',     20.0E+3,   [152098232000,0]+[0,6378000.0+108000.0], [0,29542.9677972225]+[-7.7831E+3,0])];
%plt = [plt; ClsMovil_2D8('Marte',      6.4185E+23,[ 249209300000,0],    [0,23079.9084256538])]; 
%plt = [plt; ClsMovil_2D8('Jupiter',    1.899E+27, [ 816520736459.153,0],[0,12750.6579262522])]; 
%plt = [plt; ClsMovil_2D8('Saturno',    5.688E+26, [1513325782874.55,0], [0, 9365.9101754812])]; 
%plt = [plt; ClsMovil_2D8('Urano',      8.686E+25, [3004419704000,0],    [0, 6647.15648959595])]; 
%plt = [plt; ClsMovil_2D8('Neptuno',    1.024E+26, [4553946490000,0],    [0, 5399.1108280321])]; 
%plt=  [plt; ClsMovil_2D8('Pluton',     1.25E+22,  [7304300000000,0],    [0, 4263.11357451718])];
%plt = [plt;  ClsMovil_2D8( 'Io', 8.94E+22, [816943736459.153,0], [0,30059.9853834724])];   
%plt = [plt;  ClsMovil_2D8( 'Europa', 4.8E+22, [817197674459.153,0], [0,26433.4879106114])]; 
%plt = [plt;  ClsMovil_2D8( 'Ganimedes', 1.482E+23, [817592336459.153,0], [0,23625.7771092884])]; 

%np = ind_Ganimedes; %max(size(plt));

%% ================================== Tierra, Luna y Apollo ======================================

plt = [plt; ClsMovil_2D8('Tierra',     5.9736E+24,[152098232000,0], [0,29542.9677972225])]; 
plt = [plt; ClsMovil_2D8('Luna',       7.349E+22, [152482632000,0], [0,30561.3581461602])]; 
plt = [plt; ClsMovil_2D8('Apollo',     20.0E+3,   [152098232000,0]+ [0,6378000.0+108000.0], [0,29542.9677972225]+[-7840.025808,0])]; 

%% ================================= Tierra Fija ================================================= 
if ind_Referencia > 0
  pos_ref = plt(ind_Referencia).posicion;
  vel_ref = plt(ind_Referencia).velocidad;
  for k = 1:np 
    plt(k).posicion  = plt(k).posicion  - pos_ref;
    plt(k).velocidad = plt(k).velocidad - vel_ref;
   
  end
end
% ================================================================================================
%                   Matriz de fuerzas
fzas = zeros(np,np,2);
fza  = zeros(np,2);
% ==========================================================
% se almacenan las posiciones iniciales del sol, planetas y demás cuerpos
% ==========================================================
pos = zeros(np,2,N_GuardaPosiciones);
posCol = zeros(np,2);
for k=1:np, posCol(k,:) = plt(k).posicion; end
pos(:,:,1) = posCol;
% ==========================================================
%                    Ciclo de la Simulación
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
  
  for i = 1:np
    sfza = [0,0];
    for j = 1:np  
     sfza = sfza + [fzas(i,j,1),fzas(i,j,2)];
    end
    fza(i,:) = sfza(:);
  end
  
  % ================ Ejecución de las alternativas de navegación ================
  if Alternativa == 1
    if T0_Apollo <= T && T <= T1_Apollo
      vel = plt(ind_Apollo).velocidad;
      vel = vel /( vel * vel')^0.5;  
      fza(ind_Apollo,:) = fza(ind_Apollo,:) + plt(ind_Apollo).masa * vel * Acel0; 
    end
    if T2_Apollo <= T && T <= T3_Apollo
      vel = plt(ind_Apollo).velocidad;
      vel = vel /( vel * vel')^0.5;  
      fza(ind_Apollo,:) = fza(ind_Apollo,:) + plt(ind_Apollo).masa * vel * Acel2; 
    end
    if T4_Apollo <= T && T <= T5_Apollo
      vel = plt(ind_Apollo).velocidad;
      vel = vel /( vel * vel')^0.5;  
      fza(ind_Apollo,:) = fza(ind_Apollo,:) + plt(ind_Apollo).masa * vel * Acel4; 
    end
 
    if T6_Apollo <= T && T <= T7_Apollo
      vel = plt(ind_Apollo).velocidad;
      vel = vel /( vel * vel')^0.5;  
      fza(ind_Apollo,:) = fza(ind_Apollo,:) + plt(ind_Apollo).masa * vel * Acel6; 
    end

    if T8_Apollo <= T && T <= T9_Apollo
      vel = plt(ind_Apollo).velocidad;
      vel = vel /( vel * vel')^0.5;  
      fza(ind_Apollo,:) = fza(ind_Apollo,:) + plt(ind_Apollo).masa * vel * Acel8; 
    end

    if T10_Apollo <= T && T <= T11_Apollo
      vel = plt(ind_Apollo).velocidad;
      vel = vel /( vel * vel')^0.5;  
      fza(ind_Apollo,:) = fza(ind_Apollo,:) + plt(ind_Apollo).masa * vel * Acel10; 
    end
    
    
    
    % Actualización de las distancias mínimas del Apolo a Tierra al inicio,
    % al final y a la Luna 
    
    if tiempoInicial_dMinApoloTierraInicial <= t && t <= tiempoFinal_dMinApoloTierraInicial
      dr = plt(ind_Apollo).posicion - plt(ind_Tierra).posicion;
      dr = (dr*dr')^0.5;
      dMinApoloTierraInicial = min(dr,dMinApoloTierraInicial);
    end
    
    if tiempoInicial_dMinApoloTierraFinal <= t && t <= tiempoFinal_dMinApoloTierraFinal
      dr = plt(ind_Apollo).posicion - plt(ind_Tierra).posicion;
      dr = (dr*dr')^0.5;
      dMinApoloTierraFinal = min(dr,dMinApoloTierraFinal);
    end
    
    if tiempoInicial_dMinApoloLuna <= t && t <= tiempoFinal_dMinApoloLuna
      dr = plt(ind_Apollo).posicion - plt(ind_Luna).posicion;
      dr = (dr*dr')^0.5;
      dMinApoloLuna = min(dr,dMinApoloLuna);
    end    
  %
  % ================ Fin del Ciclo de Cálculo de la simulación ============
  %
  end
  
 
% ================ Fin de la ejecución de las alternativas de navegación ========= 
  for i = 1:np
             
        plt(i).aceleracion = fza(i,:) / plt(i).masa;
        plt(i).velocidad   = plt(i).velocidad + plt(i).aceleracion * deltaT;
        plt(i).posicion    = plt(i).posicion  + plt(i).velocidad   * deltaT; % + 0.5 * deltaT^2 * plt(i).aceleracion ;
  end  
  %
  %  se almacenan las posiciones de los cuerpos celestes
  %
  if mod(t,GuardarCadaCuantos) == 0
    for k=1:np, posCol(k,:) = plt(k).posicion; end
    pos(:,:,1+t/GuardarCadaCuantos) = posCol;
   end  
    
    T = T + deltaT;
end

% ================================================================
% Se grafican las trayectorias de las órbitas de los cuerpos celestes
% ================================================================

hold off
hold on
for k = np:-1:1
  x=zeros(2,N_GuardaPosiciones);
  x(1,:) = pos(k,1,:);
  x(2,:) = pos(k,2,:);
  x = x';
  if k == ind_Jupiter
    plot(x(:,1),x(:,2),'+r')
  elseif k == ind_Io
    plot(x(:,1),x(:,2),'og') 
  elseif k == ind_Europa
    plot(x(:,1),x(:,2),'ob')      
  elseif k == ind_Luna
    plot(x(:,1),x(:,2),'r')
  elseif k == ind_Apollo
    plot(x(:,1),x(:,2),'r')
  elseif k == ind_Tierra
    plot(x(:,1),x(:,2),'o')
  else  
    plot(x(:,1),x(:,2))
  end  
end  
hold off

dMinApoloTierraInicial
dMinApoloTierraFinal
dMinApoloLuna

%
% ====================== FIN DE LA SIMULACIÓN =============================
%