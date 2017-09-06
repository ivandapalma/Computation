function [Matriz_Etiquetada N]=Funcion_Etiquetar (ImagenBinaria)
[NFilas NColumnas] = size(ImagenBinaria);
ImgDouble=zeros(NFilas+2,NColumnas+2); % añadimos dos columnas y dos filas para que los vecinos no den errores

for i=1:NFilas
    for j=1:NColumnas
       ImgDouble(i+1,j+1)=ImagenBinaria(i,j);
    end
end

Etiqueta=1;
[F C]=find(ImgDouble==1); %Encuentra los pixeles que son 1, coge su fila y su columna
[tam]=size(F); % Cogemos el rango del vector columna F (Fila). También podríamos haber cogido la columna


%Como la filaX columnaX correspongo a un pixel
%vamos recorriendo todos los píxeles y añadiendo una etiqueta
for i=1:tam
    ImgDouble(F(i),C(i))=Etiqueta;
    Etiqueta=Etiqueta+1;
end

%Donde teniamos la etiqueta 0 ahora ponemos de etiqueta un número más
%que el último pixel para que sea un vecino de mayor valor y no lo tenga
%en cuenta
ImgDouble(ImgDouble==0)=Etiqueta;

% Iteración de arriba-abajo seguida por pasos de abajo-arriba
% Repetir hasta que la variable CAMBIO sea FALSO
CAMBIO = 1;
while CAMBIO==1
    CAMBIO=0;
% Paso de arriba-abajo
    for i=1:tam        %Pixeles vecinos recorridos: él mismo, arriba-izq, arriba, arriba-der e izquierda 
        M = min ([ImgDouble(F(i),C(i)) ImgDouble(F(i)-1,C(i)-1) ImgDouble(F(i)-1,C(i)) ImgDouble(F(i)-1,C(i)+1) ImgDouble(F(i),C(i)-1)]);
        if M ~= ImgDouble(F(i),C(i))                 
         ImgDouble(F(i),C(i)) = M;
         CAMBIO = 1;
        end                  
    end
    
    % Paso de abajo-arriba
    for i=tam:-1:1       %Pixeles vecinos recorridos: él mismo, abajo-der, abajo, abajo-izq y derecha 
        M = min ( [ImgDouble(F(i),C(i)) ImgDouble(F(i)+1,C(i)+1) ImgDouble(F(i)+1,C(i)) ImgDouble(F(i)+1,C(i)-1) ImgDouble(F(i),C(i)+1)]);
        if M ~= ImgDouble(F(i),C(i))
          ImgDouble(F(i),C(i)) = M;
          CAMBIO = 1;
        end
    end    
end

ImgDouble(ImgDouble==Etiqueta)=0; %Volvemos a poner el fondo (que tenía valor Etiqueta) a 0
unicos=unique(ImgDouble); %Obtenemos los valores únicos en un vector


%Coge los píxeles y ponle a cada uno el índice que corresponda en
%el vector "unicos".
%Ejemplo: ImgDouble(F(11980),C(11980)) = ImgDouble(53,196) =
% = 10934.  10934 ocupa el índice 4 en el vector únicos (ya que
%empieza en 2, por eso después restamos 1). Devolvemos el índice
%con find y a ese pixel se le asigna un 4. Así con todos los demás.
for i=2:tam
    ImgDouble(F(i),C(i))=find(unicos==ImgDouble(F(i),C(i)))-1;
end


Matriz_Etiquetada=ImgDouble;
N=length(unicos(:,1))-1; %Quitamos el 0, por eso restamos 1
end