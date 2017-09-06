function salida = tratarUnConflicto(L1,L2,input_Norm,output,objeto_Norm,mejorCombinacion)
    path(path,'../Funciones');
    k=1;
    Letra1 = L1;
    Letra2 = L2;
    a = input_Norm(mejorCombinacion,output==Letra1);
    b = input_Norm(mejorCombinacion,output==Letra2);
    outputConf = [];
    outputConf(1:length(a)) = Letra1;
    outputConf((length(a)+1):(length(a)+length(b))) = Letra2;
    input_NormConf = [a b]; 


    salida = kNN_Euclidea(input_NormConf,outputConf,objeto_Norm(mejorCombinacion,:),k);
    
end
