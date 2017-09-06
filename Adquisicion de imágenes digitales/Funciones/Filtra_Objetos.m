function Matriz_Binaria_Filtrada = Filtra_Objetos (Matriz_Binaria , NumPix)
    [ImgBinaria N] = Funcion_Etiquetar (Matriz_Binaria); %Etiquetamos la matriz binaria
    NP = Calcula_Areas (ImgBinaria); %Obtenemos las �reas
    maximo = (NP >= NumPix); %Ponemos los dos m�s grandes a 1
    [F C]=find(ImgBinaria>=1); % Buscamos los �ndices de los p�xeles donde est�n las X's
    tam = length(F); %Obtenemos el n�mero de p�xeles
    %Recorremos los p�xeles y si el n�mero que contiene la X no est� entre
    %los dos m�ximos, los ponemos a 0
    for i=1:tam 
       if maximo(ImgBinaria(F(i),C(i)))==0
           ImgBinaria(F(i),C(i))=0;
       end
    end
    Matriz_Binaria_Filtrada=ImgBinaria;    
end