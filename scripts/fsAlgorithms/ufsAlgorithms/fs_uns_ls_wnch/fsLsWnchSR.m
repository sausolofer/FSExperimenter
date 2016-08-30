function [ out ] = fsLsWnchSR(instances, idMedida)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algoritmo Hibrido basado en en el rank del Laplacian Score y CH        %
%
%                                                                         %
% entrada: conjunto de datos,                                             %
%          opciones dadas                                                 %
%                                                                         %
% salida: Mejor subconjunto de  Sbest                                     %
%         mejor score                                                     %
%         tiempo de ejecucion                                             %
%                                                                         %
% Autor: Saul Solorio Fernandez, MC. CS. Computacionales, INAOE           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% initializes the parameters
%numInstances = instances.numInstances;
numAttributes = instances.numAttributes-1; %Always number of attributes minus the class atrribute
clusters = instances.numClasses;
[X,~] = getNumericCodification(instances);

%configuracion de opciones
if idMedida == 1
    options = [];
    options.Metric = 'Euclidean';
    options.NeighborMode = 'KNN';
    options.k =5%round((1/3)*size(datos,1) );
    options.WeightMode = 'HeatKernel';
    options.numCluster = clusters;
    options.idM = idMedida;
else
    options = [];
    options.Metric = 'Cosine';
    options.NeighborMode = 'KNN';
    options.k = 5;
    options.WeightMode = 'Cosine';
    options.numCluster = clusters;
    options.idM = idMedida;
end

gamaBest = -1000;
indSbest=[];
valores=[];
medida={'sqEuclidean','cosine'};
%% Etapa filter
% evalua la relevancia de las variables con metodo filter Basado en el Laplacian Score (rank)
[indicesRank,~]= laplacianScoreVar(X,options);
S=[];
for i = 1:numAttributes
    S = [S,indicesRank(i)]; % genera un subconjunto con cardinalidad i para evaluacion
    datosCand = X(:,S);
    %Se corre el algoritmo k-means con k clusters para el subconjunto de variables
    [idx] = kmeans(datosCand,options.numCluster,'distance',medida{options.idM},'emptyaction','drop','replicates',3,'start','sample');
    % Se evalua con medida wrapper (Calinski- Harabazs Normalized Index )
    gama =CHN(datosCand,idx);%*(1/valRank(i));
    if(gama>gamaBest)
        gamaBest = gama;
        indSbest=S;
    end
    valores=[valores,gama];
end

out.W = valores; %weight of each feature
out.fList = indSbest; %contains a set of feature index. Features in the top of the rank list are most relevant features according to the algorithm
out.prf = 0; %smaller the weights are the more relevant (.prf=-1).
out.fImp = true; % is a subset selection algorithm?

end