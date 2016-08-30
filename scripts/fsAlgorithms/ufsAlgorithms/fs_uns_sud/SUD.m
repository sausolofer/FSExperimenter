function [out] = SUD(instances)

sud = javaObject('fsmdl.featureSelection.filter.SUD');
sud.evaluateFeatures(instances);
index = sud.getFeatureRank;
valRank = sud.getValues;

out.W = valRank'; %weight of each features
out.fList = index'+1; %contains a set of feature index. Features in the top of the rank list are most relevant features according to the algorithm
out.prf = 1; %smaller the weights are the more relevant (.prf=-1).