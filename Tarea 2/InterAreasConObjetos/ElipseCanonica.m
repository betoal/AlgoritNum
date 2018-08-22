classdef ElipseCanonica < Figura2D
   properties
     radio_hor
     radio_ver
   end
   methods 
       function obj = ElipseCanonica(x,a,b)
           if nargin == 0
             fig2d_args{1} = [0.0;0.0];
            r_h = 2.0;
            r_v = 1.0
           else
             fig2d_args{1} = x;
             r_h = a;
             r_v = b;
           end  
           obj@Figura2D(fig2d_args{:});
           obj.radio_hor = r_h;
           obj.radio_ver = r_v;
       end
       function bln = contiene(obj,p)
         if nargin == 0
           pv = [0.0;0.0];  
         else
           pv = p;  
         end
         d = pv - obj.centro;
         d = d ./[obj.radio_hor;obj.radio_ver];
         d = d.*d;
         bln =  sum(d) <= 1.0;
       end
       function xtam = valoresExtremos(obj)
          xtam = [[obj.centro(1)-obj.radio_hor;obj.centro(2)-obj.radio_ver], ...
                  [obj.centro(1)+obj.radio_hor;obj.centro(2)+obj.radio_ver]];
       end

   end
end