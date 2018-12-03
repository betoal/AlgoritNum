% ===================================================================     
        function obj = ClsMovil_2D8( nombre, masa, varPosicion, varVelocidad )
          obj.nombre      = nombre;
          obj.masa        = masa;   
          obj.posicion    = varPosicion;%varPosicion(:).';
          obj.velocidad   = varVelocidad;%varVelocidad(:).';
          obj.aceleracion = zeros(size(obj.velocidad));
          %obj.RadioOriginal = (varPosicion(1)^2 + varPosicion(2)^2)^0.5;
        end
% ===================================================================  
