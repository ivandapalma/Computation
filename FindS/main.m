clc; clear; close all;

%% PARÁMETRO DE ENTRADA
numDataset = 1; % Del 1 al 4

%%
if numDataset == 1
    filename = 'training.csv';
    columnaComparativa = 4;    
elseif numDataset == 2
    filename = 'training2.csv';
    columnaComparativa = 7;
elseif numDataset == 3
    filename = 'training3.csv';
    columnaComparativa = 4;  
elseif numDataset == 4
    filename = 'training4.csv';
    columnaComparativa = 6;    
end

[dataSet,cabecera,dsFilas,dsColumnas] = getDataSet(filename); % Obtenemos el dataset
fs = FindS(dataSet,dsFilas,dsColumnas,columnaComparativa);
%solucionFinal = [cabecera;fs]
cabecera(columnaComparativa) = []
fs(columnaComparativa) = []