function resultado=descriptores(I)
    
    state=regionprops(double(I),'Eccentricity','Extent','Solidity','EulerNumber','Perimeter','Area');
    resultado(1,1)=cat(1,((cat(1,state.Perimeter).^2)./cat(1,state.Area))');
    resultado(2,1)=cat(1,state.Eccentricity)';
    resultado(3,1)=cat(1,state.Extent)';
    resultado(4,1)=cat(1,state.Solidity)';
    resultado(5,1)=cat(1,state.EulerNumber)';
    
    resultado(6:12,1)=Funcion_Calcula_Hu(I);
end