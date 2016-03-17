function [out] = fsLaplacianScore(X,idMed)

%configuracion de opciones
if idMed == 1
   options = [];
   options.Metric = 'Euclidean';
   options.NeighborMode = 'KNN';
   options.k =5;%round((1/3)*size(datos,1) );
   options.WeightMode = 'HeatKernel';
   %options.numCluster=clusters;
   options.idM = idMed;
else
   options = [];
   options.Metric = 'Cosine';
   options.NeighborMode = 'KNN';
   options.k = 5;
   options.WeightMode = 'Cosine';
   %options.numCluster = clusters;
   options.idM = idMed;

end
% Se construye el grafo de distancias (matriz de afinidad) de acuerdo a las opciones dadas
  W = constructW(X,options);
 
% Se calcula el score Laplaciano 
  LaplacianScoreRes = scoreLaplaciano2(X,W);
 %ordena los indices con respecto a sus valores
  [~, index] = sort(LaplacianScoreRes);
  
  %wFeat = junk;
  %indicesRank=index;
  
  out.W = LaplacianScoreRes*-1; %weight of each features
  out.fList = index; %contains a set of feature index. Features in the top of the rank list are most relevant features according to the algorithm
  out.prf = -1; %smaller the weights are the more relevant (.prf=-1).
  %out.fImp = false; % is a subset selection algorithm?