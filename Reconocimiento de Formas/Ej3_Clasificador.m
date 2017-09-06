% Clasificador Funcionamiento

[F C] = size(inputFunc_Norm);
salida = 0;
k = 3;

for i=1:C
    salida = kNN_Mahalanobis(input_Norm,output,inputFunc(:,i),k);
    if(salida == 1)
        nombre_Figura = 'Circulo';
    elseif (salida == 2)        
        nombre_Figura = 'Cuadrado';
    elseif (salida == 3)
        nombre_Figura = 'Triangulo';
    else
        nombre_Figura = 'No se sabe';
    end
    fprintf('\n');
    if(i<10)
        imshow(IetiqF1==i); % Imagen Func 1
    else
        eti = i - 9;
        imshow(IetiqF2==eti);% Imagen Func 2
    end
    title(nombre_Figura);
    pause
end