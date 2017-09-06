% Cuantificacion individual de caracter�sticas y primera selecci�n

[F C] = size(input);
titulos = ['Compacticidad';'Excentricidad';'BoundingBox  ';'ConvexHull   ';'EulerNumber  ';'Hu1          ';'Hu2          ';'Hu3          ';'Hu4          ';'Hu5          ';'Hu6          ';'Hu7          '];
gradoSep_J = zeros(12,1);

for i=1:2:(F-1) % Mostramos las gr�ficas de 2 en 2 caracter�sticas
    X = i;
    Y = i+1;
    gradoSep_J(X) = indiceJ(input(X,:),output); % C�lculo del grado de separabilidad J
    gradoSep_J(Y) = indiceJ(input(Y,:),output);
%     figure;    
%     plot(input_Norm(X,output==1),input_Norm(Y,output==1),'rO'),
%     hold on,
%     plot(input_Norm(X,output==2),input_Norm(Y,output==2),'b*'),
%     hold on,
%     plot(input_Norm(X,output==3),input_Norm(Y,output==3),'g^');
%     xlabel(titulos(X,:));
%     ylabel(titulos(Y,:));
%     hold off;    
    
end



% Obtenci�n de los 6 m�s relevantes
% Una vez que tenemos el grado de Separabilidad J, ordenamos de mayor
% a menor y obtenemos los 6 mejores. Para ello cogemos el mejor
% y lo ponemos a -inf para que no entre en juego. Luego volvemos a
% buscar. As� para los 6 mejores.
mejores = zeros(6,1);
gradoJ = gradoSep_J; % Tratamos con una copia
for i=1:6
    index = find(gradoJ==max(gradoJ)); % Buscamos el �ndice del mejor
    mejores(i) = index; % Obtenemos los �ndices de los mejores
    gradoJ(index) = -inf; % Lo ponemos a - infinito para que no vuelva a ser el mejor
end

