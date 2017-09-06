load '../Fase_1_Entrenamiento/dataTraining.mat';
path(path,'../Funciones');

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


% Primera clasificacion con distintas vecindades
kaes = 1:2:15;
[F C] = size(inputTest);
salidas = [];
% En cada columna estan los resultados de todos los objetos de cada k.
input_NormEntren = input_Norm(6:12,:);
for i=1:length(kaes)
    for j=1:C
        A = kNN_Euclidea(input_NormEntren,output,inputTest_Norm(:,j),kaes(i));
        salidas(j,i) = A;
    end
end

% Comprobar fallos
fallos = zeros(8,1);
indicesFallos =[];
for i=1:8
    for j=1:C
        if(outputTest(j) ~= salidas(j,i))
            fallos(i) = fallos(i) + 1;
            indicesFallos = [indicesFallos ; i];
        end
    end
    fprintf('Fallos %d: %d\n',i,fallos(i));
end

k = find(fallos==min(fallos));
k=k(1);

indicesFallos = [];
for j=1:C
       if(outputTest(j) ~= salidas(j,k))
           fallos = fallos + 1;
          indicesFallos = [indicesFallos ; j];
       end
 end

% Letras que
[letras(outputTest(indicesFallos))' letras(salidas(indicesFallos))']

% Conflictos -> Fase 3
% DQ
% OH
% ZF
% QK

% % Salida en letras
% for i=1:length(salidas)
%     fprintf('%s',letras(salidas(i,1)));
% end
% fprintf('\n');

save('dataTest','inputTest','inputTest2','inputTest_Norm','inputTest2_Norm','outputTest','salidas','k');