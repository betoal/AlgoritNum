classdef Circulo < Figura2D % Herencia del objeto
   properties
     radio  
   end
   methods 
       function obj = Circulo(x,r) % Constructor
           if nargin == 0 % Numero de argumentos que tiene
             fig2d_args{1} = [0.0;0.0];
             c = 1.0;
           else
             fig2d_args{1} = x;
             c = r;
           end  
           obj@Figura2D(fig2d_args{:}); % Se ponen los datos al objeto
           obj.radio  = c;
       end
       function bln = contiene(obj,p)
         if nargin == 0
           pv = [0.0;0.0];  
         else
           pv = p;  
         end    
         d = pv - obj.centro;
         bln = (d' * d) <= obj.radio^2;
       end
       function xtam = valoresExtremos(obj) % Preguntar el tamaño
          xtam = [[obj.centro(1)-obj.radio;obj.centro(2)-obj.radio], ...
                  [obj.centro(1)+obj.radio;obj.centro(2)+obj.radio]];
       end
   end
end