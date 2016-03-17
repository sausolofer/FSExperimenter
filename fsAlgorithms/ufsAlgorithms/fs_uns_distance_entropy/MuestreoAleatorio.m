function [indRank,valRank]= MuestreoAleatorio(datos,porcent,numMuestras)

   if ~exist('numMuestras', 'var')
        numMuestras = 35;
   end
   
   if ~exist('porcent', 'var')
        porcent = 5;
   end
    
[m,n]=size(datos);
OR=zeros(1,n);

for l=1:numMuestras
    indMuestra = MuestraAleatoria(m,porcent);
    muestra=datos(indMuestra,:);
    [Rank,val]=rankVar(muestra);
    
    for k=1:n
        OR(Rank(k))=OR(Rank(k))+val(k);
    end
    
end

[valRank,indRank]=sort(OR,'descend');