function indicesScore=scoreLaplaciano2(datos,W)

%funcion que calcula el Laplacian Score para cada variable

[m,n]=size(datos);

indicesScore=[];
 S=full(W);
 unos=ones(1,m);
 D=diag(S*unos');
 L=D-S;

for r=1:n     
    f=datos(:,r);
    fcir=f-(((f'*D*unos')/(unos*D*unos'))*unos');
    LScore=(fcir'*L*fcir)/(fcir'*D*fcir);

    indicesScore=[indicesScore,LScore];
end

 
 
 

 
