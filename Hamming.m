%SALINAS HERNANDEZ LUIS ANGEL

fprintf(1, 'Red de Hamming\n');
% limpiamos las variables
clearvars;

% Se obtienen los vectores prototipos de un archivo
fid = fopen('prueba1.txt', 'r+');

% Se obtiene el tamano de filas y columnas de la matriz de pesos 
[filas, columnas] = size(W);

% Creamos el vector bias
for i = 1:filas
    b(i,1) = columnas;
end;

% Capa feed foward
A1 = (W*p)+b;
salida = A1';
save('salidas.txt', 'salida', '-ascii');

% Obtenemos el valor de epsilon de forma aleatoria
inferior = 0;
superior = 1/(filas-1);
epsilon = inferior + (superior-inferior) * rand(); 

% Generamos la matriz W2
for i = 1:filas
    for j = 1:filas
        if i == j
            W2(i,j) = 1;
        else
            W2(i,j) = (-epsilon);
        end;
    end;
end;

it = 1;
% Iteraciones de la capa recurrente
while(it)
    A2 = poslin(W2*A1);
    salida = A2';
    save('salidas.txt', 'salida', '-ascii', '-append');
    if A2 == A1
        fprintf('La red converge en la iteracion %d\n', it);
        break;
    end;    
    A1 = A2;
    it = it + 1;
end;  

% Mostramos la clase a la que pertence la red
for i = 1:filas
    if salida(1,i) ~= 0
        fprintf('La red converge a la clase %d de los patrones prototipo\n',i);
    end;
end;

% Graficamos el comportamiento de la salida de la red cargando todos los
% valores obtenidos de un archivo
salidas = load('salidas.txt', 'salida', '-ascii');
plot(salidas);

fclose(fid);


