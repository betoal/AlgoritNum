sched = parcluster('local') % Echa a andar el parallel cluster local

job = createJob(sched) % Corre el job que necesita

% Se manda el trabajo con N jobs. Construcción base del job.
%createTask(job,@propAreasIntersecc,1,                   {});
%createTask(job,@propAreasIntersecc,[1 1],             { {} {} });
%createTask(job,@propAreasIntersecc,[1 1 1],           { {} {} {} });
createTask(job,@propAreasIntersecc,[1 1 1 1],         { {} {} {} {} });
%createTask(job,@propAreasIntersecc, [1 1 1 1 1],      { {} {} {} {} {}});
%createTask(job,@propAreasIntersecc, [1 1 1 1 1 1],    { {} {} {} {} {} {}});
%createTask(job,@propAreasIntersecc, [1 1 1 1 1 1 1],  { {} {} {} {} {} {} {}});
%createTask(job,@propAreasIntersecc, [1 1 1 1 1 1 1 1],{ {} {} {} {} {} {} {} {}});
%createTask(job,@propAreasIntersecc, [1 1 1 1 1 1 1 1 1],{ {} {} {} {} {} {} {} {} {}});
%createTask(job,@propAreasIntersecc, [1 1 1 1 1 1 1 1 1 1],{ {} {} {} {} {} {} {} {} {} {}});

tic
submit(job); % Jala el job

wait(job) % Espera a que termine el job
sal = fetchOutputs(job); % Jalar la salida del job.
toc

% Se ve la salida de cada tarea.
sal{1}
sal{2}
sal{3}
sal{4}
%sal{5}
%sal{6}
%sal{7}
%sal{8}
%sal{9}
%sal{10}

destroy(job) % Para liberar el trabajo. Liberar recursos.
