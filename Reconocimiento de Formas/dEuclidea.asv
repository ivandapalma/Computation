% Distancia Euclidea
inputMejores = input(mejorCombinacion(:,:),:);

% Calcular el punto medio de cada caracteristica de cada descriptor
% de los 3 mejores
[F C] = size(inputMejores);
PuntoMedio = zeros(3,3);
Circulos = inputMejores(:,1:15);
Cuadrados = inputMejores(:,16:30);
Triangulos = inputMejores(:,31:45);

% Columna 1: Puntos Medios de Circulos
% Columna 2: Puntos Medios de Cuadrados
% Columna 3: Puntos Medios de Triangulos
for i=1:3 
    PuntoMedio(i,1) = mean(Circulos(i,:));
    PuntoMedio(i,2) = mean(Cuadrados(i,:));
    PuntoMedio(i,3) = mean(Triangulos(i,:));
end
x1 = sym('x1','real');
x2 = sym('x2','real');
x3 = sym('x3','real');
X = [x1; x2; x3];
dc = expand(- (X - PuntoMedio(:,1))'*(X - PuntoMedio(:,1)));
ds = expand(- (X - PuntoMedio(:,2))'*(X - PuntoMedio(:,2)));
dt = expand(- (X - PuntoMedio(:,3))'*(X - PuntoMedio(:,3)));

dcs = dc - ds;
dct = dc - dt;
dst = ds - dt;

% RESULTADOS DIFERENCIAS
dcs = 103505093804113/1125899906842624*x1-2444525966715793598559007071224163/2535301200456458802993406410752+454964141775551/140737488355328*x2+770756291180395/35184372088832*x3;
dct = 107223305248805/281474976710656*x1-1228882510856663304102893759407171/633825300114114700748351602688+12137670007270939/562949953421312*x2+6726527388255981/140737488355328*x3;
dst = 325388127191107/1125899906842624*x1-2471004076710859617852567966404521/2535301200456458802993406410752+10317813440168735/562949953421312*x2+3643502223534401/140737488355328*x3;

% Una vez obtenidas las funciones para la frontera de decisión podemos
% proceder a introducir los valores de cada objeto por x1, x2 y x3

[Q W] = size(inputTest);
% Reconocimiento:
distEuc = zeros(3,W);
for i=1:W
    A = inputTest(mejorCombinacion(:,:),i);
    x1=A(1);
    x2=A(2);
    x3=A(3);
    dcsD = double(103505093804113/1125899906842624*x1-2444525966715793598559007071224163/2535301200456458802993406410752+454964141775551/140737488355328*x2+770756291180395/35184372088832*x3);
    dctD = double(107223305248805/281474976710656*x1-1228882510856663304102893759407171/633825300114114700748351602688+12137670007270939/562949953421312*x2+6726527388255981/140737488355328*x3);
    dstD = double(325388127191107/1125899906842624*x1-2471004076710859617852567966404521/2535301200456458802993406410752+10317813440168735/562949953421312*x2+3643502223534401/140737488355328*x3);
    
    distEuc(:,i) = [dcsD; dctD; dstD];
    
    fprintf('\n');
    if (dcsD > 0 && dctD > 0)
        fprintf('%d:Circulo',i)
    elseif (dcsD <= 0 && dstD > 0)
        fprintf('%d:Cuadrado',i)
    elseif (dctD < 0 && dstD < 0)
        fprintf('%d:Triangulo',i)
    else
        fprintf('%d:No se sabe',i)
    end
end
fprintf('\n');

% Fallos: 4 ( No reconoce bien los cuadrados)
