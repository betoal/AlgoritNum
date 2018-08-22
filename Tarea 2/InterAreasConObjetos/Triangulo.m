classdef Triangulo < handle
   properties
     V  % Vértices
     L  % Normales a los lados 
   end
   methods 
       function obj = Triangulo(v1,v2,v3)
           if nargin < 3
             obj.V = [[0.0;0.0],[1.0;0.0],[0.0;1.0]];
           else
             obj.V = [v1,v2,v3];
           end
           
           t = [v2-v1];
           L1 = [-t(2);t(1)];
           if L1'*v3 < 0, L1 = -L1; end
           
           t = [v3-v2];
           L2 = [-t(2);t(1)];
           if L2'*v1 < 0, L2 = -L2; end

           t = [v3-v1];
           L3 = [-t(2);t(1)];
           if L3'*v2 < 0, L3 = -L3; end

           obj.L = [L1,L2,L3];
       end
       function bln = contiene(obj,p)
         if nargin == 0
           pv = [0.0;0.0];  
         else
           pv = p;  
         end    
         bln = (pv - obj.V(:,1))' * obj.L(:,1) >= 0 & ...
               (pv - obj.V(:,2))' * obj.L(:,2) >= 0 & ...
               (pv - obj.V(:,3))' * obj.L(:,3) >= 0 ;
       end
       function xtam = valoresExtremos(obj)
          xtam = [[min(obj.V(1,:)); min(obj.V(2,:))],[max(obj.V(1,:)); max(obj.V(2,:))]];
       end
   end
end