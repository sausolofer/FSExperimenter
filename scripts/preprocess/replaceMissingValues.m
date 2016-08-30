function newData= replaceMissingValues(instances)
% Replace missing values of dataset
% Written by Saul Solorio

import weka.filters.*

filter = javaObject('weka.filters.unsupervised.attribute.ReplaceMissingValues');
filter.setInputFormat(instances);
newData = Filter.useFilter(instances, filter);
end
