clc; clear; close all;

%% PARÁMETRO DE ENTRADA
numDataset = 5; % Del 1 al 4

%% LIST THEN
if numDataset == 1
    filename = 'training.csv';
    columnaComparativa = 4;    
elseif numDataset == 2
    filename = 'training2.csv';
    columnaComparativa = 7;
elseif numDataset == 3
    filename = 'training3.csv';
    columnaComparativa = 4;  
else%if numDataset == 4
    filename = 'training4.csv';
    columnaComparativa = 6;
end

nombreClase = 'negative';
[dataSet,cabecera,dsFilas,dsColumnas] = getDataSet(filename); % Obtenemos el dataset
dataUniques = getUniques(dataSet,columnaComparativa);

[FF CC] = size(dataUniques);
dataUniques(:,CC+1) = cellstr('?');

list = ListThen(dataSet,dataUniques,columnaComparativa,nombreClase);
%list = deleteRepeated(list); 
%% ELIMINATE

eliminate = Eliminate(dataSet,list,columnaComparativa,nombreClase);
eliminate = deleteRepeated(eliminate); % Más rápido

cabecera(columnaComparativa) = [];
solucion = [cabecera;eliminate]
