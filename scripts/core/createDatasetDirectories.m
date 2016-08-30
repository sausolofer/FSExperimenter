function [onlyName, classifDatasetResultDir,clustDatasetResultDir] = createDatasetDirectories(dataSet, experimentResultDir, classificationResultDir, clusteringResultDir, experimentConf)
%Funtion for creating directories an data preparation

onlyName = strtok(getDataSetName_path(dataSet),'.');
nfClassif = experimentConf.numberOfFoldsForClassification;
nfClust = experimentConf.numberOfFoldsForClustering;
dataStandardization =  experimentConf.standardizeDatasets;
imputeMissingValues = experimentConf.imputeMissingValues;
seed = experimentConf.seed;

if ~isempty(classificationResultDir)
    typeOfExperiment= 'Classification';
    classifDatasetResultDir=[classificationResultDir,onlyName,filesep];
    [~,message]= mkdir(classifDatasetResultDir);
    if strcmp('Directory already exists.',message)
        disp(message);
    end
    prepareDataSets(dataSet, classifDatasetResultDir, nfClassif, dataStandardization, imputeMissingValues, seed, typeOfExperiment);    % Data preparation for classification
    % Creating other directories
    plotDirectory = [classifDatasetResultDir,'Plots', filesep];
    mkdir(plotDirectory);
    mkdir([plotDirectory,'sources', filesep]);
    mkdir([plotDirectory,'eps', filesep]);
    
    mkdir([classifDatasetResultDir,'FeatureSelection',filesep]);
    mkdir([classifDatasetResultDir,'PerformanceEval',filesep]);
    mkdir([classifDatasetResultDir,'Statistics',filesep]);
else
    classifDatasetResultDir=[];
end

if ~isempty(clusteringResultDir)
    typeOfExperiment= 'Clustering';
    clustDatasetResultDir=[clusteringResultDir,onlyName,filesep];
    [~,message]= mkdir(clustDatasetResultDir);
    if strcmp('Directory already exists.',message)
        disp(message);
    end
    prepareDataSets(dataSet, clustDatasetResultDir, nfClust, dataStandardization, imputeMissingValues, seed, typeOfExperiment);    % Data preparation for clustering
    % Creating other directories
    plotDirectory = [clustDatasetResultDir,'Plots', filesep];
    mkdir(plotDirectory);
    mkdir([plotDirectory,'sources', filesep]);
    mkdir([plotDirectory,'eps', filesep]);
    mkdir([clustDatasetResultDir,'FeatureSelection',filesep]);
    mkdir([clustDatasetResultDir,'PerformanceEval',filesep]);
    mkdir([clustDatasetResultDir,'Statistics',filesep]);
    
else
    clustDatasetResultDir=[];
end

if isempty(classifDatasetResultDir) && isempty(clustDatasetResultDir)
    typeOfExperiment= '';
    datasetResultDir=[experimentResultDir,onlyName,filesep];
    [~,message]= mkdir(datasetResultDir);
    if strcmp('Directory already exists.',message)
        disp(message);
    end
    prepareDataSets(dataSet, datasetResultDir, nfClust, dataStandardization, imputeMissingValues, seed, typeOfExperiment);    % Data preparation for clustering
    % Creating other directories
    mkdir([datasetResultDir,'FeatureSelection',filesep]);
end

end