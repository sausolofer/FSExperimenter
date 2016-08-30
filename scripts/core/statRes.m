function [ statRes ] = statRes(fileDir, typeOfExperiment)

load(fileDir{1}, 'eva');
load(fileDir{2}, 'RES');
statRes = cell(length(eva),1);
if strcmp( typeOfExperiment,'Classification')
    for k=1:length(eva)
        statRes{k}.fullName =  eva{k}.fullName;
        statRes{k}.codeName = eva{k}.codeName;
        statRes{k}.plottingName = eva{k}.plottingName;
        
        [statRes{k}.ACC, statRes{k}.ACC_std] = getRes(eva{k}.acc);
        [statRes{k}.ClassificationError, statRes{k}.ClassificationError_std] = getRes(eva{k}.classificationError);
        [statRes{k}.RunTime, statRes{k}.RunTime_std] = getRes(eva{k}.runTime);
        
        [statRes{k}.AverageACC, statRes{k}.AverageACC_std] = getAverage(statRes{k}.ACC, statRes{k}.ACC_std);
        [statRes{k}.AverageClassificationError, statRes{k}.AverageClassificationError_std] = getAverage(statRes{k}.ClassificationError, statRes{k}.ClassificationError_std);
        [statRes{k}.AverageRunTime,statRes{k}.AverageRunTime_std] = getAverage(statRes{k}.RunTime, statRes{k}.RunTime_std);
    end
else
    for k=1:length(eva)
        statRes{k}.fullName =  eva{k}.fullName;
        statRes{k}.codeName = eva{k}.codeName;
        statRes{k}.plottingName = eva{k}.plottingName;
        
        [statRes{k}.ACC, statRes{k}.ACC_std] = getRes(eva{k}.acc);
        [statRes{k}.Nmi, statRes{k}.Nmi_std] = getRes(eva{k}.nmi);
        [statRes{k}.Jaccard, statRes{k}.Jaccard_std] = getRes(eva{k}.jaccard);
        [statRes{k}.Silhouette, statRes{k}.Silhouette_std] = getRes(eva{k}.silhouette);
        [statRes{k}.RunTime, statRes{k}.RunTime_std] = getRes(eva{k}.runTime);
        
        [statRes{k}.AverageACC,statRes{k}.AverageACC_std] = getAverage(statRes{k}.ACC, statRes{k}.ACC_std);
        [statRes{k}.AverageNmi,statRes{k}.AverageNmi_std] = getAverage(statRes{k}.Nmi, statRes{k}.Nmi_std);
        [statRes{k}.AverageJaccard,statRes{k}.AverageJaccard_std] = getAverage(statRes{k}.Jaccard, statRes{k}.Jaccard_std);
        [statRes{k}.AverageSilhouette,statRes{k}.AverageSilhouette_std] = getAverage(statRes{k}.Silhouette, statRes{k}.Silhouette_std);
        [statRes{k}.AverageRunTime,statRes{k}.AverageRunTime_std] = getAverage(statRes{k}.RunTime, statRes{k}.RunTime_std);
    end
    
end

    function [cur_AC, cur_std] = getRes(curRES)
        
        cur_Acc = zeros(length(curRES),length(curRES{1}));
        for i = 1:length(curRES)
            cur_Acc(i,:) = curRES{i};
        end
        cur_AC = mean(cur_Acc,1);
        
        if size(cur_Acc,1) == 1
            cur_std = zeros(1,length(cur_Acc));
        else
            cur_std = std(cur_Acc);
        end
    end

    function [best,best_std]= getAverage(vec,vec_std)
        %[~,index] = max(vec(1:length(vec-1)));
        best= mean(vec);
        best_std = mean(vec_std);
    end

end