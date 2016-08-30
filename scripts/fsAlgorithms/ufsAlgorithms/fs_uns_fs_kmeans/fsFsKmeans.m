 function [out] = fsFsKmeans(instances,epsilon)

%% initializes the parameters
[X,~] = getNumericCodification(instances);
clusters=instances.numClasses;

%options configuration
options = [];
options.epsilon = epsilon;
options.numCluster = clusters;

%% Invokes the FSK_means method with given options
[Sbest,A_circ] = FSK_means(X,options);
bestValue=A_circ;

out.W = bestValue; %weight of each feature
out.fList = Sbest; %contains a set of feature index. Features in the top of the rank list are most relevant features according to the algorithm
out.prf = 0; %smaller the weights are the more relevant (.prf=-1).
out.fImp = true; % is a subset selection algorithm?
end