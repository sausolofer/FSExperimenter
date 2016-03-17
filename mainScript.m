%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main script for execute the feature selection algorithms on datasets
% Institution INAOE
% Author: Saul Solorio Fdez.
% Version 1.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% clear workspace 
clc;
clear all;
load_myFSpackage;

%% Experiment setting and options
experimentName = 'Exp2';
numOfFeaturesACCrankingEvaluation =  2;

%% paths
curPath = pwd;
% Results path
resultsPath = [curPath,filesep,'ResultsDir',filesep];
dataSetsPath=[curPath,filesep,'dataSets', filesep];

%% dataSets
%datasetsCell={'iris'};
datasetsCell={'Lymphoma2Classes','Leukemia_train','EmbrionalTumor','warpPIE10P','PCMAC','RELATHE','BASEHOCK','orlraws10P'};
for i=1:length(datasetsCell)
    datasetsCell(i)=strcat(dataSetsPath, datasetsCell(i));
end
%dataSetsToProcessPath = [pwd,filesep,'DataSets',filesep];
%dataSetList = getDataSetListFromPath(dataSetsToProcessPath);
%dataset = java.lang.String([pwd,filesep,'Data',filesep,'iris.arff']);


%% UNSUPERVISED FEATURE SELECTORS
%selectorsCell={'cfs'};
%selectorsCell={'laplacian score','spectrum','distance entropy','svd entropy'};
selectorsCell={'spectrum'};

[ok]=runExperimentOnDatasets(selectorsCell,datasetsCell,experimentName,numOfFeaturesACCrankingEvaluation,resultsPath)
disp('finished');
%%

%runExperimentOnDatasets(algorithms,dataSetList,experimentName,resultsPath,options)
%disp([experimentName,' finished!']);