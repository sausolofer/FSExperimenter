function experimentConf = loadExperimentConf()

experimentConf = [];

%% Experiment name
experimentConf.experimentName = 'Exp1';

%% Paths
curPath = pwd;
% Results directory path
experimentConf.resultsPath = [curPath,filesep,'ResultsDir',filesep];
% Processing datasets path
experimentConf.dataSetsToProcessPath=[curPath,filesep,'dataSets', filesep];
experimentConf.dataSetList = getDataSetListFromPath(experimentConf.dataSetsToProcessPath);
%dataset = java.lang.String([pwd,filesep,'Data',filesep,'iris.arff']);

%% Feature Selection Algorithms
% FS algorithms to apply list
fsAlgorithmsList={'laplacian score','spectrum','distance entropy','svd entropy'};
experimentConf.fsAlgorithms = loadAlgoritmsConf(fsAlgorithmsList,'Feature selection algorithms');

%% Classifiers
% Classifiers to apply list
classifiersList={'Naive Bayes','SVM','KNN','C4.5'};
experimentConf.classifiers = loadAlgoritmsConf(classifiersList,'Classifiers');

%% Clustering algorithms
% Clustering algorithms to apply list
clusteringAlgorithmsList={'Kmeans','EM','Cobweb'};
experimentConf.clusteringAlgorithms = loadAlgoritmsConf(clusteringAlgorithmsList,'Clustering algorithms');

%% Other Options
experimentConf.numOfFeaturesACCrankingEvaluation =  2;

