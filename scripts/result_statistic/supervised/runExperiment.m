function result = runExperiment(algorithm, dataSet, resultsPath, dataSetsPath, numOfFeaturesACCrankingEvaluation, plot)

if nargin < 3
    plot = false;
end

%% Select the features based on the dataset and algorithm
% outputFile = selectFeatures(dataSet, algorithm, resultsPath);
% 
% %% Calculate evaluations and the statistics
% result = runEvaluations(outputFile, algorithm, numOfFeaturesACCrankingEvaluation, resultsPath, dataSetsPath);
% 
% %% Call the plot of the data
% if(plot)  
%     writeXLS2(result, outputFile, algorithm, resultsPath, outputFile);
% end

end