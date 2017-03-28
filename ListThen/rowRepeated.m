function [ repetida ] = rowRepeated(fila1,fila2 )

    repetida = true;
    [Ffila Cfila] = size(fila1);    
    col=1;
    while(col <= Cfila && repetida == true)
        if (strcmp(fila1(col), fila2(col))==0)
            repetida = false;
        end
        col = col + 1;
    end
end

