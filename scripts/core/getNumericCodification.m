function [X,Y] = getNumericCodification(intances)

[X] = weka2matlab(intances,[]);
[~,numOfAttributes]=size(X);
Y=X(:,numOfAttributes);

X=X(:,1:numOfAttributes-1);

end