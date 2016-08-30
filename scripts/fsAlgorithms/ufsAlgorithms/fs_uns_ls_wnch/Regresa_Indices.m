function indices=Regresa_Indices(Original,Var_sel)
[m,n]=size(Original);
[m2,n2]=size(Var_sel);
indices=[];
for i=1:n2
    for j=1:n
        v=isequal(Var_sel(:,i),Original(:,j));
        if(v==1)
            indices=[indices,j];
        end
    end
end
