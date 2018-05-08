%SALINAS HERNANDEZ LUIS ANGEL
% limpiamos las variables
clearvars;

% Se pide la opcion del usuario para la manera de resolver el problema
fprintf(1, 'Red Adaline\n');
fprintf(1, '\t1.- Red sin bias\n\t2.- Red con bias\n\totro.- Salir\n\n');
opcion = input('Ingresa tu opcion: ');

if opcion == 1
    %----------------------------RED SIN BIAS
    fprintf(1, 'Red sin bias\n');

    % Pedimos los valores al usuario
    bits = input('Ingresa el numero de bits de la tabla: ');
    itmax = input('Ingresa el valor de itmax: ');
    EitUsuario = input('Ingresa el valor esperado de Eit: ');
    alfa = input('Ingresa el factor de aprendizaje alfa: ');
    
    %Generamos la tabla de verdad
    if bits >= 0 && bits<= 3
        for i = 1:(2^bits)
            binario = dec2bin(i-1);
            while(length(binario) < bits)
                binario = strcat('0',binario);
            end;
            tabla(i,:) = strcat(binario, num2str(i-1));
        end;
        
        %Se pasan los valores de la tabla a una matriz de enteros
        [filas, columnas] = size(tabla);
        for i = 1:filas
            for j = 1:columnas
                Mat(i, j) = str2num(tabla(i, j));
            end;
        end;
        
        % Se obtienen los vectores de entrada y target a partir de la
        % matriz
        P = Mat(:, [1:bits]);
        T = Mat(:, bits+1);
        
        % Se obtiene el tama?o de cada vector de entrada y target
        [filasP, R] = size(P);
        [filasT, S] = size(T);
        
        % Se genera aleatoriamente la matriz de pesos
        for i = 1:S
            for j = 1:R
               W1(i,j) = rand(); 
            end;
        end;
        
        % Se guardan los valores de las variables de pesos y bias en archivos 
        save('resultadosAdalineW.txt', 'W1', '-ascii');
         
        %Se inicia el proceso de aprendizaje
        Eit = 0;
        save('resultadosAdalineE.txt', 'Eit', '-ascii');
        for iteraciones = 1:itmax
            for i = 1:filasP
                a = purelin(W1 * P(i,:)');
                e(i) = T(i)-a;
                W2 = (W1 + (2 * alfa * e(i) * P(i,:)));
                W1 = W2;
                save('resultadosAdalineW.txt', 'W1', '-ascii', '-append');
            end;
            Eit = mean(e);
            save('resultadosAdalineE.txt', 'Eit', '-ascii', '-append');
            i = 1;

            %Condici?n de finalizaci?n por Eit
            if Eit <= EitUsuario
                fprintf(1, 'La red converge en la iteracion %d\n',iteraciones);
                fprintf(1, 'W: '); disp(W1); 
                break;
            end;       
        end;

        % Condici?n de finalizaci?n por itmax
        if Eit > EitUsuario
            fprintf(1, 'Se llego al numero maximo de iteraciones sin que la red presentara convergencia\n');
        end;
        
        % Graficamos la evolucion de los pesos, los bias y el error cargando
        % sus valores de los archivos correspondientes
        Errores = load('resultadosAdalineE.txt', 'Eit', '-ascii');
        Pesos = load('resultadosAdalineW.txt', 'W1', '-ascii');
        subplot(1,2,1);
        plot(Errores); grid on;
        title('Eit');

        subplot(1,2,2);
        plot(Pesos); grid on;
        title('W');          
    else
        fprintf(1, 'El numero maximo de bits es 3\n');
    end;
    
elseif opcion == 2
    %----------------------------RED CON BIAS
    fprintf(1, 'Red con bias\n');
    
    % Se obtienen los vectores de entrada de un archivo
    % fid = fopen('prueba1.txt', 'r+');
    P = [1 -1 -1; 1 1 -1; 1 1 1; -1 -1 -1];
    T = [0; 1; 0; 1];
    
    % Pedimos los valores al usuario
    itmax = input('Ingresa el valor de itmax: ');
    EitUsuario = input('Ingresa el valor esperado de Eit: ');
    alfa = input('Ingresa el factor de aprendizaje alfa: ');
    
    % Se obtiene el tama?o de cada vector de entrada y target
        [filasP, R] = size(P);
        [filasT, S] = size(T);
        
        % Se generan aleatoriamente la matriz de pesos y el vector bias
        for i = 1:S
            for j = 1:R
               W1(i,j) = rand(); 
            end;
        end;
        
        for i=1:S
            b1(1,i) = rand();
        end; 
        
        % Se guardan los valores de las variables de pesos y bias en archivos 
        save('resultadosAdalineW.txt', 'W1', '-ascii');
        save('resultadosAdalineB.txt', 'b1', '-ascii');
         
        %Se inicia el proceso de aprendizaje
        Eit = 0;
        save('resultadosAdalineE.txt', 'Eit', '-ascii');
        for iteraciones = 1:itmax
            for i = 1:filasP
                a = purelin(W1 * P(i,:)' + b1);
                e(i) = T(i)-a;
                W2 = (W1 + (2 * alfa * e(i) * P(i,:)));
                b2 = (b1 + e(i));
                W1 = W2;
                b1 = b1;
                save('resultadosAdalineW.txt', 'W1', '-ascii', '-append');
                save('resultadosAdalineB.txt', 'b1', '-ascii', '-append');
            end;
            Eit = mean(e);
            save('resultadosAdalineE.txt', 'Eit', '-ascii', '-append');
            i = 1;

            %Condici?n de finalizaci?n por Eit
            if Eit <= EitUsuario
                fprintf(1, 'La red converge en la iteracion %d\n',iteraciones);
                fprintf(1, 'W: '); disp(W1); 
                fprintf(1, 'b: '); disp(b1);
                break;
            end;       
        end;

        % Condici?n de finalizaci?n por itmax
        if Eit > EitUsuario
            fprintf(1, 'Se llego al numero maximo de iteraciones sin que la red presentara convergencia\n');
        end;
        
        % Graficamos la evolucion de los pesos, los bias y el error cargando
        % sus valores de los archivos correspondientes
        Errores = load('resultadosAdalineE.txt', 'Eit', '-ascii');
        Pesos = load('resultadosAdalineW.txt', 'W1', '-ascii');
        Bias = load('resultadosB.txt', 'b1', '-ascii');
        
        subplot(1,3,1);
        plot(Errores); grid on;
        title('Eit');

        subplot(1,3,2);
        plot(Pesos); grid on;
        title('W');

        subplot(1,3,3);
        plot(Bias); grid on;
        title('b');
  
    %fclose(fid);

else
    %----------------------------OTRO
    fprintf(1, 'Gracias\n');
end;