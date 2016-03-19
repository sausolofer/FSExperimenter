function experimentConf = loadExperimentConf()

experimentConf = [];

%% Experiment name
experimentConf.experimentName = 'Exp2';

%% Paths
curPath = pwd;
% Results directory path
%experimentConf.resultsPath = [curPath,filesep,'ResultsDir',filesep];
experimentConf.resultsPath = 'C:\Users\SSF\Documents\TESTDIR\';
% Processing datasets path
experimentConf.dataSetsToProcessPath=[curPath,filesep,'dataSets', filesep];
experimentConf.dataSetList = getDataSetListFromPath(experimentConf.dataSetsToProcessPath);
%dataset = java.lang.String([pwd,filesep,'Data',filesep,'iris.arff']);

%% Feature Selection Algorithms
% FS algorithms to apply list
%fsAlgorithmsList={'laplacian score','spectrum','distance entropy','svd entropy'};
fsAlgorithmsList={'laplacian score','spectrum'};
experimentConf.fsAlgorithms = loadAlgorithmsConf(fsAlgorithmsList,'Feature selection');

%% Classifiers
% Classifiers to apply list
classifiersList={'Naive Bayes','SVM','KNN','C4.5'};
experimentConf.classifiers = loadAlgorithmsConf(classifiersList,'Classifiers');

%% Clustering algorithms
% Clustering algorithms to apply list
clusteringAlgorithmsList={'Kmeans','EM','Cobweb'};
experimentConf.clusteringAlgorithms = loadAlgorithmsConf(clusteringAlgorithmsList,'Clustering algorithms');

%% Other Options
experimentConf.numOfFeaturesACCrankingEvaluation =  2;
experimentConf.standardizeDatasets = true;

