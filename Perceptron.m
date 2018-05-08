%SALINAS HERNANDEZ LUIS ANGEL
% limpiamos las variables
clearvars;

% Se obtienen los vectores de entrada de un archivo
%fid = fopen('prueba1.txt', 'r+');
P = [1 -1 -1; 1 1 -1; 1 1 1; -1 -1 -1; 1 -1 1; -1 -1 1];
T = [0; 1; 1; 0; 0; 1];

% Se pide la opcion del usuario para la manera de resolver el problema
fprintf(1, 'Perceptron simpe\n');
fprintf(1, '\t1.- Metodo grafico\n\t2.- Regla de aprendizaje\n\totro.- Salir\n\n');
opcion = input('Ingresa tu opcion: ');

%----------------------------METODO GRAFICO
if opcion == 1  
    fprintf(1, 'Metodo Grafico\n');
    % Se obtiene el tama?o de cada vector de entrada y target
    [filasP, R] = size(P);
    [filasT, S] = size(T);
    
    if R == 2
        plot(P, '*');
    elseif R == 3
        for i = 1:filasP
            plot3(P(i,1), P(i,2), P(i,3), '-*')
        end;    
    end;
    

%----------------------------PROCESO DE APRENDIZAJE
elseif opcion == 2
    fprintf(1, 'Proceso de aprendizaje\n');
    % Se obtiene el tama?o de cada vector de entrada y target
    [filasP, R] = size(P);
    [filasT, S] = size(T);
    
    % Se piden al usuario los valores de los criterios de finalizacion
    itmax = input('Ingresa el valor de itmax: ');
    EitUsuario = input('Ingresa el valor esperado de Eit: ');

    %Se generan valores aleatorios para la matriz de pesos y el bias
    for i = 1:S
        for j = 1:R
           W1(i,j) = 50 * randn(); 
        end;
    end;
    
    for i=1:S
        b1(1,i) = 50 * randn();
    end;    
    disp(W1); disp(b1);
    
    % Se guardan los valores de las variables de pesos y bias en archivos 
    save('resultadosW.txt', 'W1', '-ascii');
    save('resultadosB.txt', 'b1', '-ascii');
    
    %Se inicia el proceso de aprendizaje
    Eit = 0;
    save('resultadosE.txt', 'Eit', '-ascii');
    for iteraciones = 1:itmax
        for i = 1:filasP
            a = hardlim(W1 * P(i,:)' + b1);
            e(i) = T(i)-a;
            W2 = (W1 + (e(i) * P(i,:)));
            b2 = (b1 + e(i));
            W1 = W2;
            b1 = b2;
            save('resultadosW.txt', 'W1', '-ascii', '-append');
            save('resultadosB.txt', 'b1', '-ascii', '-append');
        end;
        Eit = mean(e);
        save('resultadosE.txt', 'Eit', '-ascii', '-append');
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
    Errores = load('resultadosE.txt', 'Eit', '-ascii');
    Pesos = load('resultadosW.txt', 'W1', '-ascii');
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
    
%----------------------------OTROS    
else
    fprintf(1, 'Gracias\n');
end;

%fclose(fid);
