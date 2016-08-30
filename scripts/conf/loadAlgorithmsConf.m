function algorithms = loadAlgorithmsConf(algorithmsList,type)

algorithms=[];
if isempty(algorithmsList)
    return;
end

for i=1:length(algorithmsList)
    if strcmp(type,'Feature selection')
        fsAlgorithm=[];
        switch char(algorithmsList(i))
            case 'laplacianScore'
                fsAlgorithm.fullName ='Laplacian Score';
                fsAlgorithm.codeName ='laplacianScore';
                fsAlgorithm.plottingName = 'Laplacian Score';
                options = [];
                %Euclidean
                options.Metric = 'Euclidean';
                options.NeighborMode = 'KNN';
                options.k =5;
                options.WeightMode = 'HeatKernel';
                %Cosine
                %options.Metric = 'Cosine';
                %options.NeighborMode = 'KNN';
                %options.k = 5;
                %options.WeightMode = 'Cosine';
            case 'SPEC'
                fsAlgorithm.fullName ='spectrum';
                fsAlgorithm.codeName ='SPEC';
                fsAlgorithm.plottingName = 'SPEC';
                options=[];
                options.style=-1; %style - -1, use all, 0, use all except the 1st. k, use first k except 1st.
                options.spec=[]; %   spec - the spectral function to modify the eigen values.
                
                
            case 'svdEntropy'
                fsAlgorithm.fullName ='svd Entropy';
                fsAlgorithm.codeName ='svdEntropy';
                fsAlgorithm.plottingName = 'SVD-Entropy';
                options=[];
                
            case 'distanceEntropy'
                fsAlgorithm.fullName ='Distance Entropy';
                fsAlgorithm.codeName ='distanceEntropy';
                fsAlgorithm.plottingName = 'Distance Entropy';
                options=[];
                
            case 'fsfs'
                fsAlgorithm.fullName ='fsfs';
                fsAlgorithm.codeName ='fsfs';
                fsAlgorithm.plottingName = 'Fsfs';
                options=[];
                
            case 'cfs'
                fsAlgorithm.fullName ='Correlation based feature selection';
                fsAlgorithm.codeName ='cfs';
                fsAlgorithm.plottingName = 'Cfs';
                options=[];
                
            case 'Usfsm' %our method
                fsAlgorithm.fullName ='Usupervised Spectral Feature Selection for Mixed data';
                fsAlgorithm.codeName ='Usfsm';
                fsAlgorithm.plottingName = 'Usfsm';
                options=[];
                
            case 'Ufsm' %our method
                fsAlgorithm.fullName ='Usupervised Feature Selection for Mixed data';
                fsAlgorithm.codeName ='Ufsm';
                fsAlgorithm.plottingName = 'Ufsm';
                options=[];  
                
            case 'Ufsme' %our method
                fsAlgorithm.fullName ='Usupervised Feature Selection for Mixed data based on entropy';
                fsAlgorithm.codeName ='Ufsme';
                fsAlgorithm.plottingName = 'Ufsme';
                options=[];
                                
            case 'SUD'
                fsAlgorithm.fullName ='Sequential backward selection for Unsupervised Data ';
                fsAlgorithm.codeName ='SUD';
                fsAlgorithm.plottingName = 'SUD';
                options=[];
                
            case 'SimpleRanking' % No selection simple ranking
                fsAlgorithm.fullName ='Simple Ranking';
                fsAlgorithm.codeName ='SimpleRanking';
                fsAlgorithm.plottingName = 'Simple Ranking';
                options=[];
                
                %KFST algorithms
            case 'UFSACO'
                fsAlgorithm.fullName ='UFSACO';
                fsAlgorithm.codeName ='UFSACO';
                fsAlgorithm.plottingName = 'UFSACO';
                options=[];
                
            case 'MGSACO'
                fsAlgorithm.fullName ='MGSACO';
                fsAlgorithm.codeName ='MGSACO';
                fsAlgorithm.plottingName = 'MGSACO';
                options=[];
                
            case 'RRFSACO1'
                fsAlgorithm.fullName ='RRFSACO1';
                fsAlgorithm.codeName ='RRFSACO1';
                fsAlgorithm.plottingName = 'RRFSACO1';
                options=[];
                
            case 'RRFSACO2'
                fsAlgorithm.fullName ='RRFSACO2';
                fsAlgorithm.shortName ='RRFSACO2';
                fsAlgorithm.plottingName = 'RRFSACO2';
                options=[];
                
            case 'IRRFSACO1'
                fsAlgorithm.fullName ='IRRFSACO1';
                fsAlgorithm.codeName ='IRRFSACO1';
                fsAlgorithm.plottingName = 'IRRFSACO1';
                options=[];
                
            case 'IRRFSACO2'
                fsAlgorithm.fullName ='IRRFSACO2';
                fsAlgorithm.codeName ='IRRFSACO2';
                fsAlgorithm.plottingName ='IRRFSACO2';
                options=[];
                
            case 'RRFS'
                fsAlgorithm.fullName ='RRFS';
                fsAlgorithm.codeName ='RRFS';
                fsAlgorithm.plottingName = 'RRFS';
                options=[];
                
            case 'MutualCorrelation'
                fsAlgorithm.fullName = 'Mutual Correlation';
                fsAlgorithm.codeName = 'MutualCorrelation';
                fsAlgorithm.plottingName = 'Mutual Correlation';
                options=[];
                
            %Hibryds
            case 'DashAndLiuFSAlgorithm'
                fsAlgorithm.fullName = 'Dash and Liu hybrid feature selection algorithm';
                fsAlgorithm.codeName = 'DashAndLiuFSAlgorithm';
                fsAlgorithm.plottingName = 'Dash and Liu';
                options=[];
                
            case 'YunLiEtAl'
                fsAlgorithm.fullName = 'Metodo basado en entropia exponencial';
                fsAlgorithm.codeName = 'YunLiEtAl';
                fsAlgorithm.plottingName = 'Yun Li et al.';
                options=[];
                
            case 'LSWNCHSR'
                fsAlgorithm.fullName = 'Laplacian Score-Weighted Normalized Calinski Harabasz-Simple Ranking';
                fsAlgorithm.codeName = 'LSWNCHSR';
                fsAlgorithm.plottingName = 'LS-WNCH-SR';
                options=[];
                
            case 'LSWNCHBE'
                fsAlgorithm.fullName = 'Laplacian Score-Weighted Normalized Calinski Harabasz-Backward Elimination';
                fsAlgorithm.codeName = 'LSWNCHBE';
                fsAlgorithm.plottingName = 'LS-WNCH-BE';
                options=[];
                
                %Others
            case 'FsKmeans'
                fsAlgorithm.fullName = 'Randomized feature selection algorithm for k-means (FS-Kmeans)';
                fsAlgorithm.codeName = 'FsKmeans';
                fsAlgorithm.plottingName = 'FS-Kmeans';
                options=[];
                
            otherwise
                disp('Error code')
        end
        fsAlgorithm.options = options;
        algorithms{i}=fsAlgorithm;
        
    elseif strcmp(type,'Classifiers')
        classifier=[];
        switch char(algorithmsList(i))
            
            case 'Knn'
                classifier.fullName ='K-Nearest neighbour for mixed data';
                classifier.codeName ='knnMD';
                classifier.plottingName = 'Knn for mixed data';
                options = [];
                model = weka.classifiers.lazy.Knn();
                
                            
            case 'IBk'
                classifier.fullName ='K-Nearest neighbour';
                classifier.codeName ='knn';
                classifier.plottingName = 'Knn';
                options = [];
                model = weka.classifiers.lazy.IBk();
                k = 1;
                model.setKNN(k); 
                
            case 'Naive Bayes'
                classifier.fullName ='Naive Bayes';
                classifier.codeName ='bayes';
                classifier.plottingName = 'Naive Bayes';
                options = [];
                
                options.D = 1;
                %Ensure that param is legitimate.
                param = '';
                numtrue = 0;
                if(isfield(options,'K') && options.K)
                    param = '-K';
                    numtrue = numtrue + 1;
                end
                if(isfield(options,'D') && options.D)
                    param = '-D';
                    numtrue = numtrue + 1;
                end
                
                if(numtrue > 1)
                    error(['You may only have -D OR -K as parameters, not both. Neither is fine as well. ' ...
                        'Please remove at least one parameter by either removing it from the struct or setting to false, then try again.']);
                end
                
                %% Create the Java object of type Naive Bayes Classifier.
                model = weka.classifiers.bayes.NaiveBayes();
                
                %% Set the options to those of the user-submitted struct, or the default
                tmp = wekaArgumentString({param,''});
                model.setOptions(tmp);
            case 'C4.5'
                classifier.fullName ='C4.5 desision tree';
                classifier.codeName ='j48';
                classifier.plottingName = 'C4.5 DT';
                options=[];
                % Generates a J48 wrapper on the WEKA J48 implementation with given
                % parameters.
                %
                %   'args' parameters (with defaults):
                %    unpruned=0      -- set to 1 to use unpruned trees
                %    confidence=0.25 -- confidence threshold for pruning
                %    number=2        -- minimum number of instances per leaf
                %    reduced_error=0 -- set to 1 to use reduced error pruning
                %    folds=3         -- number of folds for reduced error pruning
                %    binary=0        -- set to 1 to use binary split for nominal attributes
                %    laplace=0       -- set to 1 if laplace smoothing technique is used for
                %                   predicted probabilities
                %    raising=1       -- set to 0 if subtree raising should not be performed
                %    cleanup=1       -- set to 0 if no cleaning up after the tree has been
                %                   built.
                %
                %    Note: If you wish to use all of the defaults, you may just pass in a
                %    non-struct parameter for 'args'. This will cause all of the default
                %    parameters to be used.
                %
                %    trainX, trainY:
                %    The X and Y values you wish to use to train the tree.
                %
                %    testX, testY:
                %    The X and Y values you wish to use to test the tree's accuracy.
                %
                %    Output:
                %    The output will be the same struct you passed in for 'a', but with the
                %    tree, the vital features, and accuracy appended as fields. They will
                %    be named 'classifier', 'features', and 'tree_accuracy', respectively.
                
                %% This is the default setup for the J48 tree, what the user will get if
                %% they do not pass in their own.
                %                 if(~isstruct(args))
                a = getJ48Defaults();
                %                 else
                %                     a = args;
                %                 end
                
                %% Create the Java object of type J48 tree.
                model = weka.classifiers.trees.J48();
                
                %% Set the options to those of the user-submitted struct, or the default
                tmp = '';
                
                if(isfield(a,'unpruned') && a.unpruned)
                    tmp = wekaArgumentString({'-U',''},tmp);
                end
                
                if(isfield(a,'confidence'))
                    tmp = wekaArgumentString({'-C',a.confidence},tmp);
                end
                
                if(isfield(a,'number'))
                    tmp = wekaArgumentString({'-M',a.number},tmp);
                end
                
                if(isfield(a,'reduced_error') && a.reduced_error)
                    tmp = wekaArgumentString({'-R',''},tmp);
                    
                    %using num folds doesn't make sense unless reduced error is selected.
                    if(isfield(a,'folds'))
                        tmp = wekaArgumentString({'-N',a.folds},tmp);
                    end
                end
                
                if(isfield(a,'binary') && a.binary)
                    tmp = wekaArgumentString({'-B',''},tmp);
                end
                
                if(isfield(a,'raising') && a.raising)
                    tmp = wekaArgumentString({'-S',''},tmp);
                end
                
                if(isfield(a,'cleaned') && a.cleaned)
                    tmp = wekaArgumentString({'-L',''},tmp);
                end
                
                model.setOptions(tmp);
                
                
            otherwise
                disp('Error')
        end
        classifier.model = model;
        algorithms{i}=classifier;
        
    else %Clustering
        clusteringAlg=[];
        switch char(algorithmsList(i))
            case 'Kmeans'
                clusteringAlg.fullName ='K-prototypes';
                clusteringAlg.codeName ='kPrototypes';
                clusteringAlg.plottingName = 'K-prototypes';
                options = [];
                
                model = weka.clusterers.SimpleKMeans();
                model.setSeed(10);
                %important parameter to set: preserver order, number of cluster.
                model.setPreserveInstancesOrder(true);
                %kmeans.setNumClusters(5);
            case 'Kprototype'
                model=[];
            otherwise
                
        end
        clusteringAlg.model = model;
        algorithms{i}=clusteringAlg;
        
    end
end


end