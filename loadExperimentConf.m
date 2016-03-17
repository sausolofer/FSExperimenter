%% Experiment setting and options
experimentName = 'Exp1';
numOfFeaturesACCrankingEvaluation =  2;

%% paths
curPath = pwd;
% Results path
resultsPath = [curPath,filesep,'ResultsDir',filesep];
dataSetsPath=[curPath,filesep,'dataSets', filesep];

%% dataSets
%datasetsCell={'iris'};
datasetsCell={'Lymphoma2Classes','Leukemia_train','EmbrionalTumor','warpPIE10P','PCMAC','RELATHE','BASEHOCK','orlraws10P'};
for i=1:length(datasetsCell)
    datasetsCell(i)=strcat(dataSetsPath, datasetsCell(i));
end
%dataSetsToProcessPath = [pwd,filesep,'DataSets',filesep];
%dataSetList = getDataSetListFromPath(dataSetsToProcessPath);
%dataset = java.lang.String([pwd,filesep,'Data',filesep,'iris.arff']);


%% UNSUPERVISED FEATURE SELECTORS
%selectorsCell={'cfs'};
%selectorsCell={'laplacian score','spectrum','distance entropy','svd entropy'};
selectorsCell={'spectrum'};
