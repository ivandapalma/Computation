load('../Fase_1_Entrenamiento/dataTraining.mat');
load('../Fase_2_Test/dataTest.mat');
load('../Fase_3_Clases_Conflictivas/mejoresCombinaciones.mat');
load('../Fase_3_Clases_Conflictivas/inputsYoutputs.mat');
path(path,'../Funciones');


%% Idea:
% Vamos a ir comparando los objetos conflictivos del input de entrenamiento
% con los objetos del mismo tipo del inputTest (cogemos solo los objetos de
% la clase que estamos tratando)


%% Conflicto: D - Q (4 - 17)

[salidas outputTestDQ] = tratarConflictos(4,17,input_Norm,output,inputTest2_Norm,outputTest,mejorCombinacionDQ);

% Comprobar fallos
fallos = 0;
indicesFallos = [];
[F C] = size(salidas);
for j=1:C
    if(outputTestDQ(j) ~= salidas(j))
        fallos = fallos + 1;
        indicesFallos = [indicesFallos ; j];
    end
end

fprintf('Comprobacion D-Q\n');
fprintf('Fallos: %d\n',fallos);

if (fallos==0)
    [letras(outputTestDQ); letras(salidas)]
else % Letras que deberían ser - Letras que salen ( si hay fallos)
    [letras(outputTestDQ(indicesFallos))' letras(salidas(indicesFallos))']
end

%%


%% Conflicto: H - O (8 - 15)

[salidas outputTestHO] = tratarConflictos(8,15,input_Norm,output,inputTest2_Norm,outputTest,mejorCombinacionHO);

% Comprobar fallos
[F C] = size(salidas);
fallos = 0;
indicesFallos = [];
for j=1:C
    if(outputTestHO(j) ~= salidas(j))
        fallos = fallos + 1;
        indicesFallos = [indicesFallos ; j];
    end
end

fprintf('Comprobacion H-O\n');
fprintf('Fallos: %d\n',fallos);

if (fallos==0)
    [letras(outputTestHO); letras(salidas)]
else % Letras que deberían ser - Letras que salen ( si hay fallos)
    [letras(outputTestHO(indicesFallos))' letras(salidas(indicesFallos))']
end

%%


%% Conflicto: K - Q ( 11 - 17)

[salidas outputTestKQ] = tratarConflictos(11,17,input_Norm,output,inputTest2_Norm,outputTest,mejorCombinacionKQ);

% Comprobar fallos
[F C] = size(salidas);
fallos = 0;
indicesFallos = [];
for j=1:C
    if(outputTestKQ(j) ~= salidas(j))
        fallos = fallos + 1;
        indicesFallos = [indicesFallos ; j];
    end
end

fprintf('Comprobacion K-Q\n');
fprintf('Fallos: %d\n',fallos);

if (fallos==0)
    [letras(outputTestKQ); letras(salidas)]
else % Letras que deberían ser - Letras que salen ( si hay fallos)
    [letras(outputTestKQ(indicesFallos))' letras(salidas(indicesFallos))']
end

%%


%% Conflicto: F - Z ( 6 - 26)

[salidas outputTestFZ] = tratarConflictos(6,26,input_Norm,output,inputTest2_Norm,outputTest,mejorCombinacionFZ);

% Comprobar fallos
[F C] = size(salidas);
fallos = 0;
indicesFallos = [];
for j=1:C
    if(outputTestFZ(j) ~= salidas(j))
        fallos = fallos + 1;
        indicesFallos = [indicesFallos ; j];
    end
end

fprintf('Comprobacion F-Z\n');
fprintf('Fallos: %d\n',fallos);

if (fallos==0)
    [letras(outputTestFZ); letras(salidas)]
else % Letras que deberían ser - Letras que salen ( si hay fallos)
    [num2str(indicesFallos')]
    [letras(outputTestFZ(indicesFallos))'; letras(salidas(indicesFallos))']
end