function [out] = fsMgsaco(instances)
% Microarray gene selection based on ant colony optimization (MGSACO) is a 
% framework to combine the computational efficiency of the filter approach
% and the good performance of the ACO algorithm. MGSACO is unsupervised filter based gene selection method.

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
evaporationRate = 0.2; %the evaporation rate of the pheromone
betaParameter = 1.0; %the beta parameter in the state transition rule
q0_Parameter = 0.7;  %the q0 parameter in the state transition rule

%%
[X,Y] = getNumericCodification(instances);
inputData = [X,Y];
mgsaco = javaObject('kfst.featureSelection.filter.unsupervised.MGSACO',...
    sizeSelectedFeatureSubset, initPheromone, numIterations, numAnt, evaporationRate, betaParameter, q0_Parameter);
mgsaco.loadDataSet(inputData, int32(numAttributes), int32(numOfClasses));
mgsaco.evaluateFeatures();
subset = mgsaco.getSelectedFeatureSubset();
FeatureValues = mgsaco.getValues();

out.W = FeatureValues; %weight of each feature
out.fList = subset'+1; %contains a set of feature index. Features in the top of the rank list are most relevant features according to the algorithm
out.prf = 0; %smaller the weights are the more relevant (.prf=-1).
out.fImp = true; % is a subset selection algorithm?

end