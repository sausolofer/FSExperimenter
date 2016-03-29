function saveAndPlotResults(evaluations,datasetResultDir,missingPct)

outPutFileName=[datasetResultDir, evaluations{1}.dataSetName,'_results.txt']; % Name of input data files
fout= fopen(outPutFileName,'wt');
fprintf(fout,'#############################################################################################\n');
fprintf(fout,'# Results of %s dataset for %d%% of missing values.\n',evaluations{1}.dataSetName,missingPct);
fprintf(fout,'#############################################################################################\n\n');
fprintf(fout,'# \t Algorithm \t rmse (ave) \t rmse (std) \t acc (ave) \t acc (std) \t execution time (ave) \t execution time (std) \n');

rmseAve=[];
rmseStd= [];
accAve=[];
accStd = [];
timeAve= [];
timeStd=[];
for i=1:length(evaluations)
    alg{i} = evaluations{i}.algorithm;
    rmseAve(i) = evaluations{i}.rmseAve;
    rmseStd(i) = evaluations{i}.rmseStd;
    accAve(i)  = evaluations{i}.accuracyAve;
    accStd(i)  = evaluations{i}.accuracyStd;
    timeAve(i) = evaluations{i}.executionTimeAve;
    timeStd(i) = evaluations{i}.executionTimeStd;
    fprintf(fout,'%d\t%s\t%d\t%d\t%d\t%d\t%d\t%d\n',i,char(alg(i)),rmseAve(i),rmseStd(i),accAve(i),accStd(i),timeAve(i),timeStd(i));
end
fclose(fout);

% Make rmse plot
cf= figure('Visible','on','PaperPositionMode','auto');
handles1 = barweb(rmseAve, rmseStd, [], [], ...
    ['RMSE +- std for ', evaluations{1}.dataSetName,' with ',num2str(missingPct),'% of missig values'], ...
    'Algorithm','RMSE', [], [], char(alg), 0, 'plot');
hold off;
loc = [datasetResultDir, char(evaluations{1}.dataSetName), '_', 'RMSE'];
print('-depsc2',[loc,'.eps']);
print(cf,'-dpng',[loc,'.png']);
savefig(cf,[loc,'.fig']);
close(cf);

% Make the accuracy plot
cf= figure('Visible','on','PaperPositionMode','auto');
handles2 = barweb(timeAve, timeStd, [], [], ...
    ['Time +- std for ', evaluations{1}.dataSetName,' with ',num2str(missingPct),'% of missig values'], ...
    'Algorithm','Run-time (seconds)', [], [], char(alg), 0, 'plot');
hold off;
loc = [datasetResultDir, char(evaluations{1}.dataSetName), '_', 'runTime'];
print('-depsc2',[loc,'.eps']);
print(cf,'-dpng',[loc,'.png']);
savefig(cf,[loc,'.fig']);
close(cf);
end