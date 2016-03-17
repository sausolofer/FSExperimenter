function accuracy = acc(realValues,imputedValues)

if length(realValues) ~= length(imputedValues)
    error('matrix must be of same dimension');
end
accum=0;
for i=1:length(realValues)
    if realValues(i) == imputedValues(i)
        accum= accum + 1;
    end
end
accuracy = accum/length(realValues);
end