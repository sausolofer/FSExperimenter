function fn = writeXLS2(result, datasetName, algorithm, resultsPath, wb)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
%   result:
%       The result object given from the function scriptStat_sup.
%
%   algorithmName:
%       Scalar character array
    
%% Get the field names and width of the dataset from the result   
    fn = fieldnames(result);
    width = size(result.(fn{1}), 2);
    
%% Transpose the fields into a matrix
    accum = zeros(length(fn), width);
    for n = 1:length(fn)
        a = result.(fn{n});
        accum(n,:) = a;
    end
    
%% Open the excel server
    %if nargin < 4
        exl = actxserver('excel.application');
        exlWkbk = exl.Workbooks;
        wb = invoke(exlWkbk,'Add');
    %end
    
%% Create a new sheet, name it
    curSheet = invoke(wb.Sheets,'Add');
    curSheet.Name = datasetName;
    
%% Set the labels
    range = calcrange('A1',1,length(fn));
    values = get(curSheet, 'Range', range);
    values.Value = fn';
    
%% Write the raw data (output from stat)
    accum = accum';
    range = calcrange('A2',size(accum,1), size(accum,2));
    values = get(curSheet, 'Range', range);
    values.Value = accum;
    
%% Make graph of the three classifiers (+1 for redundancy is 4) and their
%  accuracies. The classifiers will all be on the same graph.
    accum = accum'; %straighten out accumulated data
    
%% The plot
    cf= figure('Visible','off','PaperPositionMode','auto');
    %cf= figure('Visible','on','PaperPositionMode','auto');

    %Plot the data
    hold on;
    
    %titleStr = strcat('Accuracies of various classifiers on the "', datasetName, '"', ' dataset using the  ', char(algorithm),' rank');
    %titleStr =['Accuracies of various classifiers on the "', datasetName, '"', ' dataset using the ', char(algorithm),' rank'];
    
    if size(accum,2) ~= 1
        errorbar(expand(accum(1,:), 5, false), expand(accum(2,:), 5, true), '-b');
        errorbar(expand(accum(3,:), 5, false), expand(accum(4,:), 5, true), '--r');
        errorbar(expand(accum(5,:), 5, false), expand(accum(6,:), 5, true), '-.k');
            %errorbar(expand(accum(7,:), 5, false), expand(accum(8,:), 5, true), 'm');
        %plot(expand(accum(1,:), 5, false), 'LineWidth',2, 'Color', 'blue');
        %plot(expand(accum(3,:), 5, false), 'LineWidth',2, 'Color', 'red');
        %plot(expand(accum(5,:), 5, false), 'LineWidth',2,'Color', 'black');
        plot(expand(accum(1,:), 5, false), '-b', 'LineWidth',2);
        plot(expand(accum(3,:), 5, false), '--r', 'LineWidth',2);
        plot(expand(accum(5,:), 5, false), '-.k', 'LineWidth',2);
            %plot(expand(accum(5,:), 5, false), 'LineWidth',2,'Color', 'magenta');
        
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

%% Put the plot in the Excel diagram.
    %pngLoc = [pwd filesep 'temp_pngs' filesep 'output.png'];
    %pngLoc = [pwd filesep 'temp_pngs' filesep 'output.eps'];
    pngLoc = [resultsPath datasetName '_' char(algorithm) '_' 'classifiers_ACC.eps'];
    %print(cf,'-dpng',pngLoc);
    %print(cf,'-depsc2',[pngLoc,'.eps']);
    print('-depsc2',pngLoc);
    %saveas(cf,[pngLoc,'.fig']);
    %saveas(gcf,[pngLoc,'.fig']);
    savefig(cf,[pngLoc,'.fig']);
    shapes = curSheet.Shapes;
    shapes.AddPicture(pngLoc,0,1,500,18,510,330);
    close(cf);
    
%% Make the redundancy plot
    cf= figure('Visible','off','PaperPositionMode','auto');
    %cf= figure('Visible','on','PaperPositionMode','auto');

    %Plot the data
    hold on;
    
    %titleStr = ['Redundancy on the "' datasetName '"',' dataset'];
    %titleStr = ['Redundancy using the ' char(algorithm) ' rank on the "' datasetName '"' ' dataset'];
    %titleStr = ['Redundancy on the "' datasetName '"' ' dataset using the '  char(algorithm)  ' rank'  ];
    
    insertRedPlot = true;
    
    if size(accum,2) ~= 1
        errorbar(expand(accum(7,:), 5, false), expand(accum(8,:), 5 ,true), 'b');
        plot(expand(accum(7,:), 5, false), 'Color', 'blue', 'LineWidth', 2);

        %Set up some cosmetic stuff
        xlabel('Number of features');
        ylabel(strcat('Redundancy'));
        axis('tight');
        %title(titleStr);
    else
        if(result.res_red ~= 0)
            barweb(result.res_red, result.res_red_std,.25,[],titleStr,[],...
                'Redundancy');
        else
            insertRedPlot = false;
        end
    end
    
    hold off;
    
%% Put the plot in the Excel diagram.
    if insertRedPlot
        
        legend('Redundancy', 'Location', 'Best');
        
        %pngLoc = [pwd filesep 'temp_pngs' filesep 'red.png'];
        %pngLoc = [pwd filesep 'temp_pngs' filesep 'red.eps'];
         pngLoc = [resultsPath datasetName '_' char(algorithm) '_' 'redundancy.eps'];
        %print(cf,'-dpng',pngLoc);
        %print(cf,'-depsc2',[pngLoc,'.eps']);
        print('-depsc2',pngLoc);
        %saveas(gcf,[pngLoc,'.fig']);
        %saveas(cf,[pngLoc,'.fig']);
        savefig(cf,[pngLoc,'.fig']);
        shapes = curSheet.Shapes;
        shapes.AddPicture(pngLoc,0,1,500,400,510,330);
    end
    
    close(cf);
    
    %if nargin < 4
    %% Show the Excel file the the user
    exl.visible = 0;
    %% save
    %save(exl, datasetName)
    %Workbook.SaveAs([cd '\' get(S.ls,'string') '.xlsx'])
    xlWorkbookDefault = 51; % # it's the Excel constant, not sure how to pass it other way
    wb.SaveAs([fullfile(resultsPath,datasetName),'_',char(algorithm),'_XLSX_result'], xlWorkbookDefault)

    %% Kill the exl object        
    wb.Close(false)
    exl.Quit
    exl.delete
    clear exl;
    %end
end