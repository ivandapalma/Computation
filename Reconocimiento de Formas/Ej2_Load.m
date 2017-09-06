% Diseño del Clasificador (Fase de test)

imagenesTest = 'Imagenes/fotos_fasetest/Test1.jpg';
imagenesTest = [imagenesTest; 'Imagenes/fotos_fasetest/Test2.jpg'];
imagenesTest = [imagenesTest; 'Imagenes/fotos_fasetest/Test3.jpg'];
% Obtencion de patrones de entrenamiento


inputTest = [];
outputTest = [];
[M J] = size(imagenesTest);
momentosTest = [];

for i=1:M
    momentosTest = [];
    I = imread(imagenesTest(i,:));
    [Ietiq N] = bwlabel(I <= 255*(graythresh(I)));
    state = regionprops(double(Ietiq),'Eccentricity','Extent','Solidity','EulerNumber','Perimeter','Area');
    
    %Input: Compacticidad, Excentricidad, Solidez (bounding box), Solidez (convex hull), Número de Euler.
    inicio = length(outputTest)+1;
    inputTest(1,inicio:(inicio+N-1)) = cat(1,((cat(1,state.Perimeter).^2)./cat(1,state.Area))');
    inputTest(2,inicio:(inicio+N-1)) = cat(1,state.Eccentricity)';
    inputTest(3,inicio:(inicio+N-1)) = cat(1,state.Extent)';
    inputTest(4,inicio:(inicio+N-1)) = cat(1,state.Solidity)';
    inputTest(5,inicio:(inicio+N-1)) = cat(1,state.EulerNumber)';
    
    outputTest(1,inicio:(inicio+N-1)) = i;
    
    %Input:Añadimos a input las 7 medidas de Hu
    for j=1:N
       momentoTest = Funcion_Calcula_Hu_Diego(Ietiq==j);
       inputTest(6:12,(inicio+j-1)) = momentoTest; % Del 1 al 5 estan las caracterÃ­sticas
    end    
end

[Q W] = size(inputTest);
inputTest_Norm = inputTest;
for i=1:Q
    inputTest_Norm(i,:) = (inputTest(i,:)-medias(i)) /desviaciones(i);   
end

save('dataTest','inputTest','inputTest_Norm','outputTest');   
     