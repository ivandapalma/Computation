%Cargar datos entrenamiento
load datosentrenamiento
load filas
%Diseño del Clasificador
entrenamiento=['Imagenes/fotos_fasetest/Test1.jpg';'Imagenes/fotos_fasetest/Test2.jpg';'Imagenes/fotos_fasetest/Test3.jpg'];

[M J]=size(entrenamiento);

objetostest=[];
for i=1:M
    momentos=[];
    I=imread(entrenamiento(i,:));
    [Ietiq N]=bwlabel(I<=(graythresh(I)*255));
    state=regionprops(double(Ietiq),'Eccentricity','Extent','Solidity','EulerNumber','Perimeter','Area');
    
    s=size(objetostest);
    inicio=s(2)+1;
    objetostest(1,inicio:(inicio+N-1))=cat(1,((cat(1,state.Perimeter).^2)./cat(1,state.Area))');
    objetostest(2,inicio:(inicio+N-1))=cat(1,state.Eccentricity)';
    objetostest(3,inicio:(inicio+N-1))=cat(1,state.Extent)';
    objetostest(4,inicio:(inicio+N-1))=cat(1,state.Solidity)';
    objetostest(5,inicio:(inicio+N-1))=cat(1,state.EulerNumber)';
    
    outputtest(1,inicio:(inicio+N-1))=i;
    
    for j=1:N
       momento=Funcion_Calcula_Hu(Ietiq==j);
       objetostest(6:12,(inicio+j-1))=momento;
    end
    
end

 s=size(objetostest);

for i=1:s(1)
   if std(objetostest(i,:))~=0
    medias(i,1)=mean(objetostest(i,:));
    desviaciones(i,1)=std(objetostest(i,:));
    objtestnorm(i,:)=(objetostest(i,:)-medias(i,1))/desviaciones(i,1);
   else
       medias(i,1)=0;
       desviaciones(i,1)=1;
       objtestnorm(i,:)=(objetostest(i,:)-medias(i,1))/desviaciones(i,1);
   end
end

%Minima distancia Euclidea
c=size(input);
distancias=zeros(s(2),c(2));
for i=1:s(2)
     for j=1:c(2)
        for k=1:length(filas)
            distancias(i,j)=distancias(i,j)+(objtestnorm(filas(k),i)-inputnormalizada(filas(k),j))^2;
        end
        distancias(i,j)=sqrt(distancias(i,j));
     end
end

fallos=0;
for i=1:s(2)
    if(outputtest(i)~=output(find(distancias(i,:)==min(distancias(i,:)))))
        fallos=fallos+1;
        display(i)
    end
end

PorceErrorEuclidea=fallos/s(2);
vectork=1:15;
salida=knn(inputnormalizada,output,filas,objtestnorm,vectork);

fallos=zeros(1,length(vectork));

 for i=1:length(vectork)
     for j=1:s(2)
        if(outputtest(j)~=salida(i,j))
            fallos(i)=fallos(i)+1;
        end
    end
end

PorceErrorKNN=fallos./s(2);

K=find(PorceErrorKNN==min(PorceErrorKNN));
KNN=K(1);

save KNN KNN

