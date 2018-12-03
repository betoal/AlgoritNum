classdef DocPolynom
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        coef
    end % properties
 % ========================================================          
    methods
 % ========================================================             
        function obj = DocPolynom(c)
          if nargin > 0
            if( isa(c,'DocPolynom') ) 
              obj.coef = c.coef;  
            else
              obj.coef = c(:).';    
            end    
          end    
        end % Constructor
 % ========================================================              
        function obj = set.coef(obj,val)
          if  ~isa(val,'double')
            error('Los coeficientes deben ser doubles')
          end
          ind = find(val(:).' ~= 0 );
          if ~isempty(ind)
              obj.coef = val(ind(1):end);
          else
              obj.coef = val;
          end    
        end %set.coef
 % ========================================================      
        
        function c = double( obj )
          c = obj.coef;   
        end %double
 % ========================================================      
        function str = char( obj )
          if all(obj.coef == 0 )
            s = '0';
            str = s;
            return
          else
            d   = length(obj.coef) - 1;
            s   = cell(1,d);
            ind = 1;
            for a = obj.coef
              if a ~= 0
                if ind ~= 1
                  if a > 0
                     s(ind) = {' + '};
                  else    
                     s(ind) = {' - '};
                     a = -a;
                  end %% if a > 0
                  ind = ind + 1;
                end %% if ind~= 1
                if a ~= 1 || d == 0
                  if a == -1
                    s(ind) = {' - '};  
                  else
                    s(ind) = {num2str(a)};
                    if d > 0
                      ind = ind + 1;
                      s(ind) = {'*'};
                    end  
                  end %% if a == -1
                  ind = ind + 1;
                end %% a ~= 1 || ...      
                if d >= 2
                  s(ind) = {['x^' int2str(d)]};
                elseif d == 1
                  s(ind) = {'x'};  
                end %% if d >= 2
                ind = ind + 1;
              end %% if a ~= 0
              d = d - 1;
            end %% for a = obj.coef 
          end %% all(obj.coef == 0 )    
          str = [s{:}];    
        end % char    
 % ========================================================            
        function disp( obj )
          c = char(obj);
          if iscell(c)
            disp(['     ' c{:}])  
          else
            disp(c)  
          end    
        end  %% disp 
 % ========================================================      
        function dispPoly( obj,x )
          p = char(obj);
          e = @(x)eval(p);
          y = zeros(length(x));
          disp(['y = ' p])
          for k = 1:length(x)
            y(k) = e(x(k));
            disp(['f(x = ' num2str(x(k)),') = ' num2str(y(k))])
          end     
        end %% dispPoly    
 % ========================================================      
        function b = subsref(a,s)
          switch s(1).type
            case '()'
                ind = s.subs{:};
                b   = polyval(a.coef,ind);
            case '.'
                switch s(1).subs
                case 'coef'
                      b = a.coef;
                case 'disp'
                      disp(a)
                otherwise
                      if length(s) > 1
                        b = a.(s(1).subs)(s(2).subs{:});
                      else
                        b = a.(s.subs);  
                      end    
                end
            otherwise
                    error('Specify value for x as obj(x)')          
          end  
        end %% subsref
 % ========================================================
 function r = plus(obj1,obj2)
   obj1 = DocPolynom(obj1);
   obj2 = DocPolynom(obj2);
   k = length(obj2.coef) - length(obj1.coef);
   zp = zeros(1,k);
   zm = zeros(1,-k);
   r = DocPolynom( [zp,obj1.coef] + [zm,obj2.coef]);
 end %% plus
 % ========================================================
 function r = minus(obj1,obj2)
   obj1 = DocPolynom(obj1);
   obj2 = DocPolynom(obj2);
   k = length(obj2.coef) - length(obj1.coef);
   zp = zeros(1,k);
   zm = zeros(1,-k);
   r = DocPolynom( [zp,obj1.coef] - [zm,obj2.coef]);    
 end 
 % ========================================================
 function r = mtimes(obj1,obj2)
   obj1 = DocPolynom(obj1);
   obj2 = DocPolynom(obj2);
   r = DocPolynom( conv(obj1.coef,obj2.coef) );        
 end  %% mtimes
 % ========================================================
    end  % methods
 % ========================================================      
   
end

