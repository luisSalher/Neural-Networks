% Serie de Fibonacci
% Salinas Hern?ndez Luis Angel

n = input('Ingresa el numero de terminos a calcular en la serie de Fibonacci: ');
f = zeros(1,n);
q = zeros(1,n);
num = (1:1:n);

%PRUEBA DE CAMBIOS

f(1) = 1;
f(2) = 1;

for i=3:1:n
    f(i) = f(i-1) + f(i-2);
end

disp('La serie de Fibonacci es: ');
disp(f);

plot(f);







