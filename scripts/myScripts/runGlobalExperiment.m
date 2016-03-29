function [ok]=runGlobalExperiment(experimentConf)

experimentName = experimentConf.experimentName;
resultsPath = experimentConf.resultsPath;
dataSetsPath = experimentConf.dataSetsToProcessPath;
dataSets = experimentConf.dataSetList;
algorithms = experimentConf.fsAlgorithms;
numOfFeaturesACCrankingEvaluation = experimentConf.numOfFeaturesACCrankingEvaluation

experimentResultDir=[resultsPath,experimentName,'_RES\'];
[status,message]= mkdir(experimentResultDir);
if strcmp('Directory already exists.',message)
    disp(message);
end

for i=1:length(dataSets) %First datasets
    [dataSetName,path] = getDataSetName_path(dataSets{i});
    [name,remain]=strtok(dataSetName,'.');
    datasetResultDir=[experimentResultDir,name,'\'];
    [status,message]= mkdir(datasetResultDir);
    if strcmp('Directory already exists.',message)
        disp(message);
    end
    prepareDataSets(dataSets(i), datasetResultDir, 7, true)    % Prepare data
    for j=1:length(algorithms)%Then Algorithms        
        runExperiment(algorithms{j}.name,dataSets(i),datasetResultDir,dataSetsPath,numOfFeaturesACCrankingEvaluation,true);
    end
end
ok='true';
end