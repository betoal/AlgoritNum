classdef FiguraCompuesta
   properties
     figs
     num_figs
     que_interseccion_cuenta
   end
   methods 
       function obj = FiguraCompuesta(Figs,intersecc_cta) % Constructor del objeto
           if nargin == 0
             vf1 = Circulo([0;0],1);
             vfs = {};
             vfs{1} = vf1;
             cuenta = [1];
           else
             vfs = Figs;
             cuenta = intersecc_cta;
           end  
           obj.figs = vfs;
           obj.que_interseccion_cuenta = cuenta;
           obj.num_figs = max(size(obj.figs));
       end
       function bln = contiene(obj,p) % Función estática
         if nargin == 0
           pv = [0.0;0.0];  
         else
           pv = p;  
         end
         esta = zeros(1,obj.num_figs); % Matriz con número de figuras.
         for f = 1:obj.num_figs % Prende el bit que le corresponde a cada figura.
           esta(f) = 2^(f-1) * obj.figs{f}.contiene(pv); % El objeto figura es el que checa si está en la figura.
         end
         donde_esta = sum(esta); % Se tiene qué intersección cuenta.
         if donde_esta == 0
           donde_esta = 2^obj.num_figs;  
         end    
         bln = obj.que_interseccion_cuenta(donde_esta);
       end
       
       function xtam = valoresExtremos(obj)
          extremos=zeros(2,2,obj.num_figs);
          for f = 1:obj.num_figs
            extremos(:,:,f) = obj.figs{f}.valoresExtremos();
          end
          xtam = [[min(extremos(1,1,:));min(extremos(2,1,:))], ...
                  [max(extremos(1,2,:));max(extremos(2,2,:))]];
       end
   end
end