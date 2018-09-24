function yLag = interpLagrange(xi,yi,xVal)

n = length(xi);
if length(yi)~=n
    error('Los vectores no tienen la misma longitud');
end

sum = 0;
for i=1:n
    product = yi(i);
    for j=1:n
        if j~=i
            product = product*(xVal-xi(j))/(xi(i)-xi(j)); % Cálculo de productos Lagrange
        end
    end
    sum = sum + product;
end
yLag = sum;
end