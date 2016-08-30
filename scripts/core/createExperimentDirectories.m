function [classificationResultDir,clusteringResultDir,experimentResultDir]= createExperimentDirectories(experimentConf)

%% configurations
experimentName = experimentConf.experimentName;
resultsPath = experimentConf.resultsPath;

%% Creating directories
experimentResultDir=[resultsPath,experimentName,'_RES',filesep];
[~,message]= mkdir(experimentResultDir);
if strcmp('Directory already exists.',message)
    disp(message);
end
   
if ~isempty(experimentConf.classifiers)
    classificationResultDir=[experimentResultDir,'Classification',filesep];
    [~,message]= mkdir(classificationResultDir);
    if strcmp('Directory already exists.',message)
        disp(message);
    end
else
    classificationResultDir=[];
end
if ~isempty(experimentConf.clusteringAlgorithms)
    clusteringResultDir=[experimentResultDir,'Clustering',filesep];
    [~,message]= mkdir(clusteringResultDir);
    if strcmp('Directory already exists.',message)
        disp(message);
    end
else
    clusteringResultDir=[];
end

% if isempty(classificationResultDir) && isempty(clusteringResultDir)
%     disp('No models for feature selection evaluation!!')
% end