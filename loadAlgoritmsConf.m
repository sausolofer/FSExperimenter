function algorithms = loadAlgoritmsConf(algorithmsList,type)
algorithms={};
for i=1:length(algorithmsList)
    if strcmp(type,'Feature selection')
        fsAlgorithm=[];
        switch char(algorithmsList(i))
            case 'laplacian score'
                fsAlgorithm.name ='laplacian score';
                fsAlgorithm.shortName ='LS';
                options = [];
                %Euclidean
                options.Metric = 'Euclidean';
                options.NeighborMode = 'KNN';
                options.k =5;
                options.WeightMode = 'HeatKernel';
                %Cosine
                %                 options.Metric = 'Cosine';
                %                 options.NeighborMode = 'KNN';
                %                 options.k = 5;
                %                 options.WeightMode = 'Cosine';
            case 'spectrum'
                fsAlgorithm.name ='spectrum';
                fsAlgorithm.shotName ='SPEC';
                options=[];
                options.style=-1; %style - -1, use all, 0, use all except the 1st. k, use first k except 1st.
                options.spec=[]; %   spec - the spectral function to modify the eigen values.
                
                
            case  'svd entropy'
                fsAlgorithm.name ='svd entropy';
                fsAlgorithm.shotName ='SVD-Entropy';
                options=[];
                
            case 'distance entropy'
                fsAlgorithm.name ='distance entropy';
                fsAlgorithm.shotName ='DE';
                options=[];
                
            otherwise
                disp('Error')
        end
        fsAlgorithm.options = options;
        algorithms{i}=fsAlgorithm;
    elseif strcmp(type,'Classifier')
        
    else %Clustering
        
        
    end
end


end