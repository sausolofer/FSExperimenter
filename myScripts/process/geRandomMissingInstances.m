function missingInstances = geRandomMissingInstances(instances,resultsPath,options,k)
import java.io.BufferedWriter;
import java.io.FileWriter;
import weka.core.*;

instancesCopy = javaObject('weka.core.Instances',instances);
m=instancesCopy.numInstances;
n=instancesCopy.numAttributes;
missingPercent = options.missingPct;

kp=round(m*n*missingPercent/100);
[y,idx] = datasample(reshape(weka2matlab(instancesCopy),1,m*n),kp,'Replace',false);
[I,J] = ind2sub([m,n],idx);

numNominalAtt=0;
for p=1: n
    if instancesCopy.attribute(p-1).isNominal
        numNominalAtt=numNominalAtt + 1;
    end
end


for i=1:length(I)
    currentInstance=instancesCopy.instance(I(i)-1);
    while allFeaturesAreMissing(currentInstance,numNominalAtt)==1
        R = round(unifrnd(1,m));
        currentInstance=instancesCopy.instance(R-1);
    end
    instancesCopy.instance(I(i)-1).setMissing(J(i)-1);
    
end

%%Save partial results
MissingDataSetsDir=[resultsPath,'MissingDataSets',filesep];
[status,message]= mkdir(MissingDataSetsDir);

fileName = [MissingDataSetsDir,'file_',num2str(k),'.arff'];
writer = BufferedWriter(FileWriter(fileName));
writer.write(instancesCopy.toString);
writer.flush;
writer.close;

%adding order atrribute
instancesCopy.insertAttributeAt(Attribute(java.lang.String('order')), 0);
for i = 1:m
    instancesCopy.instance(i-1).setValue(0, i);
end
instancesCopy.setClassIndex(instancesCopy.numAttributes-1)
missingInstances=instancesCopy;

    function boolean = allFeaturesAreMissing(instance,numberOfNominalAttr)
        n2=instance.numAttributes;
        cont=0;
        for j=1:n2
            if instance.isMissing(j-1)
                cont=cont+1;
            end
        end
        if cont == (n2-1-numberOfNominalAttr)
            boolean= 1;
        else
            boolean= 0;
        end
    end

end