function buildStratyfiedPartitionsOnDataSets(dataSetsPath,k)

path(path, dataSetsPath);
dataList = dir(dataSetsPath);

for i=1:length(dataList)
    if  ~dataList(i).isdir
        name = dataList(i).name;
        buildStratyfiedPartitions([dataSetsPath name],k);
    end
    
end
 
% getDataSetName_path(datasets{i})
