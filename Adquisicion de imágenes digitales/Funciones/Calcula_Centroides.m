function Centroides = Calcula_Centroides (Matriz_Etiquetada,N)
    %areas=Calcula_Areas(Matriz_Etiquetada);
    Centroides=zeros(N,2);
    for i=1:N
       [F C]=find(Matriz_Etiquetada==i);
       Centroides(i,1)=mean(F);
       Centroides(i,2)=mean(C);        
    end
end