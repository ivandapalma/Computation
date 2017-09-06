% Plano de separabilidad

% Representacion de combinaciones en graficas

path(path,'../Funciones');
titulos = ['Compacticidad';'Excentricidad';'BoundingBox  ';'ConvexHull   ';'EulerNumber  ';'Hu1          ';'Hu2          ';'Hu3          ';'Hu4          ';'Hu5          ';'Hu6          ';'Hu7          '];
load('../Fase_3_Clases_Conflictivas/inputsYoutputs.mat');

input = inputDQ;
output = outputDQ;

% PASO 1: OBTENER GRADO DE SEPARABILIDAD

gradoSep_J = zeros(12,1);
[F C] = size(input);
for i=1:2:(F-1)
    X = i;
    Y = i+1;
    gradoSep_J(X) = indiceJ(input(X,:),output); % Cálculo del grado de separabilidad J
    gradoSep_J(Y) = indiceJ(input(Y,:),output);
end

% PASO 2: OBTENCION DE LAS 6 CARACTERISTICAS MÁS RELEVANTES
mejores = zeros(6,1);
gradoJ = gradoSep_J; % Tratamos con una copia
for i=1:6
    index = find(gradoJ==max(gradoJ)); % Buscamos el índice del mejor
    mejores(i) = index; % Obtenemos los índices de los mejores
    gradoJ(index) = -inf; % Lo ponemos a - infinito para que no vuelva a ser el mejor
end

% PASO 3: SELECCION FINAL DE 3 CARACTERISTICAS. CALCULO DE LA MEJOR
% COMBINACION DE 3
combinaciones = combnk(mejores,3);
[F C] = size(combinaciones);
sepa = zeros(1,F);
for i=1:F
    I = input(combinaciones(i,:),:); % Devuelve las 3 columnas de cada combinacion
sepa(i) = indiceJ(I,output); % Separabilidad conjunta
end
indexMayorSepa = find(sepa==max(sepa)); % Obtenemos los índices de los mejores
mejorCombinacion = combinaciones(indexMayorSepa,:);

% Graficas 3D
load('../Fase_1_Entrenamiento/dataTraining.mat');
plot3(input_Norm(mejorCombinacion(1),output==4),input_Norm(mejorCombinacion(2),output==4),input_Norm(mejorCombinacion(3),output==4),'rO'),
hold on,   
plot3(input_Norm(mejorCombinacion(1),output==17),input_Norm(mejorCombinacion(2),output==17),input_Norm(mejorCombinacion(3),output==17),'b*'),
hold on,
xlabel(titulos(mejorCombinacion(1),:));
ylabel(titulos(mejorCombinacion(2),:));
zlabel(titulos(mejorCombinacion(3),:));
grid on






% CREAR PLANO DE SEPARABILIDAD A PARTIR DELA FORMULA DE SEPARABILIDAD
% CALCULADA PARA CADA DOS CARACTERISTICAS
% Calcular el punto medio de cada caracteristica de cada descriptor
% de los 3 mejores
inputMejores = input(mejorCombinacionDQ,:);
[F C] = size(inputMejores);
Ds = inputMejores(:,outputDQ==4);
Qs = inputMejores(:,outputDQ==17);


PuntoMedio = zeros(2,3);
PuntoMedio(1,1) = mean(Ds(1,:)); % Fila 1: Puntos Medios Clase 1
PuntoMedio(1,2) = mean(Ds(2,:));
PuntoMedio(1,3) = mean(Ds(3,:));
PuntoMedio(2,1) = mean(Qs(1,:)); % Fila 2: Puntos Medios Clase 2
PuntoMedio(2,2) = mean(Qs(2,:));
PuntoMedio(2,3) = mean(Qs(3,:));


x1 = sym('x1','real');
x2 = sym('x2','real');
x3 = sym('x3','real');
X = [x1; x2; x3];
d1 = expand(- (X - PuntoMedio(1,:)')' * (X - PuntoMedio(1,:)'));
d2 = expand(- (X - PuntoMedio(2,:)')' * (X - PuntoMedio(2,:)'));

D = d1 - d2;

% RESULTADO DIFERENCIA
% D = 558665656950196202547531511112885/10141204801825835211973625643008 - (2373026027438081*x2)/281474976710656 - (53888118533287*x3)/1125899906842624 - (1052285702535763*x1)/2251799813685248;

% Una vez obtenidas las funciones para la frontera de decisión podemos
% proceder a introducir los valores de cada objeto por x1, x2 y x3
A = - 1052285702535763/2251799813685248;
B = - 2373026027438081/281474976710656;
C = - 53888118533287/1125899906842624;
D = 558665656950196202547531511112885/10141204801825835211973625643008;

% Ax + By + Cz + D = 0  ->  z = - (Ax + By + D) / C

plot3(input_Norm(mejorCombinacion(1),output==4),input_Norm(mejorCombinacion(2),output==4),input_Norm(mejorCombinacion(3),output==4),'rO'),
hold on,   
plot3(input_Norm(mejorCombinacion(1),output==17),input_Norm(mejorCombinacion(2),output==17),input_Norm(mejorCombinacion(3),output==17),'b*'),
hold on,
xlabel(titulos(mejorCombinacion(1),:));
ylabel(titulos(mejorCombinacion(2),:));
zlabel(titulos(mejorCombinacion(3),:));

for x=-0.5:0.01:1
    for y=-0.06:-0.002:-0.14
        hold on,
        z = -(A*x + B*y+ D) / C;        
        plot3(x,y,z,'y*');
    end
end


hold off