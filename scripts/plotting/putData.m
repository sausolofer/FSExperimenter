function h = putData(average, std, step, lineStyle, marker, color)
if length(average) ~= length(std)
    error(message('Mismatch dimensions'));
end

%for i=1:length(average)
% errorbar(expand(average, step, false), expand(std, step, true), marker);
% h = plot(expand(average, step, false), marker, 'LineWidth', 2);

errorbar(expand(average, step, false), expand(std, step, true), 'color',color, 'linestyle',lineStyle, 'Marker', marker);
h = plot(expand(average, step, false), 'color',color, 'linestyle',lineStyle, 'Marker', marker, 'LineWidth', 2);

%end
