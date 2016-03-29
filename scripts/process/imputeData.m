function outputFileStruct = imputeData(instances, algorithm)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Run a feature selection method                                                      %
%                                                                                      %
%                                                                                      %
% Input: dataset: path of input dataset                                                %
%        algorithm: algorithm 
%        path
%                                                                                      %
% Output:                                                                              %
%                                                                                      %
% Author: Saul Solorio Fernandez, MC. CS. Computacionales, INAOE                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

outputFileStruct=[];
completeData=[];

%temporizer
tic;
start=tic;
switch algorithm    
    case 'MIML-Imputation' 
        dataSet = javaMethod('getDataSet','converters.DataConverter',instances);
        tic;
        start=tic;
        imputedData= MIMLImputationAlgorithm(dataSet);
        executionTime = toc(start);
        completeData=javaMethod('getInstances','converters.DataConverter',imputedData);
        completeData.sort(0);
    case 'Mean-Imputation' 
        completeData= meanImputationAlgorithm(instances);
        executionTime = toc(start);
    case 'EM-imputation'
        completeData= EMImputationAlgorithm(instances); 
        executionTime = toc(start);
    otherwise
        disp('invalid option!');      
end


outputFileStruct.completeData=completeData;
outputFileStruct.executionTime=executionTime;