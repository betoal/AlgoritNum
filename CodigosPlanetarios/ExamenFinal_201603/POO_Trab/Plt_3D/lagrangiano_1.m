G  = 6.67408E-11;             %%  Nw metros^2 Kg^(-2)
MT = 5.9736E+24;              %% Kg
ML = 7.349E+22;               %% Kg
dL = 3.832097031205720e+08;   %% metros
wL = 2*pi/(27.321661*86400);  %% rad/seg
%
f = @(dm)( G*( MT/((dL+dm)^2) + ML / ( dm^2) ) - (wL^2) * (dL + dm));
%
dm = raizPorNewton(f,20E6,1,1000);
%
dm
