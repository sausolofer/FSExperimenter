%function [ok]=runExperimentOnDatasets(algorithms,dataSets,experimentName,numOfFeaturesACCrankingEvaluation,resultsPath)
function [ok]=runExperimentOnDatasets(experimentConf)


experimentName = experimentConf.experimentName;
resultsPath = experimentConf.resultsPath;
dataSets = experimentConf.dataSetList;
algorithms = experimentConf.fsAlgorithms;
numOfFeaturesACCrankingEvaluation = experimentConf.numOfFeaturesACCrankingEvaluation 

experimentResultDir=[resultsPath,experimentName,'_RES\'];
[status,message]= mkdir(experimentResultDir);
if strcmp('Directory already exists.',message)
    disp(message);
end

for i=1:length(dataSets) %First datasets
    for j=1:length(algorithms)%Then Algorithms 
        datasetResultDir=[experimentResultDir,getDataSetName_path(dataSets{i}),'\'];
        [status,message]= mkdir(datasetResultDir);
        if strcmp('Directory already exists.',message)
            disp(message);
        end
        runExperiment(algorithms{j}.name,dataSets(i),datasetResultDir,numOfFeaturesACCrankingEvaluation,true);           
    end
end
ok='true';
end