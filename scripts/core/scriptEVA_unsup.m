function [eva,newStep] = scriptEVA_unsup(fileName, algorithmName, clusteringAlgList,  numOfFeaturesForEvaluationClust, clusteringEvaluationStep, resultsPath, numberOfClusteringRuns)

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

iter = length(RES);
clusteringACC = cell(iter,length(clusteringAlgList));
clusteringNMI = cell(iter,length(clusteringAlgList));
clusteringJaccard = cell(iter,length(clusteringAlgList));
clusteringSilhouette = cell(iter,length(clusteringAlgList));
clusteringRuntime = cell(iter,length(clusteringAlgList));

clusteringAssigments = cell(iter,length(clusteringAlgList));

for it = 1:iter
    curTraining = [partitionsPath,fileName,'_Training',num2str(it),'.arff'];
    TrainingInstances= loadARFF(curTraining);
    
    fprintf('--------------------\n');
    fprintf('Iteration, %3i\n',it);
    featIDX = RES{it}.fList;  
    numOfFea = sum(featIDX>0);
    if numOfFeaturesForEvaluationClust > 0 && numOfFeaturesForEvaluationClust < 1
        newNumOfFeaturesForEvaluationClust = round(numOfFeaturesForEvaluationClust * numOfFea);
    else
        if  numOfFeaturesForEvaluationClust > numOfFea
            newNumOfFeaturesForEvaluationClust = numOfFea;
        else
            newNumOfFeaturesForEvaluationClust = numOfFeaturesForEvaluationClust;
        end
    end
    
    if clusteringEvaluationStep < 1 && clusteringEvaluationStep > 0
        newStep = round(newNumOfFeaturesForEvaluationClust * clusteringEvaluationStep);
    else
        newStep = clusteringEvaluationStep;
    end
    
    for i = 1:length(clusteringAlgList)
        evalRes = evalWekaClusteringAlg(clusteringAlgList{i}.model, TrainingInstances, featIDX, newNumOfFeaturesForEvaluationClust, newStep, subsetEval, numberOfClusteringRuns);
        clusteringACC{it,i}=evalRes.acc;
        clusteringNMI{it,i}=evalRes.nmi;
        clusteringJaccard{it,i}=evalRes.jaccard;
        clusteringSilhouette{it,i}=evalRes.silhouette;
        clusteringRuntime{it,i}=evalRes.clusteringRuntime;
        clusteringAssigments{it,i}=evalRes.clusteringAssigments;
    end    
end

eva = cell(size(clusteringACC,2));
for j=1:size(clusteringACC,2)
    eva{j}.fullName = clusteringAlgList{j}.fullName;
    eva{j}.codeName = clusteringAlgList{j}.codeName;
    eva{j}.plottingName = clusteringAlgList{j}.plottingName;
    eva{j}.model = clusteringAlgList{j}.model;
    
    eva{j}.acc = clusteringACC(:,j);
    eva{j}.nmi = clusteringNMI(:,j);
    eva{j}.jaccard = clusteringJaccard(:,j);
    eva{j}.silhouette = clusteringSilhouette(:,j);
    eva{j}.runTime = clusteringRuntime(:,j);
    eva{j}.clusteringAssigments = clusteringAssigments(:,j);
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