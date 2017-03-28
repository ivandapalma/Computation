function dataUniques = getUniques(dataSet,columnaComparativa)

    newDataSet = dataSet;
    newDataSet(:,columnaComparativa) = []; % La columna comparativa no hace falta
    [numFilas, numColumnas] = size(newDataSet);
    
    maxUnicos = 0;
    for i=1:numColumnas % Obtenemos primero el numero máximo de unicos
        [F,C] = size(unique(newDataSet(:,i)));
        if( F > maxUnicos)
            maxUnicos = F;
        end
    end
    
    dataUniques = cell(numColumnas,maxUnicos); % Tabla (cell) con los elementos unicos de cada columna
    for i=1:numColumnas
       columna = unique(newDataSet(:,i))';
       [F,C] = size(columna);
       for j=1:C
           dataUniques(i,j) = columna(j);           
       end       
    end
    
    
    [F,C] = size(dataUniques); % Cambiamos los vacios por la palabra '?'
    for i=1:F
        for j=1:C
            if(isempty(dataUniques{i,j})==1)
               dataUniques{i,j} = '?';
            end            
        end
    end
end