[tablaVerdadEntradas tablaVerdadSalidas] = crearTablaVerdad(numeroEntradas,esAND);
% w y theta calculados en Script: perceptronSimple (ejecutar primero)

n = 0.25;
nombresX = [];
nombresY = [];
X = [];
Y = [];
for i=1:numeroFilas
    x = tablaVerdadEntradas(i,:); % Fila de las X de las entradas
    y = funcionActivacion(dot(x,w) - theta); % 1: Umbral  0: bipolar
    X = [X ; x];
    Y = [Y ; y];
end

solucion = [X Y]