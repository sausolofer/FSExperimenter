function [out] = fsRrfsaco2(instances)
% Relevance-redundancy feature selection based on ACO, version2 (RRFSACO_2)
% is an unsupervised method that can handle both irrelevant and redundant 
% features in an acceptable time. In the RRFSACO_2 the relevance of the selected
% features is considered in the search process of the ants.

%% initializes the parameters
%numInstances = instances.numInstances;
numAttributes = instances.numAttributes-1; %Always number of attributes minus the class atrribute
numOfClasses = instances.numClasses;

%Default values
sizeSelectedFeatureSubset = 5; %the number of selected features
initPheromone = 0.2; %the initial value of the pheromone
numIterations = 50; %the maximum number of iteration
if numAttributes < 100
    numAnt = numAttributes; %the number of ants
else
    numAnt = 100; %the number of ants
end
numFeatureOfAnt = sizeSelectedFeatureSubset; %the number of selected features by each ant in each iteration
evaporationRate = 0.2; %the evaporation rate of the pheromone
alphaParameter = 1.0;
betaParameter = 1.0; %the beta parameter in the state transition rule
q0_Parameter = 0.7;  %the q0 parameter in the state transition rule

%%
[X,Y] = getNumericCodification(instances);
inputData = [X,Y];
mgsaco = javaObject('kfst.featureSelection.filter.unsupervised.RRFSACO_2',...
    sizeSelectedFeatureSubset,initPheromone, numIterations, numAnt, numFeatureOfAnt, evaporationRate, alphaParameter, betaParameter, q0_Parameter);
mgsaco.loadDataSet(inputData, int32(numAttributes), int32(numOfClasses));
mgsaco.evaluateFeatures();
subset = mgsaco.getSelectedFeatureSubset();
FeatureValues = mgsaco.getValues();

out.W = FeatureValues; %weight of each feature
out.fList = subset'+1; %contains a set of feature index. Features in the top of the rank list are most relevant features according to the algorithm
out.prf = -1; %smaller the weights are the more relevant (.prf=-1).
out.fImp = true; % is a subset selection algorithm?

end

