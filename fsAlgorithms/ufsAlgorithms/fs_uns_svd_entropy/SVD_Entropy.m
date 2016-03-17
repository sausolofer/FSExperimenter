
function entropia=SVD_Entropy(datos)
%funcion que calcula la entropia de un conjunto de datos

[eigenSamples,S,eigenGenes] = svd(datos,0);%   svd the input    X = USVt because genes information is displaeyd in eigensamples base and vice versa

[x,y] =size(S);% it isn't always equal
if x~=y
    minDim = min(x,y);
    S = S(1:minDim,1:minDim);% make it square
end

[dims,entropia] = estimateNumberOfSignificantDims(S,1);  % number of significant dimension to proces
