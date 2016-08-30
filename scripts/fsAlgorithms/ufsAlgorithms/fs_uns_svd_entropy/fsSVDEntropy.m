function [out] = fsSVDEntropy(X)
%Funcion que ejecuta la seleccion de variables de acuerdo a SVD-Entropy
datosAux=X;
rankValores=[];
%obtiene tamaño (m) y dimension (n)  de los datos
[~,n]=size(X);
%calcula la entropia del conjunto original 
entropiaTotal=SVD_Entropy(X)

for k=1:n
    X(:,k)=[]; %se elimina la k-esima variable de los datos
    %calcEnt =  SVD_Entropy(X)-entropiaTotal;
    calcEnt =  entropiaTotal-SVD_Entropy(X);
    rankValores = [rankValores,calcEnt]; %acumula valores
    X=datosAux;
end
%valRank=rankValores;
%[~,indRank]=sort(rankValores,'descend'); % Se ordenan los valores
[~,indRank]=sort(rankValores,'ascend'); % Se ordenan los valores

out.W = rankValores; %weight of each features
out.fList = indRank; %contains a set of feature index. Features in the top of the rank list are most relevant features according to the algorithm
out.prf = -1; %smaller the weights are the more relevant (.prf=-1).
%out.fImp = false; % is a subset selection algorithm?