function outputtest=generaoutputtest()
inicio=0;
etiqueta=0;
for k=1:2
    for i=1:8
        for j=1:4
             inicio=inicio+1;
             outputtest(inicio)=i+etiqueta;
        end
    end
end
 
etiqueta=etiqueta+8;

for k=1:2
    for i=1:7
        for j=1:4
             inicio=inicio+1;
             outputtest(inicio)=i+etiqueta;
        end
    end
 end
 
 etiqueta=etiqueta+7;
 
 for k=1:2
     for i=1:6
         for j=1:4
              inicio=inicio+1;
              outputtest(inicio)=i+etiqueta;
         end
     end
     
     for i=1:5
         for j=1:3
              inicio=inicio+1;
              outputtest(inicio)=i+6+etiqueta;
         end
     end
 end

 for k=1:2
     for i=1:26
        if i~=23
            inicio=inicio+1;
            outputtest(inicio)=i;
        end
     end
 end
 
 for k=1:2
     for i=26:-1:1
            inicio=inicio+1;
            outputtest(inicio)=i;
     end
 end
end