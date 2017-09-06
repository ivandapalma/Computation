load '../Fase_1_Entrenamiento/dataTraining.mat';
path(path,'../Funciones');
load '../Fase_3_Clases_Conflictivas/mejoresCombinaciones.mat';
%Lectura de imagenes Test y calculo de los 12 descriptores
inputTest = [];
outputTest = [];
for i=1:10 % 10 imagenes de Tests
    momentos = [];
    if(i<10)            
        A = strcat(num2str(0),num2str(i));
    else
        A = num2str(10);
    end
    I = imread(['../ImagenesTest/' 'Test' A '.tif']);
    I = rgb2gray(I);
    I = I'; % Le damos la vuelta ya que regionprops lee en vertical
    [Ietiq N] = bwlabel(I <= (graythresh(I)*255));
    state = regionprops(double(Ietiq),'Eccentricity','Extent','Solidity','EulerNumber','Perimeter','Area');
    inicio = length(inputTest) + 1; % Para que lo introduzca en el siguiente

    inputTest(1,inicio:(inicio+N-1)) = cat(1,((cat(1,state.Perimeter).^2)./cat(1,state.Area))');
    inputTest(2,inicio:(inicio+N-1)) = cat(1,state.Eccentricity)';
    inputTest(3,inicio:(inicio+N-1)) = cat(1,state.Extent)';
    inputTest(4,inicio:(inicio+N-1)) = cat(1,state.Solidity)';
    inputTest(5,inicio:(inicio+N-1)) = cat(1,state.EulerNumber)';

    for k=1:N
       momento = Funcion_Calcula_Hu_D(Ietiq==k);
       inputTest(6:12,(inicio+k-1)) = momento;
    end

end

%Normalizacion de la matriz inputTest
s = size(inputTest);
inputTest_Norm = zeros(s(1),s(2));
for i=1:s(1)
    if std(input(i,:))~=0
        inputTest_Norm(i,:) = (inputTest(i,:) - medias(i,1)) / desviaciones(i,1);
    else
        inputTest_Norm(i,:) = (inputTest(i,:) - medias(i,1)) / desviaciones(i,1);
    end
end

inputTest2 = inputTest; % Con los 12 descriptores
inputTest = inputTest(6:12,:); % Solo con los 7 momentos de Hu

inputTest2_Norm = inputTest_Norm;
inputTest_Norm = inputTest_Norm(6:12,:);

medias2 = medias(6:12,:);
desviaciones2 = desviaciones(6:12,:);


% Por cada patron de aparicion de letra (la mayoria aparecen de 4 en 4 pero
% también hay bloques de 3) indicamos la clase a la que pertenece.
outputTest = createOutputTest();

% PASO 2: COGEMOS CADA OBJETO Y COMPARAMOS
k=1;
input_NormEntren = input_Norm(6:12,:);
[F C] = size(inputTest_Norm);
salidas = [];
for j=1:C
    A = kNN_Euclidea(input_NormEntren,output,inputTest_Norm(:,j),k);
    
	switch A % Letras conflictivas ->  F H K O Q        
        case 4 % Q -> Conflicto con D      
            A = tratarUnConflicto(4,17,input_Norm,output,inputTest2_Norm(:,j),mejorCombinacionDQ);
            salidas(j) = A;
        case 6  % F -> Conflicto con Z
            A = tratarUnConflicto(6,26,input_Norm,output,inputTest2_Norm(:,j),mejorCombinacionFZ);
            salidas(j) = A;
            % Si se pudiera, se pasarían todos los descriptores por F, que
            % es la que más problemas da
            % A = kNN_Euclidea(input_Norm,output,inputTest2_Norm(:,j),k);
            % salidas(j) = A;
        case 8  % H -> Conflicto con O     
            A = tratarUnConflicto(8,15,input_Norm,output,inputTest2_Norm(:,j),mejorCombinacionHO);
            salidas(j) = A;
        case 11 % K -> Conflicto con Q
            A = tratarUnConflicto(11,17,input_Norm,output,inputTest2_Norm(:,j),mejorCombinacionKQ);
            salidas(j) = A;
        case 15 % O -> Conflicto con H
            A = tratarUnConflicto(8,15,input_Norm,output,inputTest2_Norm(:,j),mejorCombinacionHO);
            salidas(j) = A;            
        case 17 % Q -> Conflicto con D      
            A = tratarUnConflicto(4,17,input_Norm,output,inputTest2_Norm(:,j),mejorCombinacionDQ);
            salidas(j) = A;
        otherwise
            salidas(j) = A;
    end            
end


% Comprobar fallos
[F C] = size(salidas);
fallos = 0;
indicesFallos = [];
for j=1:C
    if(outputTest(j) ~= salidas(j))
        fallos = fallos + 1;
        indicesFallos = [indicesFallos ; j];
    end
end
fprintf('Fallos: %d\n',fallos);


if (fallos ~= 0) % Letras que deberían ser - Letras que salen ( si hay fallos)
    [num2str(indicesFallos')]
    [letras(outputTest(indicesFallos)); letras(salidas(indicesFallos))]
end
