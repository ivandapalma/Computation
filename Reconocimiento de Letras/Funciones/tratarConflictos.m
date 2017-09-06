function [salidas outputTestConf] = tratarConflictos(L1,L2,input_Norm,output,inputTest2_Norm,outputTest,mejorCombinacion)
    path(path,'../Funciones');
    k=1;
    Letra1 = L1;
    Letra2 = L2;
    a = input_Norm(mejorCombinacion,output==Letra1);
    b = input_Norm(mejorCombinacion,output==Letra2);
    input_NormConf = [a b]; 
    outputConf = [];
    outputConf(1:length(a)) = Letra1;
    outputConf((length(a)+1):(length(a)+length(b))) = Letra2;
    

    c = inputTest2_Norm(:,outputTest==Letra1);
    d = inputTest2_Norm(:,outputTest==Letra2);
    inputTest_NormConf = [c d];
    outputTestConf(1:length(c)) = Letra1;
    outputTestConf((length(c)+1):(length(c)+length(d))) = Letra2;

    [F C] = size(inputTest_NormConf);
    salidas = [];
    for j=1:C
        A = kNN_Euclidea(input_NormConf,outputConf,inputTest_NormConf(mejorCombinacion,j),k);
        salidas(j) = A;
    end
end