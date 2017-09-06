path(path,'../Funciones');
load('../Fase_1_Entrenamiento/dataTraining.mat');
load('../Fase_2_Test/dataTest.mat');

%% Conflicto: D - Q (4 - 17)
inputDQ = [input(:,output==4) input(:,output==17)];
input_NormDQ = [input_Norm(:,output==4) input_Norm(:,output==17)];
outputDQ = [];
outputDQ(1:66) = 4;
outputDQ(67:126) = 17;

[mejorCombinacionDQ mejorCombinacionDQ2] = getMejorCombinacion(inputDQ,outputDQ);

%%


%% Conflicto: H - O (8 - 15)
inputHO = [input(:,output==8) input(:,output==15)];
input_NormHO = [input_Norm(:,output==8) input_Norm(:,output==15)];
outputHO = [];
outputHO(1:66) = 8;
outputHO(67:126) = 15;

[mejorCombinacionHO mejorCombinacionHO2] = getMejorCombinacion(inputHO,outputHO);

%%


%% Conflicto: K - Q (11 - 17)

inputKQ = [input(:,output==11) input(:,output==17)];
input_NormKQ = [input_Norm(:,output==11) input_Norm(:,output==17)];
outputKQ = [];
outputKQ(1:66) = 11;
outputKQ(67:126) = 15;

[mejorCombinacionKQ mejorCombinacionKQ2] = getMejorCombinacion(inputKQ,outputKQ);

%%


%% Conflicto: F - Z (6 - 26)

inputFZ = [input(:,output==6) input(:,output==26)];
input_NormFZ = [input_Norm(:,output==6) input_Norm(:,output==26)];
outputFZ = [];
outputFZ(1:66) = 6;
outputFZ(67:132) = 26;

[mejorCombinacionFZ mejorCombinacionFZ2] = getMejorCombinacion(inputFZ,outputFZ);


% Guardamos las combinaciones
save ('mejoresCombinaciones','mejorCombinacionDQ','mejorCombinacionDQ2','mejorCombinacionHO','mejorCombinacionHO2','mejorCombinacionKQ','mejorCombinacionKQ2','mejorCombinacionFZ','mejorCombinacionFZ2');
save ('inputsYoutputs','inputDQ','input_NormDQ','outputDQ','inputHO','input_NormHO','outputHO','inputKQ','input_NormKQ','outputKQ','inputFZ','input_NormFZ','outputFZ');