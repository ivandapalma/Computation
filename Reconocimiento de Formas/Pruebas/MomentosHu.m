function momentos = MomentosHu(Ietiq,N)
    
   
    o=[];
    for i=1:N
       I=Ietiq==i;
       [F C]=find(I==1);
       %Calculo de momentos ordinarios de orden
       %La variable m es un vector fila con el valor de la intendidad de
       %los pixeles que pertenecen al objeto i
       m=[];
       for j=1:length(F)
        m(j)=I(F(j),C(j));
       end
       %En estas tres filas se calculan los momentos ordianrios de orden
       %que necesitamos.
       m00=length(F);
       m10=sum((F.^1).*(C.^0).*(m'));
       m01=sum((F.^0).*(C.^1).*(m'));
       
       %Las variables que comienzan con "w" son los momentos centrales de
       %orden, de las cuales se calculan los necesarios.
       w00=sum(((F-(m10/m00)).^0).*((C-(m01/m00)).^0).*(m'));
       
       w20=sum(((F-(m10/m00)).^2).*((C-(m01/m00)).^0).*(m'));
       w30=sum(((F-(m10/m00)).^3).*((C-(m01/m00)).^0).*(m'));
       
       w02=sum(((F-(m10/m00)).^0).*((C-(m01/m00)).^2).*(m'));
       w03=sum(((F-(m10/m00)).^0).*((C-(m01/m00)).^3).*(m'));
       
       w11=sum(((F-(m10/m00)).^1).*((C-(m01/m00)).^1).*(m'));
       w21=sum(((F-(m10/m00)).^2).*((C-(m01/m00)).^1).*(m'));
       w12=sum(((F-(m10/m00)).^1).*((C-(m01/m00)).^2).*(m'));
       
       %La variables que comienzan por "n" son los momentos centrales
       %normalizados necesarios para realizar el ultimo calculo.
       n20=w20/((w00)^((2+0)/2));
       n30=w30/((w00)^((3+0)/2));
       
       n02=w02/((w00)^((0+2)/2));
       n03=w03/((w00)^((0+3)/2));
       
       n11=w11/((w00)^((1+1)/2));
       n21=w21/((w00)^((2+1)/2));
       n12=w12/((w00)^((1+2)/2));
       
       %Por ultimo la variable llamada "o" es un vector columna con en el
       %que se guardan los resultados del calculo de cada momento
       %invariante de Hu
       
       o(1,i)=n20+n02;
       o(2,i)=((n20-n02)^2)+4*(n11)^2;
       o(3,i)=((n30-3*n12)^2)+(3*n21-n03)^2;
       o(4,i)=((n30-n12)^2)+(n21-n03)^2;
       o(5,i)=(n30-3*n12)*(n30+n12)*(((n30+n12)^2)-3*((n21+n03)^2))+(3*n21-n03)*(n21+n03)*(3*((n30+n12)^2)-((n21+n03)^2));
       o(6,i)=(n20-n02)*(((n30+n12)^2)-((n21+n03)^2))+4*n11*(n30+n12)*(n21+n03);
       o(7,i)=(3*n21-n30)*(n30+n12)*(((n30+n12)^2)-(3*(n21+n03)^2))+(3*n21-n03)*(n21+n03)*((3*(n30+n12)^2)-((n21+n03)^2));
       
       for j=1:7
           if o(j)==0
               o(j,i)=1*exp(-100);
           else
               o(j,i)=abs(log(abs(o(j))));
           end
       end
    end
    
    momentos=o;
end