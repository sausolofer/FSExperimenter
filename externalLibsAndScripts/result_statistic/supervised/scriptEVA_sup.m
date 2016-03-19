function scriptEVA_sup(fileName, algorithmName, numOfFeaturesACCrankingEvaluation, resultsPath, datasetsPath)

fileDir = cell(3,1);

% if length(varargin) < 1
%     dataPath = ['..' filesep '..' filesep '..'  filesep 'data' filesep];
% end

fileDir{1} = strcat(resultsPath, fileName,'_',algorithmName,'_fs','_result.mat');
fileDir{2} = strcat(datasetsPath, fileName,'.mat');
fileDir{3} = strcat(datasetsPath, fileName,'_part.mat');

try
    eva = expFun_eva_sup(fileDir, fileName,numOfFeaturesACCrankingEvaluation);
    save(strcat(resultsPath, fileName,'_',algorithmName,'_acc_result', '.mat'),'eva')
catch ME
    fprintf('there is an error caught for %s data\n',fileName);
    disp(ME.message);
    ME.stack(1)
end
end