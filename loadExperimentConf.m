function experimentConf = loadExperimentConf()
% This is the main script file for configuring the genearal experiment

experimentConf = [];
%###########################################################################
% STARTS COFIGURATION ZONE

%% Experiment name
experimentName = 'ExpNominalNewEntropyMethod';

%% Paths
%curPath = pwd;
% Processing datasets path
%dataSetsToProcessPath=[curPath,filesep,'dataSets', filesep,'MixedData',filesep];
%dataSetsToProcessPath='/home/ssf/FsExperimenter/DataSets/MixedData/UCI_Datasets/';
dataSetsToProcessPath='/home/ssf/NetBeansProjects/FSMDL/DataSets/NominalData/UCI_Datasets/'
%%dataSetsToProcessPath='/home/ssf/Escritorio/DataTest/'
%dataSetsToProcessPath = 'C:\Users\SSF\Documents\MATLAB\FsExperimenter\DataSets\MixedData\UCI_Datasets\';
%dataSetsToProcessPath = 'E:\Dropbox\PROYECTO_DOCTORAL\Codigos\FsExperimenter\DataSets\MixedData\UCI_Datasets\';
%dataSetsToProcessPath = 'C:\Users\SSF\Documents\SpiderOak Hive\FsExperimenter\DataSets\NumericData\DrFco\PCA\';
%dataSetsToProcessPath='C:\Users\SSF\Desktop\DataTest\';

% Results directory path
%experimentConf.resultsPath = [curPath,filesep,'ResultsDir',filesep];
%resultsPath = 'C:\Users\SSF\Documents\TESTDIR\';
%resultsPath = 'C:\Users\Saul\Documents\TESTDIR\';
resultsPath = '/home/ssf/TEST_DIR/';

%% Feature Selection Algorithms codes
% FS algorithms to apply list 
% OPTIONS:
% / Traditional and best unsupervised algorithms of the state of the art /
% 'fsfs'   %Mitra's method 
% 'distanceEntropy'
% 'laplacianScore'
% 'spectrum' 
% 'svdEntropy'

%/FOR MIXED DATA
% 'Usfsm'  %>Our method
% 'Ufsm' 
% 'Ufsme' 
% 'SUD'

% / Evolutive algorithms /
% 'UFSACO'
% 'MGSACO'
% 'RRFSACO1'
% 'RRFSACO2'
% 'IRRFSACO1'
% 'IRRFSACO2'

% / others
% 'RRFS'
% 'MutualCorrelation'

% /Hibryds/
% 'DashAndLiuFSAlgorithm'
% 'YunLiEtAl'
% 'LSWNCHSR'
% 'LSWNCHBE'

%fsAlgorithmsList = {'svdEntropy','SPEC','laplacianScore','fsfs','FsKmeans','UFSACO', 'MGSACO', 'RRFSACO1', 'IRRFSACO1', 'IRRFSACO2','RRFS', 'MutualCorrelation', 'LSWNCHSR','SimpleRanking'};
fsAlgorithmsList = {'svdEntropy','SPEC','laplacianScore','SUD','Ufsme','Ufsm'};
%fsAlgorithmsList = {'SUD','Ufsme','Ufsm'};
%fsAlgorithmsList = {};

%% Clustering algorithms
% List of Clustering algorithms to apply (if list is empty it is not perfomed Feature selection evaluation with any algorithm)
% OPTIONS:
% 'Kmeans'

clusteringAlgorithmsList={'Kmeans'};
%clusteringAlgorithmsList = {};
%% Classifiers
% List of Classifiers to apply (if list is empty it is not perfomed Feature selection evaluation with any algorithm)
% OPTIONS:
% 'Naive Bayes'
% 'C4.5'
% 'Knn'

classifiersList = {'Naive Bayes','C4.5','IBk','Knn'}; 
%classifiersList = {'IBk'}; 
%classifiersList={};
%% Evaluation measures
% Clustering Options:
% 'ACC'
% 'Nmi'
% 'Jaccard'
% 'Silhouette'
clusteringEvaluationMeasures = {'Nmi','ACC','Jaccard','Silhouette'};

% Classification Options:
% 'ACC'
% 'ClassificationError'
classificationEvaluationMeasures = {'ACC'};


%% Other Options
%Global options
imputeMissingValues = true; % means-modes imputation method
standardizeDatasets = false;
plot = true;
plotAverage = true; % For overall comparison (Feature subset algorithms and rankers)
seed = 5; % Used to initialize the pseudorandom number generator 
skipRunTimeErrors = true;

%Classification options
numOfFeaturesForEvaluationClassif =  0.50; % In percent (0 < x < 1) or number of features
classificationEvaluationStep = 0.25; % In percent (0 < x < 1) or number of increment (>1)  
numberOfFoldsForClassification = 5;% 1 Same data for feature selection training and validation

%Clustering options
numOfFeaturesForEvaluationClust =  0.50; % In percent (0 < x < 1) or number of features
clusteringEvaluationStep = 0.25; % In percent (0 < x < 1) or number of increment (>1)  
numberOfFoldsForClustering = 5; % 1 complete data for feature selection and clustering
numberOfClusteringRuns = 5;


% ENDS CONFIGURATION ZONE
%###############################################################################
%% Setting options (don't touch this area)
experimentConf.experimentName = experimentName;
experimentConf.dataSetsToProcessPath = dataSetsToProcessPath;
experimentConf.resultsPath = resultsPath;

experimentConf.dataSetList = getDataSetListFromPath(experimentConf.dataSetsToProcessPath);
experimentConf.fsAlgorithms = loadAlgorithmsConf(fsAlgorithmsList,'Feature selection');
experimentConf.classifiers = loadAlgorithmsConf(classifiersList,'Classifiers');
experimentConf.clusteringAlgorithms = loadAlgorithmsConf(clusteringAlgorithmsList,'Clustering algorithms');
experimentConf.classificationEvaluationMeasures = classificationEvaluationMeasures;
experimentConf.clusteringEvaluationMeasures = clusteringEvaluationMeasures;

experimentConf.imputeMissingValues = imputeMissingValues;
experimentConf.standardizeDatasets = standardizeDatasets;
experimentConf.plot = plot;
experimentConf.plotAverage = plotAverage; 
experimentConf.seed = seed;
experimentConf.skipRunTimeErrors = skipRunTimeErrors;

experimentConf.numOfFeaturesForEvaluationClassif = numOfFeaturesForEvaluationClassif;
experimentConf.classificationEvaluationStep = classificationEvaluationStep;
experimentConf.numberOfFoldsForClassification = numberOfFoldsForClassification;

experimentConf.numOfFeaturesForEvaluationClust =  numOfFeaturesForEvaluationClust;
experimentConf.clusteringEvaluationStep = clusteringEvaluationStep;
experimentConf.numberOfFoldsForClustering = numberOfFoldsForClustering;
experimentConf.numberOfClusteringRuns = numberOfClusteringRuns;

% Checking OS
if(strcmp(getenv('OS'),'Windows_NT'))
    experimentConf.os = 'Win';
else
    experimentConf.os = 'Linux';
end
