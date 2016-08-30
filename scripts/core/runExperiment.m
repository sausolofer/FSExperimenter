function [result, stats, FsRes, rankingEvaluationStep] = runExperiment(fsAlgorithm, datasetPath, resultsPath, typeOfExperiment, resBuf, experimentConf)
% Run the feature selection, evaluations and plots
%--------------------------------------------------------------------------
dataSetName = strtok(getDataSetName_path(datasetPath),'.');
resultsPath = [resultsPath, dataSetName, filesep];
fsAlgName = fsAlgorithm.codeName;
fsAlgPlottingName = fsAlgorithm.plottingName;

%% Selecting features based on the specified dataset, FS algorithm and type of experiment
if strcmp(typeOfExperiment,'Classification')
    %disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    numberOfFoldsForClassification = experimentConf.numberOfFoldsForClassification;
    fprintf('Selecting features using %s-partitions (Classification performance)\n', num2str(numberOfFoldsForClassification));
    [outputFile,FsRes] = selectFeatures(dataSetName, fsAlgorithm, resultsPath, numberOfFoldsForClassification);
elseif strcmp(typeOfExperiment, 'Clustering')
    %disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    numberOfFoldsForClustering = experimentConf.numberOfFoldsForClustering;
    fprintf('Selecting features using %s-partitions (Clustering performance)\n', num2str(numberOfFoldsForClustering));
    [outputFile,FsRes] = selectFeatures(dataSetName, fsAlgorithm, resultsPath, numberOfFoldsForClustering);
else
    numberOfFoldsForClustering = experimentConf.numberOfFoldsForClustering;
    fprintf('Feature selection only using %s-partitions \n', num2str(numberOfFoldsForClustering));
    [~,FsRes] = selectFeatures(dataSetName, fsAlgorithm, resultsPath, numberOfFoldsForClustering);
    result = [];
    stats =[];
    rankingEvaluationStep = [];
    return;
end

%% % Calculate evaluations and basic statistics
[result,stats,classificationEvaluationStep, clusteringEvaluationStep] = runEvaluations(outputFile, fsAlgName, experimentConf, resultsPath, typeOfExperiment);

%% Write results in file
%pathAndNameForPlotting = [resultsPath, 'Plots', filesep, dataSetName, '_', fsAlgName];
pathForPlotting = [resultsPath, 'Plots', filesep];
nameForPlotting = [dataSetName, '_', fsAlgName];

if ~isempty(classificationEvaluationStep)
    rankingEvaluationStep = classificationEvaluationStep;
    classifEvalMeasures = experimentConf.classificationEvaluationMeasures;
    for i = 1:length(classifEvalMeasures)
        writeRes(stats, dataSetName, fsAlgPlottingName, resBuf, rankingEvaluationStep, classifEvalMeasures{i}, pathForPlotting, nameForPlotting, typeOfExperiment);
    end
else
    rankingEvaluationStep = clusteringEvaluationStep;
    clusteringEvalMeasures = experimentConf.clusteringEvaluationMeasures;
    for i = 1: length(clusteringEvalMeasures)
        writeRes(stats, dataSetName, fsAlgPlottingName, resBuf, rankingEvaluationStep, clusteringEvalMeasures{i}, pathForPlotting, nameForPlotting, typeOfExperiment);
    end
end

end