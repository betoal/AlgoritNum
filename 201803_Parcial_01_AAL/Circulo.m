classdef Circulo < Figura2D
   properties
     radio  
   end
   methods 
       function obj = Circulo(x,r)
           if nargin == 0
             fig2d_args{1} = [0.0;0.0];
             c = 1.0;
           else
             fig2d_args{1} = x;
             c = r;
           end  
           obj@Figura2D(fig2d_args{:});
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
       function xtam = valoresExtremos(obj)
          xtam = [[obj.centro(1)-obj.radio;obj.centro(2)-obj.radio], ...
                  [obj.centro(1)+obj.radio;obj.centro(2)+obj.radio]];
       end
       function dibuja(obj)
          plot( [obj.centro(1) + obj.radio * cos(2*pi*0.01*(0:100))], ...
                [obj.centro(2) + obj.radio * sin(2*pi*0.01*(0:100))])
       end
   end
end