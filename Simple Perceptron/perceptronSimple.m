clc; clear;

%% PARÁMETROS DE ENTRADA

numeroEntradas = 3;
esAND = 0;

% Creación de la tabla de verdad
[tablaVerdadEntradas tablaVerdadSalida] = crearTablaVerdad(numeroEntradas,esAND);

%% FIN PARÁMETROS ENTRADA. COMIENZO DEL ENTRENAMIENTO
[numeroFilas numeroColumnas] = size(tablaVerdadEntradas);

indice = 1; % Empezamos el entrenamiento por la primera fila de la tabla
w = rand(1,numeroColumnas); % Pesos iniciales aleatorios
theta = rand;

% Redondeo a 2 decimales
w = round(w*10^2)/10^2;
theta = round(theta*10^2)/10^2;
n = 0.25;
delta = 1; % Inicializamos el error a distinto de uno para que entre en el bucle

filasCorrectas = 0;

while(filasCorrectas < numeroFilas)
    
    x = tablaVerdadEntradas(indice,:);
    D = tablaVerdadSalida(indice);
    Y = funcionActivacion(dot(x,w) - theta); % 0: bipolar | 1: Umbral
    delta = D - Y; % Error 
    % Cálculo de nuevos pesos y theta (solo se ejecuta si existe error)
    if delta ~= 0 
        filasCorrectas = 0; % Vuelve a hacer otra vez todas las filas

        A = n * delta * x; 
        w = w + A;
        theta = theta - n * delta;
    else
        filasCorrectas = filasCorrectas + 1;
        indice = indice + 1;
        if indice > numeroFilas
            indice = 1;
        end
    end
end

% solución entrenamiento
w
theta