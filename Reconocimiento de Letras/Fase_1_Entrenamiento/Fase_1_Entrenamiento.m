path(path,'../Funciones');
letras = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

% Leemos las 26 letras (2 imagenes por letra), generando los doce
% descriptores usados en la practica anterior
input = [];
output = [];
for i=1:(length(letras)) % Cada letra del alfabeto dado (26 en total)
    for j=1:2 % Dos imagenes por cada letra
        momentos = [];        
        I = imread(['../ImagenesEntrenamiento/' letras(i) num2str(j) '.tif']); 
        % Con num2str pasamos a string j (sea 1 o 2)
        I = rgb2gray(I); % I es una imagen de colro (Matriz RGB) -> Pasamos a matriz de grises
        [Ietiq N] = bwlabel(I <= (graythresh(I)*255));
         state = regionprops(double(Ietiq),'Eccentricity','Extent','Solidity','EulerNumber','Perimeter','Area');
 
        inicio=length(output)+1;
        input(1,inicio:(inicio+N-1)) = cat(1,((cat(1,state.Perimeter).^2)./cat(1,state.Area))');
        input(2,inicio:(inicio+N-1)) = cat(1,state.Eccentricity)';
        input(3,inicio:(inicio+N-1)) = cat(1,state.Extent)';
        input(4,inicio:(inicio+N-1)) = cat(1,state.Solidity)';
        input(5,inicio:(inicio+N-1)) = cat(1,state.EulerNumber)';

        output(1,inicio:(inicio+N-1)) = i;

        for k=1:N
           momento = Funcion_Calcula_Hu_D(Ietiq==k);
           input(6:12,(inicio+k-1)) = momento;
        end
        
    end
end

%Normalizacion de la matriz de la matriz input
Q = size(input);
for i=1:(Q(1))
   if (std(input(i,:))~=0)
    medias(i,1) = mean(input(i,:));
    desviaciones(i,1) = std(input(i,:));
    input_Norm(i,:) = (input(i,:)- medias(i,1)) / desviaciones(i,1);

   else
       medias(i,1) = 0;
       desviaciones(i,1) = 1;
       input_Norm(i,:) = (input(i,:) - medias(i,1)) / desviaciones(i,1);
   end   
end

% Matriz de 12 filas y 1716 columnas(66 letras de entrenamiento divididos
% en dos ficheros * 26 letras del alfabeto dado)
save('dataTraining','letras','input','input_Norm','output','medias','desviaciones');
