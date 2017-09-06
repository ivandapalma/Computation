function Areas = Calcula_Areas (Matriz_Etiquetada)
    N = unique(Matriz_Etiquetada); %Numeros en un vector
    for i=2:size(N) %Recorre quitando el 0 (que esta en a posicion 1)
        Areas(i-1)=max( size(find(N(i)==Matriz_Etiquetada)) );
        %contamos cuantos pixeles tiene cada X (buscamos sus números
        % y cogemos el mayor        
    end
end
