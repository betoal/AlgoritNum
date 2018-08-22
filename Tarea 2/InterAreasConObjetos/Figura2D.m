classdef Figura2D < handle
    % Representa la clase base para figuras cerradas planas
  
    properties
      centro
    end
    
    methods
        function obj = Figura2D(x)
            if nargin == 0
              obj.centro =[0.0;0.0];
            else
              obj.centro = x;
            end
        end    
        function bln = contiene(obj,p)
          if nargin == 0  
            pv = [0;0];
          else
            pv = p;  
          end
          bln = true; %pv'*pv > 0;
        end    
    end
end

