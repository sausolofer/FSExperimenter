function [ok]=runExperimentOnDatasets(algorithms,dataSets,experimentName,resultsPath,options)

experimentResultDir=[resultsPath,experimentName,'_RES',filesep];
[status,message]= mkdir(experimentResultDir);
if strcmp('Directory already exists.',message)
    disp(message);
end

totalExperimentResult=[];
for i=1:length(dataSets) %Datasets
    %loading dataset
    instances = loadARFF(char(dataSets(i)));
    % %Standardizes data(optional)
    %instances = standardize(instances);
    %%
    %datasetResultDir=[experimentResultDir,getDataSetName_path(dataSets{i}),filesep];
    datasetResultDir= [experimentResultDir,char(instances.relationName),filesep];
    [status,message]= mkdir(datasetResultDir);
    if strcmp('Directory already exists.',message)
        disp(message);
    end
    
    %% make k random missing values for dataset
    rng(options.seed); %seed
    for k=1: options.k
            missingInstances{k} = geRandomMissingInstances(instances, datasetResultDir, options, k);
    end
    
    res=[];
    for j=1:length(algorithms)%Algorithms
        algorithm=algorithms{j};
        res{j} = runExperiment(algorithm,instances,missingInstances,datasetResultDir,options);
    end
    save([datasetResultDir,char(instances.relationName),'_results'],'res');
    %% Calculate evaluations and the statistics
    result = runEvaluations(res, datasetResultDir);
    
    %% Write results
    saveAndPlotResults(result,datasetResultDir,options.missingPct)
    %%
    totalExperimentResult{i}=res;
end
save([experimentResultDir,experimentName,'_global_results'],'totalExperimentResult');
end