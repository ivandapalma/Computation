function filas=mejores3(input,output)
    s=size(input);
    J=[];
    for i=1:s(1)
        J(i,1)=indiceJ(input(i,:),output);
    end

    mejores6=[];
    for i=1:(length(J)/2)
        mejores6(i)=find(J==max(J));
        J(mejores6(i))=0;
    end


    maximo=length(mejores6);
    separamax=0;
    separa=0;
    filas=[];
    combina=combnk(mejores6,3);
    
    s=size(combina);
    for i=1:s(1)
       g3=input(combina(i,:),:);
       separa(i)=indiceJ(g3,output);
    end
    filas=combina(find(separa==max(separa)),:);
end