% Centro
C1=[1,1];
C2=[2,3];
% Radio
R1=2;
R2=3;

F=@(x) ([(x(1)-C1(1))^2+(x(2)-C1(2))^2-R1^2; (x(1)-C2(1))^2+(x(2)-C2(2))^2-R2^2]);
x1=fsolve(F,[C1(1),C1(1)+R1]);
fprintf('Primer punto: (%f,%f)\n',x1(1),x1(2));
x2=fsolve(F,[C1(1),C1(1)-R1]);
fprintf('Segundo punto: (%f,%f)\n',x2(1),x2(2));

distancia= sqrt(((x2(1)-x1(1))^2)+((x2(2)-x1(2))^2))