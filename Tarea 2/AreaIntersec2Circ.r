install.library("tictoc")
tic('Ejecutando la simulacion de los lanzamientos de los puntos...')
M = 500
N = 200
K = 100
R = 2.0
R2 = R * R
C=matrix(c(-1,1,0,0,R,R),3,2,byrow=TRUE)
A=matrix(rep(0,M*N),nrow=M,ncol=N)
xmax = max(C[1,1]+R,C[1,2]+R)
xmin = min(C[1,1]-R,C[1,2]-R)
ymax = max(C[2,1]+R,C[2,2]+R)
ymin = min(C[2,1]-R,C[2,2]-R)
dx   = xmax - xmin
dy   = ymax - ymin
dxdy = dx * dy

for( n in 1:N )
{
  k = K * n
  for( m in 1:M )
  {
    x = runif(k,xmin,xmax)
    y = runif(k,ymin,ymax)
    d1 = ((x-C[1,1])*(x-C[1,1]) + (y-C[2,1])*(y-C[2,1]) <= R2)
    d2 = ((x-C[1,2])*(x-C[1,2]) + (y-C[2,2])*(y-C[2,2]) <= R2)
    d = length(which(d1 & d2))
    A[m,n] = dxdy * d/k
  }
}
toc()  
At=(2/3*pi -sqrt(3)/2)*R2
mA=colMeans(A)
p = At / dxdy
st=dxdy*sqrt(p*(1-p))
sA=rep(0,N)
for(n in c(1:N)) sA[n]=sd(A[,n])
stA = st/sqrt((1:N)*K)

xg=c(1,N)
yg=c(max(A),min(A))
plot(xg,yg,type='p',col="white")
for(n in c(1:N)) points(rep(n,M),A[,n],col='gray')
points((1:N),mA*rep(1,N))
lines((1:N),At*rep(1,N),col='red')
points((1:N),mA+sA,col='green')
points((1:N),mA+sA,col='red')
points((1:N),mA-sA,col='red')
lines((1:N),At+stA,col='blue')
lines((1:N),At-stA,col='blue')
 



