ajustaDistAlfaLogNormal=function(parametro,x)
{
  # parametro[1] = alfa
  # parametro[2] = mu
  # parametro[3] = sigma
  # x son los valores de los logaritmos de los montos hospitalarios
  
  xp = x^parametro[1]
  l5ka = log(5000)^parametro[1]
  xpa_max = max( xp, l5ka )
  xpa_min = min( xp, l5ka )
  cota_k = xpa_min + (xpa_max - xpa_min )/18*c(0:18)
  hc     = hist(xp,breaks=cota_k,plot=FALSE,include.lowest=FALSE)
  pc_acum=pnorm(cota_k,parametro[2],parametro[3])
  pr = pc_acum[2:19] - pc_acum[1:18]
  spr = max(0.75,sum(pr))
  pr = pr / spr  # normalizo para los valores observados
  r = sum((pr-hc$counts/length(x))^2)

  return(r)  
}
