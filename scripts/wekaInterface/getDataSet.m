function [newInstances]=getDataSet(instances,variables)
    
    %variables=variables-1;
    remove = javaObject('weka.filters.unsupervised.attribute.Remove');
    remove.setAttributeIndices(java.lang.String([regexprep(num2str(variables,17), '\s*', ','),',last']));
    remove.setInvertSelection(true);

    remove.setInputFormat(instances);
    
    newInstances = javaMethod('useFilter','weka.filters.Filter',instances,remove);
   % newInstances = Filter.useFilter(instances, remove);
    
end