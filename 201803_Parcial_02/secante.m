function x = secante(f,a,b,eps)
  fa = f(a);
  fb = f(b);
  while( abs(a-b)>eps)
    x = b + fb *(b-a)/(fa-fb);
    fx = f(x);
    if( fx == 0 )
        a = x;
        b = x;
    else
      if( fa*fx < 0 )
          b  = x;
          fb = fx;
      else
          a  = x;
          fa = fx;
      end
    end
  end    
end