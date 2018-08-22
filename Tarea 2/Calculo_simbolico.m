%% Handle vs Symbolic

f = @(x) x^2 -5;            % Se crea la función Handle
f(3)

fs = sym(f);                % Función simbólica de la Handle
fsp = diff(fs)              % Derivada de la simbólica

fp = matlabFunction(fsp)    % Evaluación de la simbólica

%% Newton´s Method
% x1 = x0 - f(x0)/f´(xo)
tic
raizNewton(f,500,1e-3)
toc

% Para cambiar la funcion
tic
raizNewton(@(x) x^3,5,1e-3)
toc