ajustaDistMuBetaLogNormalTrunc=function(parametro,x)
{
  # parametro[1] = mu
  # parametro[2] = sigma
  # x son los valores de los logaritmos de los montos hospitalarios en pesos truncados a mayores de 5000 pesos
  a =  8.517193 #logaritmo natural de 5000
  m = length(x)
  t1 = - m * log(1 - pnorm(a,par_tot[1],par_tot[2]))
  t2 = - m * log(par_tot[2])
  t3 = - 0.5 * sum((x - par_tot[1])^2)/(par_tot[2]^2)
  
  r = -( t1 + t2 + t3 ) # para que minimice
  return(r)  
}
