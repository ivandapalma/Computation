function salida = knn (inputs, outputs,filas, vector, vectork)
    
    s=size(vector);
    c=size(inputs);
    distancias=zeros(s(2),c(2));
    salida=zeros(length(vectork),s(2));
%Calculo de la matriz distancia (sus filas son lo objetos de test y sus
%columnas son los objetos de entrenamiento, la interseccion entre fila y
%columna es la distancia que hay desde el objetotestX hasta el
%objetoentrenamientoY
    for i=1:s(2)
         for j=1:c(2)
            for k=1:length(filas)
                distancias(i,j)=distancias(i,j)+(vector(filas(k),i)-inputs(filas(k),j))^2;
            end
            distancias(i,j)=sqrt(distancias(i,j));
         end
    end
    
%Calculo de vecinos apartir de la matriz distancia se calcula la etiqueta
%de los N vecinos mas cercanos, donde N es el maximo valor de vecindad del
%vectork
    for i=1:s(2)
        for j=1:length(vectork)
            dist=distancias(i,:);
            vecinos=0;
            for k=1:vectork(j)
                %if length(vecinos)<=vectork(j)
                    vecinos(k)=outputs(dist==min(dist));
                    dist(dist==min(dist))=max(dist);
                %end
            end
            prob=tabulate(vecinos);
            display(prob);
            if length(unique(prob(:,3)))==1
                salida(j,i)=vecinos(1);
            else
%                 etique=unique(vecinos);
%                 conteo=zeros(length(etique),1);
%                 for k=1:length(etique)
%                    conteo(k)=sum(vecinos==etique(k)); 
%                 end

                salida(j,i)=prob((prob(:,3)==max(prob(:,3))),1);
            end
        end
    end
end

%numImagen=1;
%numImagenStr=num2str(numImagen,'%02d');
%Sentencia=['SalidasImagen = SalidasImagen' numImagenStr ';']
%eval(Sentencia)