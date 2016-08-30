function createResultFileAndHead(fid, res, field)

fprintf(fid,'%s, ','Dataset');
for i=1:length(res.(field))
    if i == length(res.(field))
        fprintf(fid,'%s\n', res.(field){i}.plottingName);
    else
        fprintf(fid,'%s, ', res.(field){i}.plottingName);
    end    
end

end