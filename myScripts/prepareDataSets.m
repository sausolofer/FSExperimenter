function prepareDataSets(dataSet, resultsPath, numberOfFolds, standadize)

import weka.core.Instances

%Load dataset
instances = loadARFF(char(dataSet));
arffSaver = javaObject('weka.core.converters.ArffSaver');

%Data standardization(optional)
if standadize==true
    instances = standardize(instances);
end

%% Creating partitions directory
partitionsDir=[resultsPath,'Partitions\'];
    [status,message]= mkdir(partitionsDir);
    if strcmp('Directory already exists.',message)
        disp(message);
    end

%% Original
if numberOfFolds == 1
    instancesFileName=[partitionsDir,char(instances.relationName), '.arff'];
    intancesFile = javaObject('java.io.File',java.lang.String(instancesFileName));
    saveArff(arffSaver,instances,intancesFile);
    
elseif numberOfFolds > 1
    %% Stratified data
    randx =  java.util.Random(5);
    randData = Instances(instances);
    randData.randomize(randx);
    
    if (randData.classAttribute.isNominal)
        randData.stratify(numberOfFolds);
    end
    
    
    %% Crating training and test sets
    for i = 0 : numberOfFolds-1
        trainingSet = randData.trainCV(numberOfFolds, i);
        testSet = randData.testCV(numberOfFolds, i);
        
        trainingSetFileName=[partitionsDir,char(trainingSet.relationName),'_Training',num2str(i+1), '.arff'];
        trainingFile = javaObject('java.io.File',java.lang.String(trainingSetFileName));
        saveArff(arffSaver,trainingSet,trainingFile);
        
        testSetFileName=[partitionsDir,char(trainingSet.relationName),'_Test',num2str(i+1), '.arff'];
        testFile = javaObject('java.io.File',java.lang.String(testSetFileName));
        saveArff(arffSaver,testSet,testFile);
    end
    
else
    disp('number of folds wrong!');
    return
end


    function saveArff(arffSaver,instances,file)
        arffSaver.setInstances(instances);
        arffSaver.setFile(file);
        arffSaver.writeBatch();
    end

disp([char(instances.relationName),'_',num2str(numberOfFolds),'-partitions: OK']);
end