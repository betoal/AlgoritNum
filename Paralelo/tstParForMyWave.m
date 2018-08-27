tic
job = batch('mywaveParFor','Pool',2)
wait(job)
load(job,'A')
toc
plot(A)
delete(job)
clear job
