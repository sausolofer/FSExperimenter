function [ out ] = fsHybridDashAndLiuMethod(instances)
%FSHYBRIDDASHANDLIUMETHOD Summary of this function goes here
%   Detailed explanation goes here

%% initializes the parameters
%numInstances = instances.numInstances;
numAttributes = instances.numAttributes-1; %Always number of attributes minus the class atrribute
k = instances.numClasses;
[X,~] = getNumericCodification(instances);

%%%% Begin method
gamaBest = -1000;
indSbest=[];
valores=[];
S=[];
% evaluar con metodo filter Basado en entropia (rank)
[indRank,~]= MuestreoAleatorio(X);

for i=1:numAttributes
    S = [S,indRank(i)]; % genera un subconjunto con cardinalidad i para evaluacion
    datosCand = X(:,S);
    %Se corre el algoritmo k-means con k clusters para el subconjunto de variables
    [idx] = kmeans(datosCand,k,'distance','sqEuclidean','emptyaction','drop','replicates',3,'start','sample');
    % Se evalua con medida wrapper ( )
    gamma =criterio(datosCand,idx);
    if(gamma>gamaBest)
        gamaBest = gamma;
        indSbest=S;
    end
end

%out.W = FeatureValues; %weight of each feature
out.fList = indSbest; %contains a set of feature index. Features in the top of the rank list are most relevant features according to the algorithm
out.prf = 0; %smaller the weights are the more relevant (.prf=-1).
out.fImp = true; % is a subset selection algorithm?

end

