function [ out ] = fsSimpleRanking( instances )
%FSSIMPLERANKING Summary of this function goes here
%   Detailed explanation goes here

numAtt = instances.numAttributes - 1;
index = 1:numAtt;
%index = 1:50;

out.W = []; %weight of each features
out.fList = index; %contains a set of feature index. Features in the top of the rank list are most relevant features according to the algorithm
out.prf = 0; %smaller the weights are the more relevant (.prf=-1).
out.fImp = true; % is a subset selection algorithm?

end

