syms w
l1 = 30;
l2 = 20;
c = 10;
findEq = 1 / sqrt(l1^2 - w^2) + 1 / sqrt(l2^2 - w^2) - 1 / c;
w = rootNewton2(findEq, 0.1, 1)