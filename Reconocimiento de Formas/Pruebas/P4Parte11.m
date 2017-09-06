entrenamiento=['Imagenes/fotos_entrenamiento/Circ_ent.jpg';'Imagenes/fotos_entrenamiento/Cuad_ent.jpg';'Imagenes/fotos_entrenamiento/Tria_ent.jpg'];

input=[];
output=[];
[M J]=size(entrenamiento);
momentos=[];
for i=1:M
    momentos=[];
    I=imread(entrenamiento(i,:));
    [Ietiq N]=bwlabel(I<=(graythresh(I)*255));
    state=regionprops(double(Ietiq),'Eccentricity','Extent','Solidity','EulerNumber','Perimeter','Area');
    
    inicio=length(output)+1;
    input(1,inicio:(inicio+N-1))=cat(1,((cat(1,state.Perimeter).^2)./cat(1,state.Area))');
    input(2,inicio:(inicio+N-1))=cat(1,state.Eccentricity)';
    input(3,inicio:(inicio+N-1))=cat(1,state.Extent)';
    input(4,inicio:(inicio+N-1))=cat(1,state.Solidity)';
    input(5,inicio:(inicio+N-1))=cat(1,state.EulerNumber)';
    
    output(1,inicio:(inicio+N-1))=i;
    
    for j=1:N
       momento=Funcion_Calcula_Hu(Ietiq==j);
       input(6:12,(inicio+j-1))=momento;
    end
    
end
s=size(input);

for i=1:s(1)
   if std(input(i,:))~=0
    medias(i,1)=mean(input(i,:));
    desviaciones(i,1)=std(input(i,:));
    inputnormalizada(i,:)=(input(i,:)-medias(i,1))/desviaciones(i,1);
   else
       medias(i,1)=0;
       desviaciones(i,1)=1;
       inputnormalizada(i,:)=(input(i,:)-medias(i,1))/desviaciones(i,1);
   end
end

save('datosentrenamiento','input','inputnormalizada','output','medias','desviaciones');


        
     
