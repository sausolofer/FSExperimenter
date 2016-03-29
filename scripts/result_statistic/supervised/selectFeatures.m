function [dataSetName] = selectFeatures(dataSet, algorithmCode, resultsPath)

%% This are the two files for the dataset we wish to evaluate
dataSet = char(dataSet)
load(dataSet);
fileDir = cell(2,1);
fileDir{1} = dataSet;
[dataSetName,path] = getDataSetName_path(dataSet);
dataSetName = strtok(dataSetName,'.');
fileDir{2} = strcat([path,dataSetName],'_part.mat');

%try
%% Calculate the feature selection on the dataset
RES = expFun_wi_sam_feat(fileDir, dataSetName, algorithmCode);

%% Save the results to a file (make sure it is algorithmCode-specific)
file = strcat(resultsPath,dataSetName ,'_',algorithmCode,'_fs','_result', '.mat');
save(file, 'RES');
% catch ME
%     fprintf('An error was caught for %s data\n',fileName{i});
%     disp(ME.message);
%     ME.stack(1)
% end

end