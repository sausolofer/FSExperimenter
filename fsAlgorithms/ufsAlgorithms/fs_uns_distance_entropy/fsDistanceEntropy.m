function [out] = fsDistanceEntropy(X)

[indRank,valRank]= MuestreoAleatorio(X);
%[indRank,valRank]= MuestreoAleatorio(X,100);

%ordena los indices con respecto a sus valores
[~, index] = sort(valRank);
  
out.W = valRank*-1; %weight of each features
out.fList = index; %contains a set of feature index. Features in the top of the rank list are most relevant features according to the algorithm
out.prf = -1; %smaller the weights are the more relevant (.prf=-1).
%out.fImp = false; % is a subset selection algorithm?