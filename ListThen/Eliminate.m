function list = Eliminate(dataSet,list,columnaComparativa,nombreClase)
% Si la fila es positiva, se quitan los que NO sean compatibles.
% Si la fila es negativa, se quitan los que SÍ coincidan.
    dataSetCopia = dataSet;
    dataSetCopia(:,columnaComparativa) = [];
    [Fd Cd] = size(dataSetCopia);
    
    % IMPORTANTE: Comprobar que las tiene el mismo numero de columnas
    
    for i=1:Fd % Filas del dataSet
        fila1 = dataSetCopia(i,:);
        filaOriginal = dataSet(i,:);
        clase = filaOriginal(columnaComparativa);     
        indicesEliminar = [];   
        [Fl Cl] = size(list);
        for j=1:Fl
            fila2 = list(j,:);
            if(strcmp(clase,'positive') == 1 || strcmp(clase,' positive') == 1 || strcmp(clase,'+') == 1 || strcmp(clase,' +') == 1)            

                if(filasCompatibles(fila1,fila2) == false)
                    indicesEliminar = [indicesEliminar; j];
                end            

            else % NEGATIVO -> TERMINAR
                
                if(filasCompatibles(fila1,fila2) == true)
                    indicesEliminar = [indicesEliminar; j];
                end 

            end
        end
        list(indicesEliminar,:) = [];
    end    
 
end

