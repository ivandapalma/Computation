% Diseño del Clasificador (Fase de funcionamiento)

imagenesFunc = 'Imagenes/fotos_fasefuncionamiento/Func1.jpg';
imagenesFunc = [imagenesFunc; 'Imagenes/fotos_fasefuncionamiento/Func2.jpg'];

inputFunc = [];
outputFunc = [];
[M J] = size(imagenesFunc);
momentosFunc = [];

for i=1:M
    momentosFunc = [];
    I = imread(imagenesFunc(i,:));
    [IetiqF N] = bwlabel(I <= 255*(graythresh(I)));
    state = regionprops(double(IetiqF),'Eccentricity','Extent','Solidity','EulerNumber','Perimeter','Area');
    
    %Input: Compacticidad, Excentricidad, Solidez (bounding box), Solidez (convex hull), Número de Euler.
    inicio = length(outputFunc)+1;
    inputFunc(1,inicio:(inicio+N-1)) = cat(1,((cat(1,state.Perimeter).^2)./cat(1,state.Area))');
    inputFunc(2,inicio:(inicio+N-1)) = cat(1,state.Eccentricity)';
    inputFunc(3,inicio:(inicio+N-1)) = cat(1,state.Extent)';
    inputFunc(4,inicio:(inicio+N-1)) = cat(1,state.Solidity)';
    inputFunc(5,inicio:(inicio+N-1)) = cat(1,state.EulerNumber)';
    
    outputFunc(1,inicio:(inicio+N-1)) = i;
    
    %Input:Añadimos a input las 7 medidas de Hu
    for j=1:N
       momentoFunc = Funcion_Calcula_Hu_Diego(IetiqF==j);
       inputFunc(6:12,(inicio+j-1)) = momentoFunc; % Del 1 al 5 estan las caracteristicas
    end
    if(i==1)
        IetiqF1 = IetiqF;
    else % i==2
        IetiqF2 = IetiqF;
    end
end

[Q W] = size(inputFunc);
inputFunc_Norm = inputFunc;
for i=1:Q
    inputFunc_Norm(i,:) = (inputFunc(i,:)-medias(i)) /desviaciones(i);   
end

save('dataFunc','inputFunc','inputFunc_Norm','outputFunc','IetiqF1','IetiqF2');   
     