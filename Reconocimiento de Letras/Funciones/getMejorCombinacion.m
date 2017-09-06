    function [mejorCombinacion mejorCombinacion2] = getMejorCombinacion(input,output)

    path(path,'../Funciones');

    % PASO 1: OBTENER GRADO DE SEPARABILIDAD

    gradoSep_J = zeros(12,1);
    [F C] = size(input);
    for i=1:2:(F-1)
        X = i;
        Y = i+1;
        gradoSep_J(X) = indiceJ(input(X,:),output); % Cálculo del grado de separabilidad J
        gradoSep_J(Y) = indiceJ(input(Y,:),output);
    end

    % PASO 2: OBTENCION DE LAS 6 CARACTERISTICAS MÁS RELEVANTES
    mejores = zeros(6,1);
    gradoJ = gradoSep_J; % Tratamos con una copia
    for i=1:6
        index = find(gradoJ==max(gradoJ)); % Buscamos el índice del mejor
        mejores(i) = index; % Obtenemos los índices de los mejores
        gradoJ(index) = -inf; % Lo ponemos a - infinito para que no vuelva a ser el mejor
    end

    % PASO 3: SELECCION FINAL DE 3 CARACTERISTICAS. CALCULO DE LA MEJOR
    % COMBINACION DE 3
    combinaciones = combnk(mejores,3);
    [F C] = size(combinaciones);
    sepa = zeros(1,F);
    for i=1:F
        I = input(combinaciones(i,:),:); % Devuelve las 3 columnas de cada combinacion
        sepa(i) = indiceJ(I,output); % Separabilidad conjunta
    end
    indexMayorSepa = find(sepa==max(sepa)); % Obtenemos los índices de los mejores
    mejorCombinacion = combinaciones(indexMayorSepa,:);
    sepa(indexMayorSepa) = 0;
    indexMayorSepa = find(sepa==max(sepa)); % Obtenemos los índices de los mejores
    mejorCombinacion2 = combinaciones(indexMayorSepa,:);

end