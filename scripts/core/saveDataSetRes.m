function resStruct = saveDataSetRes(dataSetRes, classificationResultDir, clusteringResultDir, step, experimentConf)

resStruct.Classification = [];
resStruct.Clustering = [];
plotAverage = experimentConf.plotAverage;

if ~isempty(classificationResultDir)
    typeOfExperiment = 'Classification';
    classifEvalMeasures = experimentConf.classificationEvaluationMeasures;
    %step = experimentConf.classificationEvaluationStep;
    dataSetName = dataSetRes.DataSetName;
    data.fsEval = dataSetRes.Classification;
    data.DataSetName = dataSetName;
    
    save(strcat(classificationResultDir,dataSetName,filesep,dataSetName,'_','fsEvaluation', '.mat'),'data');
    resStruct.Classification = plotAndGetResByLearningAlg(data,classificationResultDir,typeOfExperiment,step,classifEvalMeasures);
    
    resStruct.Classification.AveFsRunTime = getAveRuntimeBySelector(data) ;
    save(strcat(classificationResultDir,dataSetName,filesep,dataSetName,'_','lAEvaluation', '.mat'),'resStruct');
end

if ~isempty(clusteringResultDir)
    typeOfExperiment = 'Clustering';
    clusteringEvalMeasures = experimentConf.clusteringEvaluationMeasures;
    %step = experimentConf.clusteringEvaluationStep;
    dataSetName = dataSetRes.DataSetName;
    data.fsEval = dataSetRes.Clustering;
    data.DataSetName = dataSetName;
    
    save(strcat(clusteringResultDir,dataSetName,filesep,dataSetName,'_','fsEvaluation', '.mat'),'data');
    resStruct.Clustering = plotAndGetResByLearningAlg(data,clusteringResultDir,typeOfExperiment,step,clusteringEvalMeasures);
    resStruct.Clustering.AveFsRunTime = getAveRuntimeBySelector(data);
    save(strcat(clusteringResultDir,dataSetName,filesep,dataSetName,'_','lAEvaluation', '.mat'),'resStruct');
end

    function [res,ClassifName] = getResByLearningAlg(dataSet,index,field)
        fn = fieldnames(dataSet.fsEval);
        ClassifName = dataSet.fsEval.(fn{1}).stats{index}.codeName;
        for n = 1:length(fn)
            %resInt = dataSet.fsEval.(fn{n}).stats{index};
            resInt = dataSet.fsEval.(fn{n});
            %res{n}.name = fn{n};
            res{n}.fullName = resInt.fullName;
            res{n}.codeName = resInt.codeName;
            res{n}.plottingName = resInt.plottingName;
            res{n}.(field) = resInt.stats{index}.(field);
            res{n}.([field,'_std']) = resInt.stats{index}.([field,'_std']);
        end
    end

    function learningAlgResStruct = plotAndGetResByLearningAlg(dataSet,dir,typeOfExperiment, step, evalMeasures)
        learningAlgResStruct=[];
        learningAlgResStruct.DataSetName = dataSet.DataSetName;
        fn = fieldnames(dataSet.fsEval);
        numClasif = length(dataSet.fsEval.(fn{1}).stats);
        pathForPlotting = [strcat(dir,dataSetName,filesep), 'Plots', filesep];
        for i=1:numClasif
            for j=1:length(evalMeasures)
                field = evalMeasures{j};
                [algStruct.(field),algStruct.classifName] = getResByLearningAlg(dataSet,i,field);
                %fileName = [strcat(dir,dataSetName,filesep), 'Plots', filesep, dataSet.DataSetName, '_' algStruct.classifName,'_', field, '_(rankingEval)'];
                
                nameForPlotting = [ dataSet.DataSetName, '_' algStruct.classifName,'_', field, '_(rankingEval)'];
                writeRes(algStruct.(field), dataSet.DataSetName, algStruct.classifName, [], step, field, pathForPlotting, nameForPlotting, typeOfExperiment);
                
                if plotAverage
                    newField = ['Average',field];
                    nameForPlotting = [ dataSet.DataSetName, '_' algStruct.classifName,'_', field, '_(averageEval)'];
                    [algStruct.(newField),~] = getResByLearningAlg(dataSet,i,newField);
                    %fileName = [strcat(dir,dataSetName,filesep), 'Plots', filesep, dataSet.DataSetName, '_' algStruct.classifName, '_', newField, '_(averageEval)'];
                    writeRes(algStruct.(newField), dataSet.DataSetName, algStruct.classifName, [], step, newField,  pathForPlotting, nameForPlotting, typeOfExperiment);
                end
                
            end
            
            %[algStruct.rankingEvalRes,~] = getResByLearningAlg(dataSet,i,'ACC');
            %[algStruct.bestSubsetEvalRes,algStruct.classifName] = getResByLearningAlg(dataSet,i,'BestACC');
            %fileName1 = [strcat(dir,dataSetName,filesep) 'Plots' filesep dataSet.DataSetName  '_' algStruct.classifName,'_(rankingEval)'];
            %writeRes(algStruct.rankingEvalRes, dataSet.DataSetName, algStruct.classifName, [], step,'ACC',fileName1,typeOfExperiment);
            
            %fileName2 = [strcat(dir,dataSetName,filesep) 'Plots' filesep dataSet.DataSetName  '_' algStruct.classifName,'_(subsetEval)'];
            %writeRes(algStruct.bestSubsetEvalRes, dataSet.DataSetName, algStruct.classifName, [], step,'BestACC',fileName2,typeOfExperiment);
            resSt{i} = algStruct;
        end
        learningAlgResStruct.resultEvaluation=resSt;
    end

    function runTime = fsRunTime(fsResRunTime)
        for k=1:length(fsResRunTime)
            runT(k) = fsResRunTime{k}.runtime;
        end
        runTime=mean(runT);
    end

    function rt = getAveRuntimeBySelector(dataSet)
        fn = fieldnames(dataSet.fsEval);
        for l=1:length(fn)
            %fsAlgTime.codeName = fn{l};
            fsAlgTime{l}.fullName = dataSet.fsEval.(fn{l}).fullName;
            fsAlgTime{l}.codeName = dataSet.fsEval.(fn{l}).codeName;
            fsAlgTime{l}.plottingName = dataSet.fsEval.(fn{l}).plottingName;
            
            fsAlgTime{l}.fsAveTime = fsRunTime(dataSet.fsEval.(fn{l}).fsRes);
            
        end
        resFsTime.fsAveTime=fsAlgTime;
        rt = cell(1,1);
        rt{1,1} = resFsTime;
    end

end