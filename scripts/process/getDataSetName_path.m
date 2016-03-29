function [dataSetName,path] = getDataSetName_path(data)

[path,remain]=strtok(data,filesep);
while true
    [str,remain]=strtok(remain,filesep);
    if isempty(remain),  break; end
    path=strcat(path,filesep,str);
end
path=strcat(path,filesep);
dataSetName=str;

