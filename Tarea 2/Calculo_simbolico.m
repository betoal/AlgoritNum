%% Handle vs Symbolic

f = @(x) x^2 -5;            % Se crea la funci�n Handle
f(3)

fs = sym(f);                % Funci�n simb�lica de la Handle
fsp = diff(fs)              % Derivada de la simb�lica

fp = matlabFunction(fsp)    % Evaluaci�n de la simb�lica

%% Newton�s Method
% x1 = x0 - f(x0)/f�(xo)
tic
raizNewton(f,500,1e-3)
toc

% Para cambiar la funcion
tic
raizNewton(@(x) x^3,5,1e-3)
toc