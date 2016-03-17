function buildPartitions(dataset, per, iter)
disp('building partitions');
load(dataset);
Partition = buildIDX(X, Y, per, iter);
savedNameFile=[dataset,'_part.mat'];
save(savedNameFile,'Partition');
disp('Ok');