function [ list ] = deleteRepeated(list)

    [Flist Clist] = size(list); 
    indicesRepetidos = [];
    i=1;
    while (i < (Flist-1))
        fila1 = list(i,:);        
        for j=(i+1):(Flist)
            fila2 = list(j,:);
            if (rowRepeated(fila1,fila2) == true)
                indicesRepetidos = [indicesRepetidos; j];
            end 
        end
        i = i + 1;
    end
    indicesRepetidos = unique(indicesRepetidos);
    list(indicesRepetidos,:) = [];
end

