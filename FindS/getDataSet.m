function [dataSet,cabeceraTabla,dsFilas,dsColumnas] = getDataSet(filename)
    rt = readtable(filename); % Carga la tabla
    dataSet = table2cell(rt); % Pasamos la tabla a una matriz (la cabecera no la coge)
    cabeceraTabla = rt.Properties.VariableNames; % Esto es solo la cabecera de la tabla (nombre de los campos)
    % [th;dataSet] % Muestra de todo para que se vea bien
    [dsFilas,dsColumnas] = size(dataSet); % Numero de Filas y Columnas del DataSet 
end