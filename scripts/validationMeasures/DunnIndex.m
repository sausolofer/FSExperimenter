function [dunnIndex] = DunnIndex(datos,ids,k)
% dunn's index 

distM=squareform(pdist(datos));
dunnIndex = dunns(k,distM,ids);
disp(sprintf('Dunns index for the clustering algorithm %d', dunnIndex));




