function [ok] = runGlobalExperiment(experimentConf)
% Run the experiment with algorithms, datasets and configurations

%% configurations
dataSets = experimentConf.dataSetList;
fsAlgorithmsList = experimentConf.fsAlgorithms;
skipRunTimeErrors = experimentConf.skipRunTimeErrors;

%% Creating general results directories
[classificationResultDir,clusteringResultDir,experimentResultDir] = createExperimentDirectories(experimentConf);

%% Running algorithms over datasets

%some initializations
generalRes = cell(1,length(dataSets));
fidClassif = [];
fidClust = [];
disp('###################### STARTING EXPERIMENT #####################');
for i=1:length(dataSets) %First datasets
    disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    onlyName = createDatasetDirectories(dataSets{i}, experimentResultDir, classificationResultDir, clusteringResultDir, experimentConf);
    try
        typeOfExperiment = {'Classification','Clustering','OnlyFS'};
        dataSetRes.DataSetName = onlyName;
        dataSetRes.(typeOfExperiment{1}) = [];
        dataSetRes.(typeOfExperiment{2}) = [];
        dataSetRes.(typeOfExperiment{3}) = [];
        for j=1:length(fsAlgorithmsList) %Then Algorithms
            try
                fsAlg = fsAlgorithmsList{j};
                %We can evaluate the feature selection from two perspectives: classification performance and clustering performance
                if exist(classificationResultDir,'dir')
                    [performance, stats, fsRes, step] = runExperiment(fsAlg, dataSets{i}, classificationResultDir, typeOfExperiment{1}, [], experimentConf);
                    dataSetRes = fillDataSetResStruct(dataSetRes, fsAlg, performance, stats, fsRes, typeOfExperiment{1});
                end
                if exist(clusteringResultDir,'dir')
                    [performance,stats,fsRes, step] =  runExperiment(fsAlg, dataSets{i}, clusteringResultDir, typeOfExperiment{2}, [], experimentConf);
                    dataSetRes = fillDataSetResStruct(dataSetRes, fsAlg, performance, stats, fsRes, typeOfExperiment{2});
                end
                if ~exist(classificationResultDir,'dir') && ~exist(clusteringResultDir,'dir')
                    disp('No models for feature selection evaluation!!')
                    [performance,stats,fsRes, step] =  runExperiment(fsAlg, dataSets{i}, experimentResultDir, typeOfExperiment{3}, [], experimentConf);
                    dataSetRes = fillDataSetResStruct(dataSetRes, fsAlg, performance, stats, fsRes, typeOfExperiment{3});
                end
            catch ME
                ok='false';
                fclose('all');
                disp(ME.message);
                %sendMeMail(ME.message);
                ME.stack(1)
                if skipRunTimeErrors
                    continue;
                end
                return;
            end
        end
        if ~isempty(dataSetRes.OnlyFS)
            continue;
        end
        generalRes{i} = saveDataSetRes(dataSetRes, classificationResultDir, clusteringResultDir, step, experimentConf);
        fidClassif = writeGlobalRes2(fidClassif,generalRes{i}.(typeOfExperiment{1}),classificationResultDir,experimentConf.classificationEvaluationMeasures);
        fidClust = writeGlobalRes2(fidClust, generalRes{i}.(typeOfExperiment{2}), clusteringResultDir,experimentConf.clusteringEvaluationMeasures);
        save(strcat(experimentResultDir,'GeneralRes', '.mat'),'generalRes');
    catch ME
        ok='false';
        fclose('all');
        disp(ME.message);
        ME.stack(1)     
        if skipRunTimeErrors
            continue;
        end
        return;
    end
end

fclose('all');
ok='true';

    function dataStruct = fillDataSetResStruct(dataStruct,fsAlg, performance, stats, fsRes, typeOfExperimentCode)
        dataStruct.(typeOfExperimentCode).(fsAlg.codeName).fullName = fsAlg.fullName;
        dataStruct.(typeOfExperimentCode).(fsAlg.codeName).codeName = fsAlg.codeName;
        dataStruct.(typeOfExperimentCode).(fsAlg.codeName).plottingName = fsAlg.plottingName;
        dataStruct.(typeOfExperimentCode).(fsAlg.codeName).Performance = performance;
        dataStruct.(typeOfExperimentCode).(fsAlg.codeName).stats = stats;
        dataStruct.(typeOfExperimentCode).(fsAlg.codeName).fsRes = fsRes;
    end
end