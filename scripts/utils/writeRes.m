function cf = writeRes(result, datasetName, algorithm, resBuf, step, field, pathForPlotting, nameForPlotting, typeOfExperiment)
% Defaults for this blog post
% width = 5;     % Width in inches
% height = 3;    % Height in inches
% alw = 0.75;    % AxesLineWidth
% fsz = 11;      % Fontsize
% lw = 1.5;      % LineWidth
% msz = 8;       % MarkerSize
if strcmp(typeOfExperiment,'Classification') && strcmp(field,'ACC') 
    ylabelStr='Classification Accuracy';
elseif strcmp(typeOfExperiment,'Clustering') && strcmp(field,'ACC') 
    ylabelStr='Clustering Accuracy';
else
     ylabelStr = field;
end

cf =  plotRes(result, field, step, ['Performance of ',char(algorithm), ' on ', datasetName], ylabelStr);
%print(cf,'-dpng',graph);
%print(cf,'-depsc2',[graph,'.eps']);


% Here we preserve the size of the image when we save it.
% set(cf,'InvertHardcopy','on');
% set(cf,'PaperUnits', 'inches');
% papersize = get(cf, 'PaperSize');
% left = (papersize(1)- width)/2;
% bottom = (papersize(2)- height)/2;
% myfiguresize = [left, bottom, width, height];
% set(cf,'PaperPosition', myfiguresize);

print(cf,'-depsc2',[pathForPlotting, 'eps', filesep, nameForPlotting, '_', field, '_', 'Performance.eps']);
%saveas(cf,[graph,'.fig']);
%saveas(gcf,[graph,'.fig']);
savefig(cf,[pathForPlotting, 'sources', filesep, nameForPlotting, '_', field, '_', 'Performance.fig']);
close(cf);
end