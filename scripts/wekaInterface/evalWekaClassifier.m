function [res] = evalWekaClassifier(classifier, trainingInstances, testInstances, featIDX, numF, step, subsetEval)
%test the accuracy of the selected features
%   Weka classifier to use
%   trainingInstances - Intances for training
%   testInstances - Instances for test
%   featIDX - feature index from important to unimportant
%   numF - the vector contains the different number of features we want to test
%===================

if subsetEval
    numF= sum(featIDX>0);
else
    numF= step:step:numF;
end

AC = zeros(length(numF),1);
classificationError = zeros(length(numF),1);
confusionMatrix = cell(1,length(numF));
runtime = zeros(length(numF),1);
oversel = 0; cal = 0;

for i=1:length(numF)
    l = numF(i);
    reducedTrainingInstances = getDataSet(trainingInstances, featIDX(1:l));
    reducedTestInstances = getDataSet(testInstances, featIDX(1:l));
    
    start = clock();
    % Train the dataset.
    classifier.buildClassifier(reducedTrainingInstances)
    
    %% Clssification evaluation
    ev = javaObject('weka.classifiers.Evaluation',reducedTrainingInstances);
    plainText = javaObject('weka.classifiers.evaluation.output.prediction.PlainText');%To print
    buffer = javaObject('java.lang.StringBuffer');
    plainText.setBuffer(buffer);
    plainText.setHeader(reducedTrainingInstances);
    array = javaArray('java.lang.Object',1);
    array(1) = plainText;
    
    ev.evaluateModel(classifier,reducedTestInstances,array);%evaluate classifier
    
    % Calculate the Classification Accuracy
    AC(i) = ev.pctCorrect/100;
    classificationError(i) = ev.pctIncorrect/100;
    confusionMatrix{i} = ev.toMatrixString;
    
    finalTime = clock() - start;
    runtime(i) = clock2secs(finalTime);
    fprintf('total features: %5i,   select features: %5i,   %s acc value: %.3f\n', reducedTrainingInstances.numAttributes, l, char(classifier.getClass().getSimpleName()), AC(i));

    if oversel && ~cal
        cal = 1;
    end
end

res.acc = AC;
res.classificationError = classificationError;
res.confusionMatrix = confusionMatrix;
res.runtime = runtime;

end