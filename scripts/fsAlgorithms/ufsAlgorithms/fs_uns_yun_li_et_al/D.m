
%Funcion que calcula el valor dmax dado un subconjunto de variables

function dmax = D(subconjuntoCandidato,beta)

[m,n]=size(subconjuntoCandidato);
dmaxParcial=0;

for i=1:n
    aux=subconjuntoCandidato(:,i);
    vecMinmax = minmax(aux');
    dmaxParcial=dmaxParcial + (vecMinmax(2) - vecMinmax(1))^2;
end

dmax = beta*(sqrt(dmaxParcial));