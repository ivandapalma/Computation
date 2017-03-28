function [entradas salidas] = crearTablaVerdad(numEntradas,esAND)
    entradas = dec2bin(0:(2.^numEntradas)-1)-'0';
    
    if esAND == 1 % AND       
       salidas = zeros(2.^numEntradas,1); 
       salidas(2.^numEntradas) = 1;
    else % OR
        salidas = ones(2.^numEntradas,1); 
        salidas(1) = 0;
    end
end

