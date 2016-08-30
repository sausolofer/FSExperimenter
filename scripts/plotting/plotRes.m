function cf =  plotRes(res,field,step,titleStr, ylabelStr)

cf= figure('Visible','on','PaperPositionMode','auto');
lineStyle ={'-','--',':','-.'};
markers = {'o','+','*','.','x','s','d','h','p','<','>','^','v','o','+','*','.','x','s','d','h','p','<','>','^','v'};
colors = [0 0 1; 1,0,0; 0,1,0; 1,0,1; 0,1,1; 0.5,0.2,0.7; 0.1,0.6,0.7; 0.8,0.1,0.4; 0.2,0.2,1; 0.5,0.5,1; 1,0.5,0.2; 1,0.5,0.5; 0.2,1,0.7; 0.5,1,0.7; 0.4,0.7,.2];

if isForRankingPlot(res,field) %length(res{1}.(field)) > 1
    %markers = {'--b','-+r','-.k','-<g','->c','-sm','-dy'};
    
    
    %Plot the data
    hold on;
    grid;
    auxInd=1;
    for i=1:length(res)
        curr= res{i};
        if length(curr.(field)) == 1
            continue
        end
        name{auxInd} = curr.plottingName;
        %h(auxInd) = putData2(curr.(field), curr.([field,'_std']), step, markers{i});
        h(auxInd) = putData2(curr.(field),  curr.([field,'_std']), step, lineStyle{1}, markers{i}, colors(i,:));
        auxInd=auxInd+1;
    end
    
    %Set up some cosmetic stuff
    xlabel('Number of features');
    ylabel(ylabelStr);
    title(titleStr);
    %axis('tight');  }
    legend(h, name, 'Location', 'Best');
    %     if length(curr.(field))<10
    %         set(gca,'XTick',1:step:length(curr.(field))+1);
    %     end
    hold off;
else
    % Make one evaluation plot
    [ave, std, algList] = getDataForSubsetPlot(res);
    if strcmp(field,'BestACC')
        field= ylabelStr;
    end
    handles = barweb(ave', std', [], [], titleStr, 'Algorithm',field, [], [], algList, 0, 'plot',colors);
    hold off;
    
    % loc = [datasetResultDir, char(evaluations{1}.dataSetName), '_', 'RMSE'];
    % print('-depsc2',[loc,'.eps']);
    % print(cf,'-dpng',[loc,'.png']);
    % savefig(cf,[loc,'.fig']);
    % close(cf);
end
    function h = putData2(average, std, step, lineStyle, marker, color)
        if length(average) ~= length(std)
            error(message('Mismatch dimensions'));
        end               
        errorbar(expand(average, step, false), expand(std, step, true), 'color',color, 'linestyle', lineStyle, 'Marker', marker);
        h = plot(expand(average, step, false), 'color',color, 'linestyle',lineStyle, 'Marker', marker, 'LineWidth', 2);     
    end

    function [ave, std, algList] = getDataForSubsetPlot(res)
        for k=1:length(res)
            curr= res{k};
            algList{k} = curr.plottingName;
            ave(k) = curr.(field);
            std(k) = curr.([field,'_std']);
        end
        
    end
    function b = isForRankingPlot(res,field)
        counter=0;
        for j=1:length(res)
            if length(res{j}.(field)) > 1
                counter=counter+1;
            end
        end
        if counter>=1
            b=true;
        else
            b=false;
        end
    end
end