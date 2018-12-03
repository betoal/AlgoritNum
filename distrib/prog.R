dnormal_truncada <- function(x, mean, sd) 
    dtrunc(x, "norm", a=8.15, b=Inf, mean=mean, sdlog=sdlog)
pnormal_truncada <- function(x, mean, sd) 
    ptrunc(x, "norm", a=8.15, b=Inf, mean=mean, sd=sd)

fitdist(log(x), "normal_truncada", start = c(mean=10, sd=1))
