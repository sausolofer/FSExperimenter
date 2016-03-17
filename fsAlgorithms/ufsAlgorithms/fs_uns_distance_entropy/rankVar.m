%Funcion que ejecuta El Rankeo basado en la relevancia de las variables

function [indRank,valRank]=rankVar(datos)
datosAux=datos;
rankValores=[];
[m,n]=size(datos);

for k=1:n
    datos(:,k)=[];
    calcEnt=entropiaD(datos);
    rankValores=[rankValores,calcEnt];
    datos=datosAux;
end


%valRank=rankValores;

[valRank,indRank]=sort(rankValores,'descend');

    