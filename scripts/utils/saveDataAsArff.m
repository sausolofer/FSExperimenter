function saveDataAsArff(X,Y,dirToSave,fileName)
%Save data as Instances weka object

numOfFeatures = size(X,2);
data = [X,Y];

featureNames = cell(1,numOfFeatures+1);
for i = 1 : numOfFeatures + 1
    featureNames{i} = ['Var',num2str(i)];
end

instances = matlab2weka(fileName, featureNames, data, numOfFeatures+1);

dataFileName = [dirToSave,fileName, '.arff'];
file = javaObject('java.io.File',java.lang.String(dataFileName));

arffSaver = javaObject('weka.core.converters.ArffSaver');
arffSaver.setInstances(instances);
arffSaver.setFile(file);
arffSaver.writeBatch();

end