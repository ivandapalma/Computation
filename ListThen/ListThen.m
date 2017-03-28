function listThen = ListThen(dataSet, dataUniques,columnaComparativa,nombreClase)

    % PERFECT!
    % allcomb({'Small','Large'},{'Blue','Red'},{'Circle','Triangle'}) 
    
    [C,F] =  size(dataUniques);
    
    if(C == 2)
        combinaciones = allcomb(dataUniques(1,:), dataUniques(2,:));
    elseif (C == 3)
        combinaciones = allcomb(dataUniques(1,:), dataUniques(2,:), dataUniques(3,:));
    elseif (C == 4)
        combinaciones = allcomb(dataUniques(1,:), dataUniques(2,:), dataUniques(3,:), dataUniques(4,:));
    elseif (C == 5)
        combinaciones = allcomb(dataUniques(1,:), dataUniques(2,:), dataUniques(3,:), dataUniques(4,:), dataUniques(5,:));
    elseif (C == 6)
        combinaciones = allcomb(dataUniques(1,:), dataUniques(2,:), dataUniques(3,:), dataUniques(4,:), dataUniques(5,:), dataUniques(6,:));
    elseif (C == 7)
        combinaciones = allcomb(dataUniques(1,:), dataUniques(2,:), dataUniques(3,:), dataUniques(4,:), dataUniques(5,:), dataUniques(6,:), dataUniques(7,:) );
    elseif (C == 8)
        combinaciones = allcomb(dataUniques(1,:), dataUniques(2,:), dataUniques(3,:), dataUniques(4,:), dataUniques(5,:), dataUniques(6,:), dataUniques(7,:),dataUniques(8,:));
    elseif (C == 9)
        combinaciones = allcomb(dataUniques(1,:), dataUniques(2,:), dataUniques(3,:), dataUniques(4,:), dataUniques(5,:), dataUniques(6,:), dataUniques(7,:),dataUniques(8,:), dataUniques(9,:));
    elseif (C == 10)
        combinaciones = allcomb(dataUniques(1,:), dataUniques(2,:), dataUniques(3,:), dataUniques(4,:), dataUniques(5,:), dataUniques(6,:), dataUniques(7,:),dataUniques(8,:), dataUniques(9,:), dataUniques(10,:));
    elseif (C == 11)
        combinaciones = allcomb(dataUniques(1,:), dataUniques(2,:), dataUniques(3,:), dataUniques(4,:), dataUniques(5,:), dataUniques(6,:), dataUniques(7,:),dataUniques(8,:), dataUniques(9,:), dataUniques(10,:), dataUniques(11,:));
    elseif (C == 12)
        combinaciones = allcomb(dataUniques(1,:), dataUniques(2,:), dataUniques(3,:), dataUniques(4,:), dataUniques(5,:), dataUniques(6,:), dataUniques(7,:),dataUniques(8,:), dataUniques(9,:), dataUniques(10,:), dataUniques(11,:), dataUniques(12,:));
    elseif (C == 13)
        combinaciones = allcomb(dataUniques(1,:), dataUniques(2,:), dataUniques(3,:), dataUniques(4,:), dataUniques(5,:), dataUniques(6,:), dataUniques(7,:),dataUniques(8,:), dataUniques(9,:), dataUniques(10,:), dataUniques(11,:), dataUniques(12,:), dataUniques(13,:));
    elseif (C == 14)
        combinaciones = allcomb(dataUniques(1,:), dataUniques(2,:), dataUniques(3,:), dataUniques(4,:), dataUniques(5,:), dataUniques(6,:), dataUniques(7,:),dataUniques(8,:), dataUniques(9,:), dataUniques(10,:), dataUniques(11,:), dataUniques(12,:), dataUniques(13,:), dataUniques(14,:));
    else % C == 15
        combinaciones = allcomb(dataUniques(1,:), dataUniques(2,:), dataUniques(3,:), dataUniques(4,:), dataUniques(5,:), dataUniques(6,:), dataUniques(7,:),dataUniques(8,:), dataUniques(9,:), dataUniques(10,:), dataUniques(11,:), dataUniques(12,:), dataUniques(13,:), dataUniques(14,:), dataUniques(15,:));
    end
    
    listThen = combinaciones;
end