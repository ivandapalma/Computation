function outputTest = createOutputTest()

    inicio=0;
    etiqueta=0;
    
    % ImagenTest 01 y 02
    for k=1:2
        for i=1:8
            for j=1:4
                 inicio = inicio + 1;
                 outputTest(inicio) = i + etiqueta;
            end
        end
    end

    % ImagenTest 03 y 04
    etiqueta = etiqueta+8;
    for k=1:2
        for i=1:7
            for j=1:4
                 inicio = inicio + 1;
                 outputTest(inicio) = i + etiqueta;
            end
        end
    end

     % ImagenTest 05 y 06 
     etiqueta = etiqueta+7;
     for k=1:2
         for i=1:6
             for j=1:4
                  inicio = inicio + 1;
                  outputTest(inicio) = i + etiqueta;
             end
         end

         for i=1:5
             for j=1:3
                  inicio=inicio+1;
                  outputTest(inicio)= i + 6 + etiqueta;
             end
         end
     end

     % ImagenTest 07 y 08
     for k=1:2
         for i=1:26
            if i~=23
                inicio = inicio+1;
                outputTest(inicio) = i;
            end
         end
     end

     % ImagenTest 09 y 10
     for k=1:2
         for i=26:-1:1
                inicio = inicio + 1;
                outputTest(inicio) = i;
         end
     end
     
end