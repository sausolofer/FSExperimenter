function evaluationResults = runEvaluations(inputFile,resultsPath)

for i=1:length(inputFile)
    element = inputFile{i};
    
    evaluationResults{i}.dataSetName=element.dataSetName; 
    evaluationResults{i}.algorithm=element.algorithm;
    
    evaluationResults{i}.rmseAve=mean(element.rmse);
    evaluationResults{i}.rmseStd=std(element.rmse);
    
    evaluationResults{i}.accuracyAve=mean(element.accuracy);
    evaluationResults{i}.accuracyStd=std(element.accuracy);
    
    evaluationResults{i}.executionTimeAve=mean(element.executionTime);
    evaluationResults{i}.executionTimeStd=std(element.executionTime);
end

end