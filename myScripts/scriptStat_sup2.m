function res = scriptStat_sup2(fileName, algorithm, filePath)

fileDir = cell(1,1);

for i = 1: length(fileName)
   %fileDir{1} = strcat(filePath, fileName{i},'_acc_result.mat');
   %fileDir{1} = strcat(fileName{i},'_acc_result.mat');
   fileDir{1}=char(strcat(filePath,getDataSetName_path(fileName{i}),'_',algorithm,'_acc_result.mat'));
   fileDir{2}=char(strcat(filePath,getDataSetName_path(fileName{i}),'_',algorithm,'_fs_result.mat'));

   %try
        res = stat_supRes2(fileDir);
        
       % save(strcat(fileName{i},'_', algorithm, '_stat_result', '.mat'),'res');
        save(char(strcat(filePath,getDataSetName_path(fileName{i}),'_', algorithm, '_stat_result', '.mat')),'res');

 %  catch ME
  %     fprintf('An error was caught for %s data\n',fileName{i});
  %     disp(ME.message);
  %     ME.stack(1)
  % end
end

end