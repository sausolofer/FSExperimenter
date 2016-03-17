function out = getResults(outputFile,missigInstances,originalData)
import weka.core.*;

out.rmse=[];
out.accuracy=[];
out.executionTime=outputFile.executionTime;

newOriginalData=  javaObject('weka.core.Instances',originalData);
newOriginalData.insertAttributeAt(Attribute(java.lang.String('order')), 0);

imputedData = outputFile.completeData;
realNumericValues=[];
imputedNumericValues=[];
realCategoricalValues=[];
imputedCategoricalValues=[];
k=1;
k2=1;
for i=1:missigInstances.numInstances
    instance = missigInstances.get(i-1);
    for j=1:instance.numAttributes
        if instance.isMissing(j-1) && instance.attribute(j-1).isNumeric
            realNumericValues(k) = newOriginalData.get(i-1).value(j-1);
            imputedNumericValues(k) = imputedData.get(i-1).value(j-1);
            k = k + 1;
        else if instance.isMissing(j-1) && ~instance.attribute(j-1).isNumeric
                realCategoricalValues(k2) = newOriginalData.get(i-1).value(j-1);
                imputedCategoricalValues(k2) = imputedData.get(i-1).value(j-1);
                k2 = k2 + 1;
            end
        end
    end
end
out.rmse = rmse(realNumericValues,imputedNumericValues);
out.accuracy = acc(realCategoricalValues,imputedCategoricalValues);
end