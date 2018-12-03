classdef ClsMovil_2D < handle
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
% ===================================================================    
    properties
% ===================================================================        
      nombre      %% cadena con el nombre del cuerpo
      posicion    %% en m
      velocidad   %% en m / seg
      aceleracion %% en m / seg^2
      masa        %% en Kg
 % ===================================================================     
    end %% properties
% ===================================================================
    methods
% ===================================================================
        
        function obj = ClsMovil_2D( nombre, masa, varPosicion, varVelocidad )
          obj.nombre      = nombre;
          obj.masa        = masa;   
          obj.posicion    = varPosicion(:).';
          obj.velocidad   = varVelocidad(:).';
        end
% ===================================================================        
        function actualizaEuler( obj, fuerza, deltaT )
         obj.aceleracion = fuerza / obj.masa;
         obj.velocidad   = obj.velocidad + obj.aceleracion * deltaT;
         obj.posicion    = obj.posicion + obj.velocidad * deltaT;
        end
% ===================================================================
        function actualiza2( obj, fuerza, deltaT )
         obj.aceleracion = fuerza / obj.masa;
         obj.posicion    = obj.posicion + obj.velocidad * deltaT + ...
                           0.5 * obj.aceleracion * deltaT^2
                       
         obj.velocidad   = obj.velocidad + obj.aceleracion * deltaT;
         
        end
% ===================================================================
        function obj = set.posicion(obj,val)
          if  ~isa(val,'double')
            error('La posición debe ser de doubles')
          end
          ind = find(val(:).' ~= 0 );
          if ~isempty(ind)
              obj.posicion = val(ind(1):end);
          else
              obj.posicion = val;
          end    
        end %set.posicion

    end %% methods
% ===================================================================
   
end

