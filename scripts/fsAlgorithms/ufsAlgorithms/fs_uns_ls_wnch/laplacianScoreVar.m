function [indicesRank,valor]= laplacianScoreVar(datos,options)

% Se construye el grafo de distancias (matriz de afinidad) de acuerdo a las opciones dadas
  W = constructW(datos,options);
 
% Se calcula el score Laplaciano 
  %LaplacianScoreRes = LaplacianScore(datos,W);
   LaplacianScoreRes = scoreLaplaciano2(datos,W);
 %ordena los indices con respecto a sus valores
   [junk, index] = sort(LaplacianScoreRes);
  %[junk, index] = sort(-LaplacianScoreRes);
      
  % indices=index(1:variablesAtomar)-1 
  % instanceSel=Interfaz.getInstances(indices,instances);
   valor = junk;
   indicesRank=index;
       