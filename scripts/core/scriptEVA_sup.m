function [eva,newStep] = scriptEVA_sup(fileName, algorithmName, classifiersList, numOfFeaturesForEvaluationClassif,classificationEvaluationStep, resultsPath)

partitionsPath = [resultsPath,'DataPartitions',filesep];
featureSelectionResults = strcat(resultsPath,'FeatureSelection',filesep, fileName,'_',algorithmName,'_fs','_result.mat');

disp('%%%%%%%%%%%%%%%%%%%%%%%%');
disp(fileName);
disp('%%%%%%%%%%%%%%%%%%%%%%%%');

RES = [];
load(featureSelectionResults, 'RES');

%If it's feature-oriented
if(RES{1}.fImp)
    subsetEval = true;
else
    subsetEval = false;
end
eva = cell(1,length(classifiersList));
iter = length(RES);
classifierACC = cell(iter,length(classifiersList));
classifierRuntime = cell(iter,length(classifiersList));
classificationError = cell(iter,length(classifiersList));
confusionMatrix = cell(iter,length(classifiersList));

for it = 1:iter
    curTraining = [partitionsPath,fileName,'_Training',num2str(it),'.arff'];
    curTest = [partitionsPath,fileName,'_Test',num2str(it),'.arff'];
    TrainingInstances = loadARFF(curTraining);
    TestInstances = loadARFF(curTest);    
    fprintf('--------------------\n');
    fprintf('Iteration, %3i\n',it);
    featIDX = RES{it}.fList;    
    numOfFea = sum(featIDX>0);
    
    if numOfFeaturesForEvaluationClassif > 0 && numOfFeaturesForEvaluationClassif < 1
        newNumOfFeaturesForEvaluationClassif = round(numOfFeaturesForEvaluationClassif * numOfFea);
    else
        if  numOfFeaturesForEvaluationClassif > numOfFea
            newNumOfFeaturesForEvaluationClassif = numOfFea;
        else
            newNumOfFeaturesForEvaluationClassif = numOfFeaturesForEvaluationClassif;
        end
    end
    
    if classificationEvaluationStep < 1 && classificationEvaluationStep > 0
        newStep = round(newNumOfFeaturesForEvaluationClassif * classificationEvaluationStep);
    else
        newStep = classificationEvaluationStep;
    end
    
    for i = 1:length(classifiersList)
        evalRes = evalWekaClassifier(classifiersList{i}.model, TrainingInstances, TestInstances, featIDX, newNumOfFeaturesForEvaluationClassif, newStep, subsetEval);
        classifierACC{it,i} = evalRes.acc;
        classificationError{it,i} = evalRes.classificationError;
        confusionMatrix{it,i} = evalRes.confusionMatrix;    
        classifierRuntime{it,i} = evalRes.runtime;
    end
end

for j=1:length(classifiersList)%size(classifierACC,2)
    eva{j}.fullName = classifiersList{j}.fullName;
    eva{j}.codeName = classifiersList{j}.codeName;
    eva{j}.plottingName = classifiersList{j}.plottingName;
    eva{j}.model =  classifiersList{j}.model;
    
    eva{j}.acc = classifierACC(:,j);
    eva{j}.classificationError = classificationError(:,j);
    eva{j}.confusionMatrix = confusionMatrix(:,j);
    eva{j}.runTime = classifierRuntime(:,j);
end

try
    save(strcat(resultsPath,'PerformanceEval',filesep, fileName,'_',algorithmName,'_result', '.mat'),'eva');
catch ME
    fprintf('there is an error caught for %s data\n',fileName);
    disp(ME.message);
    ME.stack(1)
    eva=[];
end

end