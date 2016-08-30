function writeResults(result, datasetName, fsAlgorithm, resultsPath, resBuf, step)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
%   result:
%       The result object given from the function runEvaluations.
%
%   fsAlgorithm:
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
%% OS win
if(strcmp(resBuf.os,'Win'))
    
    wb = resBuf.wb;  
    if ~isempty(wb)
        %% Create a new sheet, name it
        curSheet = invoke(wb.Sheets,'Add');
        curSheet.Name = fsAlgorithm;
        
        %% Set the labels
        range = calcrange('A1',1,length(fn));
        values = get(curSheet, 'Range', range);
        values.Value = fn';
        
        %% Write the raw data (output from stat)
        accum = accum';
        range = calcrange('A2',size(accum,1), size(accum,2));
        values = get(curSheet, 'Range', range);
        values.Value = accum;
        
        %% Make graph of the classifiers (+1 for redundancy is 4) and their
        %  accuracies. The classifiers will all be on the same graph.
        accum = accum'; %straighten out accumulated data
        
%         data.accum = accum;
%         data.step = step;
%         data.clssifiersName;
        
        %% Plot
        cf = plotResults(accum, step, resultsPath, datasetName, fsAlgorithm);     
        
        graph = [resultsPath 'Plots' filesep datasetName  '_' char(fsAlgorithm) '_' 'Performance.eps'];
        %print(cf,'-dpng',graph);
        %print(cf,'-depsc2',[graph,'.eps']);
        print('-depsc2',graph);
        %saveas(cf,[graph,'.fig']);
        %saveas(gcf,[graph,'.fig']);
        savefig(cf,[graph,'.fig'])
        
        %% Put the plot in the Excel diagram.
        shapes = curSheet.Shapes;
        shapes.AddPicture(graph,0,1,500,18,510,330);
        close(cf);
        
        %% save
        wb.Save
        
    else
        disp('No excel installed!')
    end

else
    disp('Linux')
end



end