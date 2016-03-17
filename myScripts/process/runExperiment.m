function results = runExperiment(algorithm, originalInstances,missingInstancesSet, resultsPath,options)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Input
%      algorithm:
%       The code for the algorithm you wish to run
%       Possible Codes:
%			spectrum
%
%       dataset:
%        The code for the dataset you wish to run
%
%       plot:
%        boolean value denoting whether you wish to plot the ensuing
%        results
results=[];
results.dataSetName = char(originalInstances.relationName);
results.algorithm = algorithm;

for k=1: length(missingInstancesSet)
    %%
    missingInstances=missingInstancesSet{k};
    %missingInstances = geRandomMissingInstances(instances, resultsPath, options, k);
    disp([algorithm,'-',char(missingInstances.relationName),'-> k = ',num2str(k)]);
    %%values imputation based on the dataset and algorithm
    outputFile = imputeData(missingInstances, algorithm);
    out = getResults(outputFile,missingInstances,originalInstances);
    results.rmse(k) = out.rmse;
    results.accuracy(k) = out.accuracy;
    results.executionTime(k) = out.executionTime;
end

%%Save partial results
partialExperimentResultDir=[resultsPath,'Partials',filesep];
[status,message]= mkdir(partialExperimentResultDir);
if strcmp('Directory already exists.',message)
    disp(message);
end

save([partialExperimentResultDir,algorithm,'_over_',char(originalInstances.relationName)],'results');
