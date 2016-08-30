function res = scriptStat(fileName, algorithm, filePath, typeOfExperiment)

fileDir = cell(1,1);

fileDir{1}=char(strcat(filePath,'PerformanceEval',filesep, fileName,'_',algorithm,'_result.mat'));
fileDir{2}=char(strcat(filePath,'FeatureSelection',filesep, fileName,'_',algorithm,'_fs_result.mat'));

res = statRes(fileDir, typeOfExperiment);

try
    save(char(strcat(filePath, 'Statistics',filesep, fileName,'_', algorithm, '_stat_result', '.mat')),'res');    
catch ME
    fprintf('An error was caught for data');
    disp(ME.message);
    ME.stack(1)
end

end