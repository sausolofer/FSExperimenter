function [dataSetName,path] = getDataSetName_path(data)

[path,remain]=strtok(data,'\');
while true
    [str,remain]=strtok(remain,'\');
    if isempty(remain),  break; end
    path=strcat(path,'\',str);
end
path=strcat(path,'\');
dataSetName=str;

