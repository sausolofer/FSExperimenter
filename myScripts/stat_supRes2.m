function [ statRes ] = stat_supRes2( fileDir )

load(fileDir{1}, 'eva');
load(fileDir{2}, 'RES');

%This is a test to see which one it is (feature based or iterative).
% Test to see if 'svm' exists, which means it's iterative. Otherwise,
% skip this step.
if(isfield(eva,'svm'))
    [statRes.res_svm, statRes.res_svm_std] = getRes(eva.svm);
    [statRes.res_bayes, statRes.res_bayes_std] = getRes(eva.bayes);
    [statRes.res_j48, statRes.res_j48_std] = getRes(eva.j48);
    [statRes.res_red, statRes.res_red_std]= getRes(eva.red);
    
    [statRes.res_time, statRes.res_time_std] = getResTocell(RES);
    
else
    statRes = eva;
end
    
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