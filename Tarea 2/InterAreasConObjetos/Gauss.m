classdef Gauss
    properties
        norm
        mu
        sd
    end
    methods
        function obj = Gauss(mu,sigma)
            if nargin == 0
                mu = 0;
                sigma = 1;
            end
            normal = @(x) exp((-(x-mu)^2)/(2*(sigma^2)));
            obj.norm = normal;
            obj.mu = mu;
            obj.sd = sigma;
        end
        function bln = contiene(obj,p)
            if nargin == 0
                pv = [0.0;0.0];
            else
                pv = p;
            end
            bln = pv(2) <= obj.norm(pv(1));
        end
        function xtam = valoresExtremos(obj)
            xtam = [[0;obj.norm(0)], ...
                 [obj.mu+obj.sd;obj.norm(obj.mu+obj.sd)]];
        end
        function area = densidadArea(obj)
            area = normcdf(xtam,obj.mu,obj.sd);
        end
    end
end
            