function [filaCompatible] = Compatible(fila1, fila2)

    [F1 C1] = size(fila1); % size C1 = C2
    [F2 C2] = size(fila2);
    comp = 0;
    col=1;
    filaCompatible = true;
    
    while ((col <= C1) && filaCompatible==true)
        if (strcmp(fila1(col), fila2(col))==0 && strcmp(fila2(col), '?')==0 )
            filaCompatible = false;
        end
        col=col+1;
    end
end
 
