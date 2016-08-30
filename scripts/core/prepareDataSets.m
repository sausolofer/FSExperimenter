function partitionsDir = prepareDataSets(dataSet, resultsPath, numberOfFolds, standadize, treatMissingValues, seed, typeOfExperiment)

import weka.core.Instances

%Load dataset
instances = loadARFF(char(dataSet));

if numberOfFolds < 1 || numberOfFolds > instances.numInstances
    disp('number of folds wrong!');
    return;
end

dataSetname = getDataSetName_path(char(dataSet));
onlyName = strtok(dataSetname,'.');

%Data standardization(optional)
if standadize == true
    instances = standardize(instances);
end
%Treating missing values imputing with means and/or modes
if treatMissingValues==true
    instances = replaceMissingValues(instances);
end

%% Creating partitions directory
partitionsDir=[resultsPath,'DataPartitions',filesep];
[~,message]= mkdir(partitionsDir);
if strcmp('Directory already exists.',message)
    disp(message);
end

arffSaver = javaObject('weka.core.converters.ArffSaver');
if strcmp(typeOfExperiment, 'Classification')
    
    if numberOfFolds == 1 %Same training and test sets
        trainingSetFileName = [partitionsDir,onlyName ,'_Training1', '.arff'];
        trainingFile = javaObject('java.io.File',java.lang.String(trainingSetFileName));
        saveArff(arffSaver,instances,trainingFile);
        
        testSetFileName=[partitionsDir,onlyName,'_Test1', '.arff'];
        testFile = javaObject('java.io.File',java.lang.String(testSetFileName));
        saveArff(arffSaver,instances,testFile);
    else
        %% Stratified data
        randx =  java.util.Random(seed);
        randData = Instances(instances);
        randData.randomize(randx);
        
        if (randData.classAttribute.isNominal)
            randData.stratify(numberOfFolds);
        end
        
        %% Crating training and test sets
        for i = 0 : numberOfFolds-1
            trainingSet = randData.trainCV(numberOfFolds, i);
            testSet = randData.testCV(numberOfFolds, i);
            
            trainingSetFileName=[partitionsDir,onlyName ,'_Training',num2str(i+1), '.arff'];
            trainingFile = javaObject('java.io.File',java.lang.String(trainingSetFileName));
            saveArff(arffSaver,trainingSet,trainingFile);
            
            testSetFileName=[partitionsDir,onlyName,'_Test',num2str(i+1), '.arff'];
            testFile = javaObject('java.io.File',java.lang.String(testSetFileName));
            saveArff(arffSaver,testSet,testFile);
        end
    end
    fprintf([onlyName,'_',num2str(numberOfFolds),'-partitions for classification: OK\n']);
    
else
    
    if numberOfFolds == 1 %All data for feature selection and validation
        trainingSetFileName = [partitionsDir,onlyName ,'_Training1', '.arff'];
        trainingFile = javaObject('java.io.File',java.lang.String(trainingSetFileName));
        saveArff(arffSaver,instances,trainingFile);
    else
        %% Stratified data
        randx =  java.util.Random(seed);
        randData = Instances(instances);
        randData.randomize(randx);
        
        if (randData.classAttribute.isNominal)
            randData.stratify(numberOfFolds);
        end
        
        %% Crating training and test sets
        for i = 0 : numberOfFolds-1
            trainingSet = randData.trainCV(numberOfFolds, i);
            
            trainingSetFileName=[partitionsDir,onlyName ,'_Training',num2str(i+1), '.arff'];
            trainingFile = javaObject('java.io.File',java.lang.String(trainingSetFileName));
            saveArff(arffSaver,trainingSet,trainingFile);
        end
    end
    
    fprintf([onlyName,'_',num2str(numberOfFolds),'-partitions for clustering: OK\n']);    
end

    function saveArff(arffSaver,instances,file)
        arffSaver.setInstances(instances);
        arffSaver.setFile(file);
        arffSaver.writeBatch();
    end

end