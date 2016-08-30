function [ out ] = fsYunLiEtAl(instances, beta)
% Summary of this function goes here
%   Detailed explanation goes here

%% initializes the parameters
numAttributes = instances.numAttributes-1; %Always number of attributes minus the class atrribute
[X,~] = getNumericCodification(instances);

%%%% Begin method
%inicializacion

gamaBest = 1000;
indSbest=[];
valores=[];
S=[];

ConjuntoOriginal=pdist(X,'euclidean');

% evaluar con metodo filter Basado en entropia (rank)
[indRank,valRank]= MuestreoAleatorio(X);

for i=1:numAttributes
    
    S=[S,indRank(i)]; % genera un subconjunto con cardinalidad i para evaluacion
    datosCand=X(:,S);
    
    % Se evalua con medida filter ( )
    gama= FFEI2(datosCand,ConjuntoOriginal,beta);
    
    if(gama < gamaBest)
        gamaBest = gama;
        indSbest=S;
    end
    
    valores=[valores,gama];
end

out.W = valores; %weight of each feature
out.fList = indSbest; %contains a set of feature index. Features in the top of the rank list are most relevant features according to the algorithm
out.prf = 0; %smaller the weights are the more relevant (.prf=-1).
out.fImp = true; % is a subset selection algorithm?
