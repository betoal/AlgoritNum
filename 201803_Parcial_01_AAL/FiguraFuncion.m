classdef FiguraFuncion < Figura2D
   properties
     fun
     x_min
     x_max
     y_min
     y_max
   end
   methods 
       function obj = FiguraFuncion(f,x_a,x_b,ymax)
           if nargin == 0
             fig2d_args{1} = [0.0;0.0];
             fh = @(x) x;
             xminima = 0.0;
             xmaxima = 1.0;
             yminima = 0.0;
             ymaxima = 1.0;
           else
             fig2d_args{1} = [0.0;0.0];
             fh = f;
             xminima = min([x_a,x_b]);
             xmaxima = max([x_a,x_b]);
             yminima = 0.0;
             ymaxima = ymax;
           end  
           obj@Figura2D(fig2d_args{:});
           obj.fun   = fh;
           obj.x_min = xminima;
           obj.x_max = xmaxima;
           obj.y_min = yminima;
           obj.y_max = ymaxima;
       end
       function bln = contiene(obj,p)
         if nargin == 0
           pv = [0.0;0.0];  
         else
           pv = p;  
         end    
         if( obj.x_min <= p(1) && p(1) <= obj.x_max && obj.y_min <= p(2) && p(2) <= obj.y_max )
           bln = p(2) <= obj.fun(p(1));  
         else
           bln = 0;  
         end    
       end
       function xtam = valoresExtremos(obj)
          xtam = [[obj.x_min;obj.y_min],[obj.x_max;obj.y_max]];
       end
       function dibuja(obj)
          plot( [obj.x_min + 0.01 * (obj.x_max - obj.x_min)*(0:100)], ...
                [obj.fun(obj.x_min + 0.01 * (obj.x_max - obj.x_min)*(0:100))],[obj.x_min,obj.x_max],[0,0])
       end
   end
end