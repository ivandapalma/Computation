% PASO 1: COGEMOS LA(S) IMAGEN(ES)
path(path,'../Funciones');
load('../Fase_1_Entrenamiento/dataTraining.mat');
load('../Fase_2_Test/dataTest.mat');
load('../Fase_3_Clases_Conflictivas/mejoresCombinaciones.mat');
load('../Fase_3_Clases_Conflictivas/inputsYoutputs.mat');

imagenesFunc = '../ImagenesFuncionamiento/ivan da palma.tif';

inputFunc = [];
momentosFunc = [];
I = imread(imagenesFunc);
I = rgb2gray(I);    
I = I'; % Le damos la vuelta ya que regionprops lee en vertical
[Ietiq N] = bwlabel(I <= (graythresh(I)*255));
state = regionprops(double(Ietiq),'Eccentricity','Extent','Solidity','EulerNumber','Perimeter','Area');
inicio = length(inputFunc) + 1; % Para que lo introduzca en el siguiente

inputFunc(1,inicio:(inicio+N-1)) = cat(1,((cat(1,state.Perimeter).^2)./cat(1,state.Area))');
inputFunc(2,inicio:(inicio+N-1)) = cat(1,state.Eccentricity)';
inputFunc(3,inicio:(inicio+N-1)) = cat(1,state.Extent)';
inputFunc(4,inicio:(inicio+N-1)) = cat(1,state.Solidity)';
inputFunc(5,inicio:(inicio+N-1)) = cat(1,state.EulerNumber)';

for p=1:N
   momentoFunc = Funcion_Calcula_Hu_D(Ietiq==p);
   inputFunc(6:12,(inicio+p-1)) = momentoFunc;
end

%Normalizacion de la matriz inputFunc
s = size(inputFunc);
inputFunc_Norm = zeros(s(1),s(2));
for i=1:s(1)
    if std(input(i,:))~=0
        inputFunc_Norm(i,:) = (inputFunc(i,:) - medias(i,1)) / desviaciones(i,1);
    else
        inputFunc_Norm(i,:) = (inputFunc(i,:) - medias(i,1)) / desviaciones(i,1);
    end
end


inputFunc2 = inputFunc; % Con los 12 descriptores
inputFunc = inputFunc(6:12,:); % Solo con los 7 momentos de Hu

inputFunc2_Norm = inputFunc_Norm;
inputFunc_Norm = inputFunc_Norm(6:12,:);


% PASO 2: COGEMOS CADA OBJETO Y COMPARAMOS
input_NormEntren = input_Norm(6:12,:);
[F C] = size(inputFunc_Norm);
salidas = [];
for j=1:C
    A = kNN_Euclidea(input_NormEntren,output,inputFunc_Norm(:,j),k);    
	switch A % Letras conflictivas ->  F H K O Q        
        case 4 % Q -> Conflicto con D      
            A = tratarUnConflicto(4,17,input_Norm,output,inputFunc2_Norm(:,j),mejorCombinacionDQ);
            salidas(j) = A;
        case 6  % F -> Conflicto con Z
            A = tratarUnConflicto(6,26,input_Norm,output,inputFunc2_Norm(:,j),mejorCombinacionFZ);
            salidas(j) = A;
        case 8  % H -> Conflicto con O     
            A = tratarUnConflicto(8,15,input_Norm,output,inputFunc2_Norm(:,j),mejorCombinacionHO);
            salidas(j) = A;
        case 11 % K -> Conflicto con Q
            A = tratarUnConflicto(11,17,input_Norm,output,inputFunc2_Norm(:,j),mejorCombinacionKQ);
            salidas(j) = A;
        case 15 % O -> Conflicto con H
            A = tratarUnConflicto(8,15,input_Norm,output,inputFunc2_Norm(:,j),mejorCombinacionHO);
            salidas(j) = A;            
        case 17 % Q -> Conflicto con D      
            A = tratarUnConflicto(4,17,input_Norm,output,inputFunc2_Norm(:,j),mejorCombinacionDQ);
            salidas(j) = A;
        otherwise
            salidas(j) = A;
    end            
end

% Letras que
letras(salidas)