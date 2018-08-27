tic
job = batch('mywave')
wait(job)
load(job,'A')
toc
plot(A)
delete(job)
clear job
