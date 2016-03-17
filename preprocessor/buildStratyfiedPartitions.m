function buildStratyfiedPartitions(dataset,k)
disp('building partitions');

load(dataset);

CVO = cvpartition(Y,'k',k);
ID = -ones(size(X,1),k);

for it = 1:CVO.NumTestSets
    trIdx = CVO.training(it);
    %teIdx = CVO.test(it);
    ID(trIdx,it) = 1;   
end

Partition = ID;

[name,path]=getDataSetName_path(dataset);

savedNameFile=[path,strtok(name,'.'),'_part.mat'];
save(savedNameFile,'Partition');

disp('Ok');