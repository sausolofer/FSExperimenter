function [out] = fsRrfs(instances)
% Relevance-redundancy feature selection (RRFS) is an efficient feature selection method 
% based on relevance and redundancy analyses, which can work in both supervised and unsupervised modes.

%% initializes the parameters
%numInstances = instances.numInstances;
numAttributes = instances.numAttributes-1; %Always number of attributes minus the class atrribute
numOfClasses = instances.numClasses;

%Default values
sizeSelectedFeatureSubset = 5; %the number of selected features
similarity = 0.4;

%%
[X,Y] = getNumericCodification(instances);
inputData = [X,Y];
rrfs = javaObject('kfst.featureSelection.filter.unsupervised.RRFS', sizeSelectedFeatureSubset, similarity);
rrfs.loadDataSet(inputData, int32(numAttributes), int32(numOfClasses));
rrfs.evaluateFeatures();
subset = rrfs.getSelectedFeatureSubset();
FeatureValues = rrfs.getValues();

out.W = FeatureValues; %weight of each feature
out.fList = subset'+1; %contains a set of feature index. Features in the top of the rank list are most relevant features according to the algorithm
out.prf = -1; %smaller the weights are the more relevant (.prf=-1).
out.fImp = true; % is a subset selection algorithm?

end