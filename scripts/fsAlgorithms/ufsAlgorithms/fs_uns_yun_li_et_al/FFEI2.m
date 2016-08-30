function indice = FFEI2(subConjuntoCandidato,ConjuntoOriginal,beta)

[m,n]=size(subConjuntoCandidato);
constante = 2/(m*(m-1));
dmax = D(subConjuntoCandidato,beta);
indiceAux=0;
Y=pdist(subConjuntoCandidato,'euclidean');

for pq=1:length(Y);
 %   indiceParcial=0;
    %for q=1:m
        
        
        aux1=FuncionDeMembresia2(Y(pq),dmax)*(1-FuncionDeMembresia2(ConjuntoOriginal(pq),dmax));
        aux2=FuncionDeMembresia2(ConjuntoOriginal(pq),dmax)*(1-FuncionDeMembresia2(Y(pq),dmax));
        indiceParcial = (1/2)*(aux1+aux2);
  %  end
    
    indiceAux=indiceAux+indiceParcial;
        
end
    indice=constante*indiceAux;