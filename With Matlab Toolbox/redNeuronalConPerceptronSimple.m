clc; clear; close all;

esAND = 0;
x = [0 0 1 1; 0 1 0 1];

if esAND==1
    t = [0 0 0 1]; % Salidas de funcion AND
else %funcion == 'OR'
    t = [0 1 1 1]; % Salidas de función OR    
end

red = newp([0 1; 0 1],1); % El 1 final es el numero de neuronas
red.iw{1,1}=[1,1];
red.b{1} = 0.5;     % Bias
pesos = red.iw{1,1} % Pesos
bias = red.b{1};
plotpc(pesos,bias);
red = train(red,x,t)

% Hay q darle a PERFORMANCE

figure;
pesos = red.iw{1,1};
bias = red.b{1};
plotpv(x,t)
plotpc(pesos,bias)

% Pruebas

prueba = [0 ; 0];
a = sim(red,prueba)

prueba = [0 ; 1];
a = sim(red,prueba)

prueba = [1 ; 0];
a = sim(red,prueba)

prueba = [1 ; 1];
a = sim(red,prueba)
