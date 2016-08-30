function [eva, stats, classificationEvaluationStep, clusteringEvaluationStep] = runEvaluations(outputFile, fsAlgorithm, experimentConf, resultsPath, typeOfExperiment)
%% This will run classification and/or clustering algorithms and basic statistical evaluations on the selected features over the same partitions
%   Input
%   outputFile, the file containing the data. Must be wrapped in a cell.
%   algorithm: the algorithm code that the data was run on
stats = [];
classificationEvaluationStep = [];
clusteringEvaluationStep = [];
if strcmp(typeOfExperiment,'Classification')
    %disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    numOfFeaturesForEvaluationClassif = experimentConf.numOfFeaturesForEvaluationClassif;
    classificationEvaluationStep = experimentConf.classificationEvaluationStep;
    classifiers = experimentConf.classifiers;
    fprintf('Performing classification\n');
    [eva,classificationEvaluationStep] = scriptEVA_sup(outputFile, fsAlgorithm, classifiers,...
        numOfFeaturesForEvaluationClassif, classificationEvaluationStep, resultsPath);
    
    if ~isempty(eva)
        stats = scriptStat(outputFile, fsAlgorithm, resultsPath,'Classification');
    end
    
else %Clustering
    %disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    numOfFeaturesForEvaluationClust = experimentConf.numOfFeaturesForEvaluationClust;
    clusteringEvaluationStep = experimentConf.clusteringEvaluationStep;
    clusteringAlgorithms = experimentConf.clusteringAlgorithms;
    numberOfClusteringRuns = experimentConf.numberOfClusteringRuns;
    fprintf('Performing clustering\n');
    [eva,clusteringEvaluationStep] = scriptEVA_unsup(outputFile, fsAlgorithm, clusteringAlgorithms,...
        numOfFeaturesForEvaluationClust, clusteringEvaluationStep, resultsPath, numberOfClusteringRuns);
    
    if ~isempty(eva)
        stats = scriptStat(outputFile, fsAlgorithm, resultsPath,'Clustering');
    end
    
end



end