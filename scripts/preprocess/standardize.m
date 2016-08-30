function newData= standardize(instances)
% Standardizes a dataset
% Written by Saul Solorio

import weka.filters.*

filter = javaObject('weka.filters.unsupervised.attribute.Standardize');
filter.setInputFormat(instances);
newData = Filter.useFilter(instances, filter);