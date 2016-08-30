function outPutFileName = writeGlobalRes2(outPutFileName,res,dir, evalMeasures)

if isempty(res) || isempty(dir)
    return;
end

dataSetName = res.DataSetName;

if isempty(outPutFileName)
    %best average evaluation files
    for i=1:length(res.resultEvaluation)
        resEval = res.resultEvaluation{i};        
        for j=1:length(evalMeasures)
            newField = ['Average',evalMeasures{j}];
            outPutFileName{i,j}=[dir,resEval.classifName,'_',newField,'_general_results.csv']; % Name of input data files
            fid = fopen(outPutFileName{i,j},'wt');
            createResultFileAndHead(fid,resEval,newField);
            %writeDataInFile(fid,resEval,dataSetName,newField);
        end       
    end
    %feature selection time file
    outPutFileName{i+1,1}=[dir,'fsRuntime','_','general_results.csv']; % Name of input data files
    fid= fopen(outPutFileName{i+1,1},'wt');
    createResultFileAndHead(fid, res.AveFsRunTime{1}, 'fsAveTime')
end
[m,n] = size(outPutFileName);

for i=1:m-1
    resEval = res.resultEvaluation{i};
    for j=1:n
        newField = ['Average',evalMeasures{j}];
        fid = fopen(outPutFileName{i,j},'a+');
        writeDataInFile(fid,resEval,dataSetName,newField);
    end
end

fid = fopen(outPutFileName{i+1,1},'a+');
writeDataInFile(fid,res.AveFsRunTime{1},dataSetName,'fsAveTime');

% for k=1:length(outPutFileName)
%     fid{k} = fopen(outPutFileName{k},'a+');
%     if k == length(outPutFileName)
%         resBySelector = getResByLearning(res.AveFsRunTime,'fsAveTime');
%     else
%         resBySelector = getResByLearning(res.resultEvaluation{k}.bestSubsetEvalRes,'AverageACC');
%     end
%     
%     fprintf(fid{k},'%s, ',char(res.DataSetName));
%     for j=1:length(resBySelector)
%         if j == length(resBySelector)
%             fprintf(fid{k},'%s\n',num2str(resBySelector(j)));
%         else
%             fprintf(fid{k},'%s, ',num2str(resBySelector(j)));
%         end
%         
%     end
%     %fprintf(fid{k},'\n');
%     
%     fclose(fid{k});
%     %fclose('all');
%     %res{k}.bestSubsetEvalRes
% end
    function  writeDataInFile(fid,resultEvaluation,dataSetName,field)
        resBySelector = getResByLearning(resultEvaluation.(field), field);
        fprintf(fid,'%s, ',char(dataSetName));
        for k=1:length(resBySelector)
            if k == length(resBySelector)
                fprintf(fid,'%s\n',num2str(resBySelector(k)));
            else
                fprintf(fid,'%s, ',num2str(resBySelector(k)));
            end
        end
        fclose(fid);
    end

    function resBySelector = getResByLearning(learningRes,field)
        for l=1:length(learningRes)
            resBySelector(l) = learningRes{l}.(field);
        end
    end
end