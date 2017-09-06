function salida = knn (inputs_N, outputs,objeto_N,k)
    
    [F C] = size(inputs_N);
    [Q S] = size(objeto_N);
    salida = zeros(1,S);


    %%%%% Diferencias entre cada objeto normalizado sin reconocer y todos los demás    
    % Distancia Euclidea Natural (distancia entre un punto y otro)
	dif = zeros(1,C);
    for i=1:C
        A = 0;
        for j=1:F
            A = A + (objeto_N(j) - inputs_N(j,i))^2;
        end
        dif(i) = sqrt(A);
    end
    
    for i=1:S % Para cada uno de los objetos (los 300)
        vecinos = [];
        dist = dif(i,:);
        for j=1:k
            v = find(dist==min(dist));
            dist(v) = Inf;   
            vecinos(length(vecinos)+1:length(vecinos)+length(v)) = v; % El numero de vecinos depende de k
        end
        clase = outputs(1,vecinos(1:k));
        probabMayor = tabulate(clase);
        sal = probabMayor(find(probabMayor(:,3) == max(probabMayor(:,3))),1); % 3 -> Porcentaje mayor
        salida(1,i) = sal(1);          
    end
end
