function Matriz_Binaria_Filtrada = Filtra_Objetos (Matriz_Binaria , NumPix)
    [ImgBinaria N] = Funcion_Etiquetar (Matriz_Binaria); %Etiquetamos la matriz binaria
    NP = Calcula_Areas (ImgBinaria); %Obtenemos las áreas
    maximo = (NP >= NumPix); %Ponemos los dos más grandes a 1
    [F C]=find(ImgBinaria>=1); % Buscamos los índices de los píxeles donde están las X's
    tam = length(F); %Obtenemos el número de píxeles
    %Recorremos los píxeles y si el número que contiene la X no está entre
    %los dos máximos, los ponemos a 0
    for i=1:tam 
       if maximo(ImgBinaria(F(i),C(i)))==0
           ImgBinaria(F(i),C(i))=0;
       end
    end
    Matriz_Binaria_Filtrada=ImgBinaria;    
end