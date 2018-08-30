classdef Gauss
    properties
        norm
        mu
    end
    methods
        function obj = Gauss(mu,sigma)
            obj.norm = exp((-(sym(X)-mu)^2)/(2*(sigma^2)));
            obj.mu = mu;
        end
        function bln = contiene(obj,p)
            if nargin == 0
                pv = [0.0;0.0];
            else
                pv = p;
            end
            y = pv(2);
            syms x = pv(1);
            bln = y <= obj.norm;
        end
        %function xtam = valoresExtremos(obj)
        %  xtam = [[obj.mu-obj.radio;obj.centro(2)-obj.radio], ...
        %          [obj.centro(1)+obj.radio;obj.centro(2)+obj.radio]];
        %end
    end
end
            