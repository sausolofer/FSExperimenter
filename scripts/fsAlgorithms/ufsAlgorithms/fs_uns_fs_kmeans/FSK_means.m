function [Sbest,A_circ]=FSK_means(data,options)
%FSK_MEANS Summary of this function goes here
%   Detailed explanation goes here


k=options.numCluster;
epsilon=options.epsilon;
[M,N]=size(data);

%r=k*log(k/epsilon)/epsilon^2;
r=10*k; %this value it is usualy enough according to the authors


%% compute the top-k right singulars vectors of data
% The singular values of a m×n matrix A are the positive square roots of the nonzero eigenvalues of the corresponding matrix ATA. The corresponding eigenvectors are called the singular vectors.
dataT=data'*data; %for to find the right singular vectors
[V,eig_val] = eig(dataT);
[V,eig_val] = sortem(V,eig_val);
Vk= V(:,1:k);
%% Compute the (normalized) leverage scores for each feature
for i=1:N
    p(i)=(norm(Vk(i,:),'fro'))^2/k;
    %p(i)=(norm(Vk(i,:)))^2/k;
end
[b,i]=sort(p,'ascend');
Sbest=i(1:k);

%sampling
S=[];
%D=diag(repmat(1,1,r));
D= zeros(r,r)
for t=1:r
    ei= zeros(1,N);
    selectedIndexFeature = getFeature(p);
    for i=1:N
        if(selectedIndexFeature == i)
            ei(i)=1;
            S=[S,ei'];
            D(t,t)= 1/sqrt(r*p(i));
        end
    end
end
A_circ=data*S*D;

    function T = getFeature(p)
        T = gendist(p,1,1);
    end
end


