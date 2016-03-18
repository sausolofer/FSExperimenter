function algorithms = loadAlgoritmsConf(AlgorithmsList,type)

if strcmp(type,'Feature Selection')
    switch AlgorithmsList
        case 'laplacian score'
            %Euclidean
                options = [];
                options.Metric = 'Euclidean';
                options.NeighborMode = 'KNN';
                options.k =5;
                options.WeightMode = 'HeatKernel';
            %Cosine
%                 options = [];
%                 options.Metric = 'Cosine';
%                 options.NeighborMode = 'KNN';
%                 options.k = 5;
%                 options.WeightMode = 'Cosine';           

        case 'spectrum'       
        
        case  'svd entropy'
            
        case 'distance entropy'
            
        otherwise
            
    end
elseif strcmp(type,'Classifier')
    
else %Clustering
    
    
end

end