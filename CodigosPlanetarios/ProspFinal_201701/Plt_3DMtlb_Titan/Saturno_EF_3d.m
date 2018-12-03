clear all
% =======================================================================
% prog sim_saturno_3d.m
%
%  Simulación 3D del movimiento de los planetas del Sistema Planetario
%  Solar
%  Por R.G.G.H.
%  30 de mayo de 2017
%  para ANC
% =======================================================================
G = 6.67384E-11;
deltaT = 5*60;  % deltaT en segundos
T = 0.0; % Tiempo transcurrido
N = 10*86400/deltaT; %cantidad de cálculos a llevarse a cabo
GuardarCadaCuantos = 4; %% cada cuantos cálculos (dados por el valor de t)  hay que guardar las posiciones
N_GuardaPosiciones = 1 + N / GuardarCadaCuantos;
%
% ================================ índices de los móviles ====================
% NOTA: se modifican mas adelante en función de los que se desean
% en la simulación

ind_Sol       = 0;
ind_Mercurio  = 0;
ind_Venus     = 0;
ind_Tierra    = 0;
ind_Luna      = 0;
ind_Apollo    = 0;
ind_Marte     = 0;
ind_Jupiter   = 0;
ind_Saturno   = 0;
ind_Urano     = 0;
ind_Neptuno   = 0;
ind_Pluton    = 0;
ind_Io        = 0;
ind_Europa    = 0;
ind_Ganimedes = 0;
ind_Titan     = 0;
ind_Encelado  = 0;
ind_Tetis     = 0;
ind_Dione     = 0;
ind_Rea       = 0;
ind_Mimas     = 0;
ind_Hiperion  = 0;
ind_Japeto    = 0;
ind_Febe      = 0;
ind_Jano      = 0;
ind_Epimeteo  = 0;

% ==============================================================================
ind_Referencia = ind_Saturno; %% el ind_Referencia marca el punto fijo referencial
% ==============================================================================

num_ind = 0;
plt = [];
% num_ind = num_ind+1; ind_Sol       = num_ind; plt = [plt; ClsMovil_2D8('Sol',        1.9891E+30,[0,0,0],[0,0,0])]; 
% num_ind = num_ind+1; ind_Mercurio  = num_ind; plt = [plt; ClsMovil_2D8('Mercurio',   3.302E+23, [ 69816877462.0779,0,0],[0,43604.9701342689,0])]; 
% num_ind = num_ind+1; ind_Venus     = num_ind; plt = [plt; ClsMovil_2D8('Venus',      4.869E+24, [ 108939114216.059,0,0],[0,34907.9450884882,0])]; 
% num_ind = num_ind+1; ind_Tierra    = num_ind; plt = [plt; ClsMovil_2D8('Tierra',     5.9736E+24,[ 152098232000,0,0],    [0,29542.9677972225,0])]; 
% num_ind = num_ind+1; ind_Luna      = num_ind; plt = [plt; ClsMovil_2D8( 'Luna',      7.349E+22, [152482632000,0,0], [0,30561.3581461602,0])]; 
% num_ind = num_ind+1; ind_Apollo    = num_ind; plt = [plt; ClsMovil_2D8('Apollo',     20.0E+3,   [152098232000,0,0]+[0,6378000.0+108000.0,0], [0,29542.9677972225,0]+[-7.7831E+3,0,0])];
% num_ind = num_ind+1; ind_Marte     = num_ind; plt = [plt; ClsMovil_2D8('Marte',      6.4185E+23,[ 249209300000,0,0],    [0,23079.9084256538,0])]; 
% num_ind = num_ind+1; ind_Jupiter   = num_ind; plt = [plt; ClsMovil_2D8('Jupiter',    1.899E+27, [ 816520736459.153,0,0],[0,12750.6579262522,0])]; 
num_ind = num_ind+1; ind_Saturno   = num_ind; plt = [plt; ClsMovil_2D8('Saturno',    5.688E+26, [1513325782874.55,0,0], [0, 9365.9101754812,0])]; 
% num_ind = num_ind+1; ind_Urano     = num_ind; plt = [plt; ClsMovil_2D8('Urano',      8.686E+25, [3004419704000,0,0],    [0, 6647.15648959595,0])]; 
% num_ind = num_ind+1; ind_Neptuno   = num_ind; plt = [plt; ClsMovil_2D8('Neptuno',    1.024E+26, [4553946490000,0,0],    [0, 5399.1108280321,0])]; 
% num_ind = num_ind+1; ind_Pluton    = num_ind; plt=  [plt; ClsMovil_2D8('Pluton',     1.25E+22,  [7304300000000,0,0],    [0, 4263.11357451718,0])];
% num_ind = num_ind+1; ind_Io        = num_ind; plt = [plt;  ClsMovil_2D8( 'Io', 8.94E+22, [816943736459.153,0,0], [0,30059.9853834724,0])];   
% num_ind = num_ind+1; ind_Europa    = num_ind; plt = [plt;  ClsMovil_2D8( 'Europa', 4.8E+22, [817197674459.153,0,0], [0,26433.4879106114,0])]; 
% num_ind = num_ind+1; ind_Ganimedes = num_ind; plt = [plt;  ClsMovil_2D8( 'Ganimedes', 1.482E+23, [817592336459.153,0,0], [0,23625.7771092884,0])]; 
% 
 num_ind = num_ind+1; ind_Titan = num_ind;plt = [plt;  ClsMovil_2D8( 'Titan', 1.34500E+23, [1514521447818.79,-251697512.900079,0], [1147.33095066515,14816.1960418493,0])]; 
 num_ind = num_ind+1; ind_Encelado = num_ind;plt = [plt;  ClsMovil_2D8( 'Encelado', 1.08000E+20, [1513294782709.97,235919987.495976,0], [-12513.7921253722,7721.5831326309,0])]; 
 num_ind = num_ind+1; ind_Tetis = num_ind;plt = [plt;  ClsMovil_2D8( 'Tetis', 6.17449E+20, [1513462788586.16,260825209.94903,0], [-10041.6649601803,14640.574591437,0])]; 
 num_ind = num_ind+1; ind_Dione = num_ind;plt = [plt;  ClsMovil_2D8( 'Dione', 1.09600E+21, [1513002648588.41,194519274.94021,0], [-5170.26347206806,777.098620928258,0])]; 
 num_ind = num_ind+1; ind_Rea = num_ind;plt = [plt;  ClsMovil_2D8( 'Rea', 2.32000E+21, [1513396925284.57,522284980.791128,0], [-8402.43988018935,10510.4382495076,0])]; 
 num_ind = num_ind+1; ind_Mimas = num_ind;plt = [plt;  ClsMovil_2D8( 'Mimas', 3.74900E+19, [1513145069769.9,-41117861.1796156,0], [3172.87247438024,-4578.87243356754,0])]; 
 num_ind = num_ind+1; ind_Hiperion = num_ind;plt = [plt;  ClsMovil_2D8( 'Hiperion', 5.68600E+18, [1512003141124.71,-666338097.112643,0], [2276.17362018293,4847.84003514026,0])]; 
 num_ind = num_ind+1; ind_Japeto = num_ind;plt = [plt;  ClsMovil_2D8( 'Japeto', 1.97300E+21, [1512807515138.11,3522901875.69402,0], [-3227.92030693267,8891.03831986258,0])]; 
 num_ind = num_ind+1; ind_Febe = num_ind;plt = [plt;  ClsMovil_2D8( 'Febe', 8.29200E+18, [1513240297341.43,-56276937.8247677,0], [10581.9635636968,-6708.25504437808,0])]; 
 num_ind = num_ind+1; ind_Jano = num_ind;plt = [plt;  ClsMovil_2D8( 'Jano', 1.89750E+18, [1513237549273.89,123120260.31047,0], [-12858.1436527632,151.177284235671,0])]; 
 num_ind = num_ind+1; ind_Epimeteo = num_ind;plt = [plt;  ClsMovil_2D8( 'Epimeteo', 1.89750E+18, [1513214590297.02,-102859017.527854,0], [10742.1477181751,-2246.55824656421,0])]; 

