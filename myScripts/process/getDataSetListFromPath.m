function [dataSetList]= getDataSetListFromPath(dataSetsPath)

path(path, dataSetsPath);
dataList = dir(dataSetsPath);
cont=0;
for i=1:length(dataList)
    if  ~dataList(i).isdir
        name = dataList(i).name;
        dataSetList{i-cont}=[dataSetsPath name];
    else
        cont=cont+1;
    end    
end