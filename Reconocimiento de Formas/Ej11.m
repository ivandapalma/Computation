% Obtencion de patrones de entrenamiento

Imagenes = 'Imagenes/fotos_entrenamiento/Circ_ent.jpg'; 
Imagenes = [Imagenes ; 'Imagenes/fotos_entrenamiento/Cuad_ent.jpg'];
Imagenes = [Imagenes ; 'Imagenes/fotos_entrenamiento/Tria_ent.jpg'];

input = [];
output = [];
[M J] = size(Imagenes);
momentos = [];

for i=1:M
    momentos = [];
    I = imread(Imagenes(i,:));
    [Ietiq N] = bwlabel(I <= 255*(graythresh(I)));
    state = regionprops(double(Ietiq),'Eccentricity','Extent','Solidity','EulerNumber','Perimeter','Area');
    
    %Input: Compacticidad, Excentricidad, Solidez (bounding box), Solidez (convex hull), Número de Euler.
    inicio = length(output)+1;
    input(1,inicio:(inicio+N-1)) = cat(1,((cat(1,state.Perimeter).^2)./cat(1,state.Area))');
    input(2,inicio:(inicio+N-1)) = cat(1,state.Eccentricity)';
    input(3,inicio:(inicio+N-1)) = cat(1,state.Extent)';
    input(4,inicio:(inicio+N-1)) = cat(1,state.Solidity)';
    input(5,inicio:(inicio+N-1)) = cat(1,state.EulerNumber)';
    
    output(1,inicio:(inicio+N-1)) = i;
    
    %Input:Añadimos a input las 7 medidas de Hu
    for j=1:N
       momento = Funcion_Calcula_Hu_Diego(Ietiq==j);
       input(6:12,(inicio+j-1)) = momento; % Del 1 al 5 estan las caracterÃ­sticas
    end    
end

[Q W] = size(input);
medias = zeros(Q,1);
desviaciones = zeros(Q,1);

for i=1:Q
   if (std(input(i,:))~=0)
    medias(i) = mean(input(i,:));
    desviaciones(i) = std(input(i,:));
    input_Norm(i,:) = (input(i,:)-medias(i))/desviaciones(i);
   else
       medias(i) = 0;
       desviaciones(i) = 1;
       input_Norm(i,:) = (input(i,:)-medias(i))/desviaciones(i);
   end
end

save('dataTraining','input','input_Norm','output','medias','desviaciones');   
     
