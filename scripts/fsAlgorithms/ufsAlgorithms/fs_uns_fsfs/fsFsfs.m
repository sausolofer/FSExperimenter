function [out] = fsFsfs(X)
reducedSubsetPercent = 50;
original_size= size(X,2);
k = round(original_size - original_size*reducedSubsetPercent/100);

[redu,fwt]=fsfs(X,original_size,k)

out.W = fwt'; %weight of each features
out.fList = redu'; %contains a set of feature index. Features in the top of the rank list are most relevant features according to the algorithm
out.prf = 0; %smaller the weights are the more relevant (.prf=-1).
out.fImp = true; % is a subset selection algorithm?