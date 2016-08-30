function res = evalWekaClusteringAlg(clusteringAlg, trainingInstances, featIDX, numOfFea,  step, subsetEval, repetitionsForClusteringAlg)

res=[];

if subsetEval
    numF = sum(featIDX>0);
else
    numF = step:step:numOfFea;
end

acc = zeros(length(numF),1);
nmi =  zeros(length(numF),1);
rand = zeros(length(numF),1);
ajustedRand = zeros(length(numF),1);
jaccard =  zeros(length(numF),1);
fm = zeros(length(numF),1);
silhouette =  zeros(length(numF),1);
%dunn = zeros(length(numF),1);
clusteringRuntime =  zeros(length(numF),1);
clusteringAssigments = cell(1,length(numF));

oversel = 0; cal = 0;
[X,trueLabels] = getNumericCodification(trainingInstances);
numOfClasses = trainingInstances.numClasses;
clusteringAlg.setNumClusters(numOfClasses); %setting num of classes

accumAcc = zeros(1, repetitionsForClusteringAlg);
accumNmi =  zeros(1, repetitionsForClusteringAlg);
accumRand = zeros(1, repetitionsForClusteringAlg);
accumAjustedRand = zeros(1, repetitionsForClusteringAlg);
accumJaccard =  zeros(1, repetitionsForClusteringAlg);
accumFM = zeros(1, repetitionsForClusteringAlg);
accumSilhouette = zeros(1, repetitionsForClusteringAlg);

for i=1:length(numF)
    l = numF(i);
    
    % obtain the dataset on the selected features
    reducedTrainingInstances = getDataSet(trainingInstances, featIDX(1:l));
    reducedTrainingInstances.setClassIndex(-1); %unsetting the class
    
    reducedTrainingInstances.deleteAttributeAt(reducedTrainingInstances.numAttributes()-1) %deleting class attribute
    
    start = clock();
    for j=1:repetitionsForClusteringAlg  
        tmp = '';
        tmp = wekaArgumentString({'-S',j},tmp);  %Random number seed.
        tmp = wekaArgumentString({'-O',''},tmp);
        clusteringAlg.setOptions(tmp);
        %perform model clustering based on the selected features and repeats k times
        clusteringAlg.buildClusterer(reducedTrainingInstances);
        %This array returns the cluster number (starting with 0) for each instance
        % The array has as many elements as the number of instances
        assignments = clusteringAlg.getAssignments();

        assignments = assignments+1;
        trueLabels = trueLabels+1;
        %% Clustering evaluation
        globalRes = getClusteringEvaluations(double(assignments), trueLabels, X, numOfClasses);
        
        accumAcc(j) = globalRes.ACC;
        accumNmi(j) =  globalRes.NMI;
        accumRand(j) = globalRes.Rand;
        accumAjustedRand(j) = globalRes.AjustedRand;
        accumJaccard(j) =  globalRes.Jaccard;
        accumFM(j) = globalRes.FM;
        
        accumSilhouette(j) =  globalRes.coefSilhouette;
        %accumDunn(j) = globalRes.DunnIndex;
    end
    
    finalTime = clock() - start;
    clusteringRuntime(i) = clock2secs(finalTime)/repetitionsForClusteringAlg;
    
    %Average
    acc(i) = mean(accumAcc);
    nmi(i) =  mean(accumNmi);
    rand(i) = mean(accumRand);
    ajustedRand(i) = mean(accumAjustedRand);
    jaccard(i) =  mean(accumJaccard);
    fm(i) = mean(accumFM);
    
    silhouette(i) =  mean(accumSilhouette);
    %dunn(i) = mean(accumDunn);
    clusteringAssigments{i} = assignments;
    
    
    fprintf('total features: %5i,   select features: %5i,   %s acc value: %.3f\n', reducedTrainingInstances.numAttributes, l, char(clusteringAlg.getClass().getSimpleName()), acc(i));
    %char(classifer.toString)
    if oversel && ~cal
        cal = 1;
    end
end

res.acc = acc;
res.nmi =  nmi;
res.rand = rand;
res.ajustedRand = ajustedRand;
res.jaccard =  jaccard;
res.fm = fm;
res.silhouette =  silhouette;
%res.dunn = dunn;
res.clusteringRuntime =  clusteringRuntime;
res.clusteringAssigments = clusteringAssigments;
end