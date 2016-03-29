function result = runEvaluations(outputFile, algorithm, numOfFeaturesACCrankingEvaluation, resultsPath, dataSetsPath)
%% This will run statistical evaluations on the selected features
% Input
%   outputFile, the file containing the data. Must be wrapped in a cell.
%   algorithm: the algorithm code that the data was run on

scriptEVA_sup(outputFile, algorithm, numOfFeaturesACCrankingEvaluation, resultsPath, dataSetsPath);
%result = scriptStat_sup(outputFile, algorithm, ['..' filesep '..' filesep '..' filesep 'data' filesep]);
%result = scriptStat_sup(outputFile, algorithm, resultsPath);
result = scriptStat_sup2(outputFile, algorithm, resultsPath);
end