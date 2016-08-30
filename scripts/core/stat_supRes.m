function [ statRes ] = stat_supRes( fileDir )

load(fileDir{1}, 'eva');
load(fileDir{2}, 'RES');

for k=1:length(eva)
    [statRes.(['res_', eva{k}.shortName]), statRes.(['res_', eva{k}.codeName,'_std'])] = getRes(eva{k}.acc);
end

[statRes.res_time, statRes.res_time_std] = getResTocell(RES);

    function [cur_AC, cur_std] = getRes(curRES)
        
        cur_Acc = zeros(length(curRES),length(curRES{1}));
        
        for i = 1:length(curRES)
            cur_Acc(i,:) = curRES{i};
        end
        
        cur_AC = mean(cur_Acc,1);
        cur_std = std(cur_Acc);
        
    end

    function [cur_Time,cur_std]=getResTocell(curRES)
        cur_time = zeros(length(curRES),length(curRES{1}));
        for i = 1:length(curRES)
            cur_time(i,:) = curRES{i}.runtime;
        end
        
        cur_Time=mean(cur_time);
        cur_std=std(cur_time);
    end

end