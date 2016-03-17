function scriptEVA_sup(fileName, algorithmName,numOfFeaturesACCrankingEvaluation, dataPath)

fileDir = cell(3,1);

% if length(varargin) < 1
%     dataPath = ['..' filesep '..' filesep '..'  filesep 'data' filesep];
% end

for i = 1: length(fileName)
   fileDir{1} = strcat(dataPath,getDataSetName_path(fileName{i}),'_',algorithmName,'_fs','_result.mat');
   fileDir{2} = {strcat(fileName{i},'.mat')};
   fileDir{3} = {strcat(fileName{i},'_part.mat')};
   
   %fileDir{1} = strcat(fileName{i},'_',algorithmName,'_result.mat');
   %fileDir{2} = strcat(fileName{i},'.mat');
   %fileDir{3} = strcat(fileName{i},'_part.mat');
    try
        eva = expFun_eva_sup(fileDir, fileName{i},numOfFeaturesACCrankingEvaluation);
        %save(strcat(fileName{i}{1},'_acc_result', '.mat'),'eva');
        save(strcat(dataPath,getDataSetName_path(fileName{i}),'_',char(algorithmName),'_acc_result', '.mat'),'eva')
    catch ME
        fprintf('there is an error caught for %s data\n',fileName{i});
        disp(ME.message);
        ME.stack(1)
    end
end

end