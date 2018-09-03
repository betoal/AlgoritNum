classdef RomboCanonico < Figura2D
   properties
     semiDiag_hor
     semiDiag_ver
     V1
     V2
     L1
     L2
   end
   methods 
       function obj = RomboCanonico(x,a,b)
           if nargin == 0
            fig2d_args{1} = [0.0;0.0];
            sD_h = 1.0;
            sD_v = 1.0
           else
             fig2d_args{1} = x;
             sD_h = a;
             sD_v = b;
           end  
           obj = obj@Figura2D(fig2d_args{:});
           obj.semiDiag_hor = sD_h;
           obj.semiDiag_ver = sD_v;
           obj.V1 = obj.centro + [sD_h;0];
           obj.V2 = obj.centro - [sD_h;0];
           obj.L1 = [-sD_v;-sD_h];
           obj.L2 = [-sD_v; sD_h];
       end
       function bln = contiene(obj,p)
         if nargin == 0
           pv = [0.0;0.0];  
         else
           pv = p;  
         end
         bln =  ( pv - obj.V1 )' * obj.L1 >= 0.0 & ...
                ( pv - obj.V1 )' * obj.L2 >= 0.0 & ...
                ( pv - obj.V2 )' * obj.L1 <= 0.0 & ...
                ( pv - obj.V2 )' * obj.L2 <= 0.0;
       end
       function xtam = valoresExtremos(obj)
          xtam = [[obj.centro(1)-obj.semiDiag_hor;  ...
                   obj.centro(2)-obj.semiDiag_ver], ...
                  [obj.centro(1)+obj.semiDiag_hor;  ...
                   obj.centro(2)+obj.semiDiag_ver]];
       end

   end
end