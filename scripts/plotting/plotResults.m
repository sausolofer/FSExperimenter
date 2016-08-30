function cf = plotResults(accum, step, resultsPath, datasetName, algorithm)

%cf= figure('Visible','off','PaperPositionMode','auto');
cf= figure('Visible','on','PaperPositionMode','auto');

%Plot the data
hold on;

%titleStr = strcat('Accuracies of various classifiers on the "', datasetName, '"', ' dataset using the  ', char(algorithm),' rank');
%titleStr =['Accuracies of various classifiers on the "', datasetName, '"', ' dataset using the ', char(algorithm),' rank'];

if size(accum,2) ~= 1
    
    markers = {'-b','--r','-.k'};
    mcount = 0;
    for i = 1: size(accum,1) - 1
        mcount = mcount+1;
        if mod(i,2) == 0
            mcount = mcount-1;
            continue
        end
        errorbar(expand(accum(i,:), step, false), expand(accum(i+1,:), step, true), markers{mcount});
        plot(expand(accum(i,:), step, false), markers{mcount}, 'LineWidth', 2);
    end
    
    %Set up some cosmetic stuff
    xlabel('Number of features');
    ylabel('Accuracy');
    %  title(titleStr);
    axis('tight');
else
    titleStr='Grafica';
    barweb([result.res_svm result.res_bayes result.res_j48], ...
        [result.res_svm_std result.res_bayes_std result.res_j48_std], ...
        [],[],...
        titleStr,...
        'Evaluator',...
        'Accuracy' ...
        );
end

legend('SVM','Bayes', 'J48', 'Location', 'Best');


hold off;

end