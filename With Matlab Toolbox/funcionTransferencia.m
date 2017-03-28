clc; clear; close all;

esAND = 0;
x = [0 0 1 1; 0 1 0 1];

if esAND==1
    t = [0 0 0 1]; % Salidas de funcion AND
else %funcion == 'OR'
    t = [0 1 1 1]; % Salidas de función OR    
end

red = perceptron;
red = train(red,x,t);
view(red)
y = red(x);

figure;
pesos = red.iw{1,1};
bias = red.b{1};
plotpv(x,t)
plotpc(pesos,bias)

% Darle a performance

% Pruebas
%{
prueba = [0 ; 0];
a = sim(red,prueba)

prueba = [0 ; 1];
a = sim(red,prueba)

prueba = [1 ; 0];
a = sim(red,prueba)

prueba = [1 ; 1];
a = sim(red,prueba)
%}