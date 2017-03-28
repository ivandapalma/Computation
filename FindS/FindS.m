function solucion = FindS(dataSet,dsFilas,dsColumnas,columnaComparativa)
    solucion = dataSet(1,:); % Cogemos la primera como solucion
    for i=2:dsFilas % Comenzamos a buscar desde la segunda
        clase = dataSet(i,columnaComparativa);
        if(strcmp(clase,'positive') == 1 || strcmp(clase,' positive') == 1 || strcmp(clase,'+') == 1 || strcmp(clase,' +') == 1)
            ds = dataSet(i,:);
            for j=1:dsColumnas
                if(strcmp(solucion(j),ds(j)) == 0) % Si es distinta
                    solucion(j) = cellstr('?');
                end                
            end
        end
    end
end