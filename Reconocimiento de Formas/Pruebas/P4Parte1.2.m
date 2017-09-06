load datosentrenamiento

%Visualización de datos: representación de los mismos en espacios de
%características bidimensionales:

s=size(input);

for i=1:s(1)
    figure
    hold on
    for j=1:max(output)
        f=find(output==j);
        mini=min(f);
        maxi=max(f);
        plot(j,input(i,mini:maxi),'*r')
    end
    hold off
end

%Calculo de la separabilidad
%Separar en otro archivo
filas=mejores3(inputnormalizada,output);

save ('filas','filas')
