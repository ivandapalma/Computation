% kNN Mahalanobis
function salida = kNN_Mahalanobis(input_Norm,output,objeto_Norm,k)

%     %Normalizamos objeto
%     [Q W] = size(objeto);
%     objeto_Norm_Norm = objeto; % Para obtener el mismo tamaño
%     for i=1:Q
%         objeto_Norm_Norm(i) = double(objeto(i) - medias(i)) / desviaciones(i);
%     end
%     objeto_Norm = objeto_Norm_Norm(mejorCombinacion);

    [F C] = size(input_Norm);
    %%%%% Diferencias entre el objeto normalizado sin reconocer y todos los demás    
    % Distancia Malanahobis
    dif = zeros(1,C);
    MatrizCov = cov(input_Norm');
    for i=1:C
        A = input_Norm(:,i);
        B = objeto_Norm;
        dif(i) = (A-B)'*pinv(MatrizCov)*(A-B);
    end
    
    dif2=dif; % Copia
    indices = zeros(k,1); % Encontramos los índices más pequeño de cada fila
    for i=1:k
        indices(i) = find(dif2==min(dif2));
        dif2(indices(i)) = Inf;
    end

    %%%%%% Buscamos según los índices a qué clase pertenece el que más sale
    unicos = unique(indices);
    LV = length(indices);
    L = length(unicos);
    if(L > 1) % Buscamos la clase que más sale
        clase = zeros(L,2);
        clase(:,1) = 1:L;
        % Buscamos en índice quién aparece y le sumamos una aparicion a la
        % clase a la que pertenece
       for i=1:LV
            p = indices(i);
            c = output(p);
            clase(c,2) = clase(c,2) + 1;
       end
        salida = find(clase(:,2)==max(clase(:,2)));
        salida=salida(1);
    else
       salida = output(unicos); 
    end   
    
 
    
%     if(salida == 1)
%         fprintf('A');
%     elseif (salida == 2)        
%         fprintf('B');
%     elseif (salida == 3)
%         fprintf('C');
%     elseif (salida == 4)
%         fprintf('D');
%     elseif (salida == 5)
%         fprintf('E');
%     elseif (salida == 6)
%         fprintf('F');
%     elseif (salida == 7)
%         fprintf('G');
%     elseif (salida == 8)
%         fprintf('H');
%     elseif (salida == 9)
%         fprintf('I');
%     elseif (salida == 10)
%         fprintf('J');
%     elseif (salida == 11)
%         fprintf('K');
%     elseif (salida == 12)
%         fprintf('L');
%     elseif (salida == 13)
%         fprintf('M');
%     elseif (salida == 14)
%         fprintf('N');
%     elseif (salida == 15)
%         fprintf('O');
%     elseif (salida == 16)
%         fprintf('P');
%     elseif (salida == 17)
%         fprintf('Q');
%     elseif (salida == 18)
%         fprintf('R');
%     elseif (salida == 19)
%         fprintf('S');
%     elseif (salida == 20)
%         fprintf('T');
%     elseif (salida == 21)
%         fprintf('U');
%     elseif (salida == 22)
%         fprintf('V');
%     elseif (salida == 23)
%         fprintf('W');
%     elseif (salida == 24)
%         fprintf('X');
%     elseif (salida == 25)
%         fprintf('Y');
%     elseif (salida == 26)
%         fprintf('Z');
%     else
%         fprintf('No se sabe');
%     end
%     fprintf('\n');

end
  