% kNN Mahalanobis
function salida = kNN_Mahalanobis(input_Norm,output,objeto,k)
    load('mejorCombinacion.mat');
    load('dataTraining.mat');
    % Variables: 3 mejores características (filas) de los inputs y el objeto
%   for TT=1:18
%     objeto=inputFunc(:,TT);
    inputMejores = input_Norm(mejorCombinacion,:);
   
    %Normalizamos objeto
    [Q W] = size(objeto);
    objetoMejores_Norm = objeto; % Para obtener el mismo tamaño
    for i=1:Q
        objetoMejores_Norm(i) = double(objeto(i) - medias(i)) / desviaciones(i);
    end
    objetoMejores = objetoMejores_Norm(mejorCombinacion,:);

    [F C] = size(inputMejores);
    %%%%% Diferencias entre el objeto normalizado sin reconocer y todos los demás    
    % Distancia Euclidea Natural (distancia entre un punto y otro)
    dif = zeros(1,C);
    MatrizCov = cov(inputMejores');
    for i=1:C
        A = inputMejores(:,i);
        B = objetoMejores;
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
        clase = zeros(3,2);
        clase(:,1) = 1:3;
        % Buscamos en índice quién aparece y le sumamos una aparicion a la
        % clase a la que pertenece
       for i=1:LV
            p = indices(i);
            c = output(p);
            clase(c,2) = clase(c,2) + 1;
       end
        salida = find(clase(:,2)==max(clase(:,2)));
    else
       salida = output(unicos); 
    end   
    
    if(salida == 1)
        fprintf('Circulo');
    elseif (salida == 2)        
        fprintf('Cuadrado');
    elseif (salida == 3)
        fprintf('Triangulo');
    else
        fprintf('No se sabe');
    end
    fprintf('\n');

 end
% end
  
%     Plot3D
%   
% 
%     plot3(input_Norm(combinaciones(13,1),output==1),input_Norm(combinaciones(13,2),output==1),input_Norm(combinaciones(13,3),output==1),'rO'),
%     hold on,   
%     plot3(input_Norm(combinaciones(13,1),output==2),input_Norm(combinaciones(13,2),output==2),input_Norm(combinaciones(13,3),output==2),'b*'),
%     hold on,
%     plot3(input_Norm(combinaciones(13,1),output==3),input_Norm(combinaciones(13,2),output==3),input_Norm(combinaciones(13,3),output==3),'g^'),
%     hold on,
%     plot3(objetoMejores(1),objetoMejores(2),objetoMejores(3),'p*'),
%     
%     xlabel(titulos(combinaciones(13,1),:));
%     ylabel(titulos(combinaciones(13,2),:));
%     zlabel(titulos(combinaciones(13,3),:));
