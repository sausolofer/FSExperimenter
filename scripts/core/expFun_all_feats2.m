function [eva] = expFun_all_feats2(RES, partitionsPath, classifiersList)

iter = length(RES);
classifierACC = cell(iter,length(classifiersList));
classifierRuntime = cell(iter,length(classifiersList));

for it = 1:iter
    disp('------------------------------------');
    fprintf('              %i iteration\n',it);
    disp('------------------------------------');
    
    curTraining = [partitionsPath,fileName,'_Training',num2str(it),'.arff'];
    curTest = [partitionsPath,fileName,'_Test',num2str(it),'.arff'];
    TrainingInstances= loadARFF(curTraining);
    TestInstances= loadARFF(curTest);
    
    fprintf('--------------------\n');
    fprintf('Iteration, %3i\n',it);
    featIDX = RES{it}.fList;
    
    for i = 1:length(classifiersList)
        
        [classifierACC{it,i},classifierRuntime{it,i}] = evalWekaClassifier(classifiersList{i}.model, TrainingInstances, TestInstances, featIDX, numF,accRankingEvaluationStep);
        % redRes{it} = evalFSRedncy( X, featIDX, numF);
    end
    
end

end