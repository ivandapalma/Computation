clear all 
d = importdata('training2.csv', ' ')
ds = cell2mat(strfind(d,','));
for n=1:size(ds,2)
    for k=1:size(ds,1)
        if k==1
            ini=0;
            final=ds(n,k);
        else
            ini=ds(n,k-1);
            final=ds(n,k);
        end
        matriz{n,k}=d{n}(ini+1:final-1); 
    end
end
for i=1:size(matriz,2)
    matriz(:,i)
end