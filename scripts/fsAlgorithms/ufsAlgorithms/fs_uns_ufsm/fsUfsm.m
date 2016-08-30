function [out] = fsUfsm(instances)

ufsm = javaObject('fsmdl.featureSelection.filter.Ufsm');
ufsm.setkNearestNeighborValue(5);
ufsm.evaluateFeatures(instances);
index = ufsm.getFeatureRank;
valRank = ufsm.getValues;

out.W = valRank'; %weight of each features
out.fList = index'+1; %contains a set of feature index. Features in the top of the rank list are most relevant features according to the algorithm
out.prf = -1; %smaller the weights are the more relevant (.prf=-1).
