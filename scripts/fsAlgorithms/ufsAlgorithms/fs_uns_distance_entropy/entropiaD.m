%Funcion que calcula la Entropia de un conjunto de datos

function E= entropiaD(datos)

matrizDeSim=pdist(datos,'euclidean');
aveDist = mean(matrizDeSim);
alfa = (-1*log(0.5))/aveDist;
N=length(matrizDeSim);

entParcial=0;

 for i=1:N
%     entParcial=0;
%     for j=1:M
        entParcial= entParcial+ entropia(matrizDeSim(i),alfa);
%         
%     end
%     entParcial2=entParcial2+entParcial;
 end


E=-1*entParcial/N;
