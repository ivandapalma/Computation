function [ Y ] = funcionActivacion(sumatorio)

   % funcion activacion umbral        
    if sumatorio > 0
        Y = 1;
    else 
        Y = 0;
    end

end

