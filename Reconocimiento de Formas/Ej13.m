% Seleccion final de características

% Cálculo de la mejor combinacion
combinaciones = combnk(mejores,3);
[F C] = size(combinaciones);
sepa = zeros(1,F);
for i=1:F
    I = input(combinaciones(i,:),:); % Devuelve las 3 columnas de cada combinacion
    sepa(i) = indiceJ(I,output); % Separabilidad conjunta
end
indexMayorSepa = find(sepa==max(sepa)); % Obtenemos los índices de los mejores

mejorCombinacion = combinaciones(indexMayorSepa,:);
save('mejorCombinacion','mejorCombinacion');

% num2str(sepa(:)) 
 
% % Graficas 3D
% for i=1:F % Cuidao que saltan 20 ventanas XD
%     figure,
%     plot3(input_Norm(combinaciones(i,1),output==1),input_Norm(combinaciones(i,2),output==1),input_Norm(combinaciones(i,3),output==1),'rO'),
%     hold on,   
%     plot3(input_Norm(combinaciones(i,1),output==2),input_Norm(combinaciones(i,2),output==2),input_Norm(combinaciones(i,3),output==2),'b*'),
%     hold on,
%     plot3(input_Norm(combinaciones(i,1),output==3),input_Norm(combinaciones(i,2),output==3),input_Norm(combinaciones(i,3),output==3),'g^'),
%     xlabel(titulos(combinaciones(i,1),:));
%     ylabel(titulos(combinaciones(i,2),:));
%     zlabel(titulos(combinaciones(i,3),:));
%     hold off;
% end


% CREAR PLANO DE SEPARABILIDAD A PARTIR DELA FORMULA DE SEPARABILIDAD
% CALCULADA PARA CADA DOS CARACTERISTICAS

%     plot3(input_Norm(mejorCombinacion(1),output==1),input_Norm(mejorCombinacion(2),output==1),input_Norm(mejorCombinacion(3),output==1),'rO'),
%     hold on,   
%     plot3(input_Norm(mejorCombinacion(1),output==2),input_Norm(mejorCombinacion(2),output==2),input_Norm(mejorCombinacion(3),output==2),'b*'),
%     hold on,
%     plot3(input_Norm(mejorCombinacion(1),output==3),input_Norm(mejorCombinacion(2),output==3),input_Norm(mejorCombinacion(3),output==3),'g^'),
%     xlabel(titulos(mejorCombinacion(1),:));
%     ylabel(titulos(mejorCombinacion(2),:));
%     zlabel(titulos(mejorCombinacion(3),:));
%     grid on
% 
%     for i=-1.5:0.01:1.5
%             hold on,
%             x1=i;
%             x3=i;
%     %         dstD = double(325388127191107/1125899906842624*x1-2471004076710859617852567966404521/2535301200456458802993406410752+10317813440168735/562949953421312*x2+3643502223534401/140737488355328*x3); 
%         x = double(325388127191107/1125899906842624*x1);
%         y = -1.5:1.5;
%         z = double(3643502223534401/140737488355328*x3);
%         plot3(x,y,z,'y*');
%         
%     end
%     hold off

% Bibliografia: http://www.sc.ehu.es/sbweb/energias-renovables/MATLAB/simbolico/geometria/geometria.html
