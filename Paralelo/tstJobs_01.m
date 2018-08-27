sched = parcluster('local')

job = createJob(sched)

createTask(job,@sum,1,{{rand(10000000,1)} {rand(10000000,1)} {rand(10000000,1)}});
%createTask(job,@prod,1,{[2 4]});
%createTask(job,@prod,1,{[2 5]});
tic
submit(job);

wait(job)
job.fetchOutputs
toc
destroy(job)