% ==============================================================================
ind_Referencia = ind_Saturno; %% el ind_Referencia marca el punto fijo referencial
% ==============================================================================
np = num_ind;

%% ================================= La referencia se define como "fija" ================================================= 
if ind_Referencia > 0
  pos_ref = plt(ind_Referencia).posicion;
  vel_ref = plt(ind_Referencia).velocidad;
  for k = 1:np 
    plt(k).posicion  = plt(k).posicion  - pos_ref;
    plt(k).velocidad = plt(k).velocidad - vel_ref;
   
  end
end

% ==========================================================
% se almacenan las posiciones iniciales del sol, planetas y demás cuerpos
% ==========================================================
pos = zeros(np,3,N_GuardaPosiciones);
posCol = zeros(np,3);
for k=1:np, posCol(k,:) = plt(k).posicion; end
pos(:,:,1) = posCol;
% ==========================================================
%                    Ciclo de la Simulación
% ==========================================================
for t = 1:N
  % ================================================================================================
  %                   Matriz de fuerzas
  fzas = zeros(np,np,3);
  fza  = zeros(np,3);   
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
    sfza = [0,0,0];
    for j = 1:np  
     sfza = sfza + [fzas(i,j,1),fzas(i,j,2), fzas(i,j,3)];
    end
    fza(i,:) = sfza(:);
  end
     
  %
  % ================ Cálculo de las nuevas posiciones ============
  %

  for i = 1:np
             
        plt(i).aceleracion = fza(i,:) / plt(i).masa;
        plt(i).velocidad   = plt(i).velocidad + plt(i).aceleracion * deltaT;
        plt(i).posicion    = plt(i).posicion  + plt(i).velocidad   * deltaT;
  end  
  %
  %  se almacenan las posiciones de los cuerpos celestes
  %
  if mod(t,GuardarCadaCuantos) == 0
    for k=1:np, posCol(k,:) = plt(k).posicion; end
    pos(:,:,1+t/GuardarCadaCuantos) = posCol;
   end  
    
    T = T + deltaT;
   %
   % ============ Fin del ciclo de la simulación ============ 
   %
end

% ================================================================
% Se grafican las trayectorias de las órbitas de los cuerpos celestes
% ================================================================

hold off
hold on
for k = np:-1:1
  x=zeros(3,N_GuardaPosiciones);
  x(1,:) = pos(k,1,:);
  x(2,:) = pos(k,2,:);
  x(3,:) = pos(k,3,:);
  x = x';
  if k == ind_Saturno
    plot3(x(:,1),x(:,2),x(:,3),'or')
  elseif k == ind_Titan
    plot3(x(:,1),x(:,2),x(:,3),'og') 
  elseif k == ind_Dione
    plot3(x(:,1),x(:,2),x(:,3),'ob')      
  elseif k == ind_Febe
    plot3(x(:,1),x(:,2),x(:,3),'r')
  elseif k == ind_Japeto
    plot3(x(:,1),x(:,2),x(:,3),'k')
  elseif k == ind_Epimeteo
    plot3(x(:,1),x(:,2),x(:,3),'b')
  else  
    plot3(x(:,1),x(:,2),x(:,3))
  end  
end  
hold off

%
% ====================== FIN DE LA SIMULACIÓN =============================
%
