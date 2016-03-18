function [ok]=runExperimentOnDatasets(algorithms,dataSets,experimentName,numOfFeaturesACCrankingEvaluation,resultsPath)

experimentResultDir=[resultsPath,experimentName,'_RES\'];
[status,message]= mkdir(experimentResultDir);
if strcmp('Directory already exists.',message)
    disp(message);
end

for i=1:length(dataSets) %Datasets
    for j=1:length(algorithms)%Algorithms 
        datasetResultDir=[experimentResultDir,getDataSetName_path(dataSets{i}),'\'];
        [status,message]= mkdir(datasetResultDir);
        if strcmp('Directory already exists.',message)
            disp(message);
        end
        runExperiment(algorithms(j),dataSets(i),datasetResultDir,numOfFeaturesACCrankingEvaluation,true);           
    end
end
ok='true';
end