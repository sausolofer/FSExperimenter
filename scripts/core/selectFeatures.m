function [dataSet,RES] = selectFeatures(dataSet, fsAlgorithm, resultsPath, iter)

%%
algorithmCode = fsAlgorithm.codeName;
fsFullNameAlg = fsAlgorithm.fullName;
partitionsPath = [resultsPath,'DataPartitions',filesep];
RES = cell(iter,1);
disp([dataSet,'-',fsFullNameAlg]);



for it = 1:iter
    curInstances = [partitionsPath,dataSet,'_Training',num2str(it),'.arff'];
    
    partition= loadARFF(curInstances);
    % sample the data
    [curX, curY]=getNumericCodification(partition);
    % zero mean, unit norm
    curX = normData(curX, 1, 1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   Test Methods
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start = clock();
    disp([dataSet,'_iter: ',num2str(it)]);
    
    switch algorithmCode
        % SUPERVISED FEATURE SELECTION METHODS
        case 'blogreg'
            param.tol = 1;
            out = fsblogreg( curX, curY, param);
            out.fImp = true;
        case 'cfs'
            out = fsCFS(partition);
            out.fImp = true;
        case 'chi2'
            out = fsChiSquare( curX, curY );
        case 'fcbf'
            out = fsFCBF( curX, curY );
            out.fImp = true;
        case 'fisher'
            out = fsFisher( curX, curY );
        case 'gini'
            out = fsGini( curX, curY );
        case 'infogain'
            out = fsInfoGain( curX, curY );
        case 'kruskalwallis'
            out = fsKruskalWallis( curX, curY );
        case 'mrmr'
            out = fsMRMR( curX, curY );
        case 'relieff'
            numF = 200;
            out = fsReliefF_cv_sv( curX, curY, numF );
        case 'sbmlr'
            out = fsSBMLR( curX, curY );
            out.fImp = true;
        case 'ttest'
            out = fsTtest( curX, curY );
            
            % UNSUPERVISED FEATURE SELECTION METHODS
            %
            %####  FILTER ####
        case 'SPEC'
            W = constructRBF(curX);
            [wFeat, ~] = fsSpectrum(W, curX, 0);
            out.prf = 1;
            out.W = sort(wFeat*out.prf)';
        case 'laplacianScore'
            out = fsLaplacianScore( curX, 2);
        case 'svdEntropy'
            out = fsSVDEntropy(curX);
        case 'distanceEntropy'
            out = fsDistanceEntropy(curX);
        case 'fsfs'
            out = fsFsfs(curX);
            %KFST library
        case 'UFSACO'
            [out] = fsUfsaco(partition);
        case 'MGSACO'
            [out] = fsMgsaco(partition);
        case 'RRFSACO1'
            [out] = fsRrfsaco1(partition);
        case 'RRFSACO2'
            [out] = fsRrfsaco2(partition);
        case 'IRRFSACO1'
            [out] = fsIrrfsaco1(partition);
        case 'IRRFSACO2'
            [out] = fsIrrfsaco2(partition);
        case 'RRFS'
            [out] = fsRrfs(partition);
        case 'MutualCorrelation'
            [out] = fsMutualCorrelation(partition);
        case 'FsKmeans'
            [out] = fsFsKmeans(partition,0.5);
            
            %Our method
        case 'Usfsm'
            out = fsUsfsm(partition);
        case 'Ufsm'
            out = fsUfsm(partition);
        case 'Ufsme'
            out = fsUfsme(partition);
        case 'SUD'
            out = SUD(partition);
            %####  HYBRIDS ####
        case 'LSWNCHSR'
            [out] = fsLsWnchSR(partition,1);
        case 'LSWNCHBE'
            [out] = fsLsWnchBE(partition,1,3);
        case 'YunLiEtAl'
            [out] = fsYunLiEtAl(partition,0.5);
        case 'DashAndLiuFSAlgorithm'
            [out] = fsHybridDashAndLiuMethod(partition);
            
            %####  WRAPPER ####
            
            %#### OTHERS ####
        case 'SimpleRanking'
            [out] = fsSimpleRanking(partition);
            
            
        otherwise
            disp('Error code for feature selection algorithm!')
    end
    
    if(isfield(out, 'fImp'))
        if out.fImp == true
            RES{it}.fImp = true;
            RES{it}.fList = out.fList;
        end
    else
        RES{it}.W = out.W;
        RES{it}.fImp = false;
        if  out.prf == -1
            [~, RES{it}.fList ] = sort(out.W, 'ascend');
        elseif out.prf == 1
            [~, RES{it}.fList ] = sort(out.W, 'descend');
        else
            RES{it}.fList = out.fList;
        end
    end
    finalTime = clock() - start;
    RES{it}.runtime = clock2secs(finalTime);
    
    
end
fprintf('\n');

%% Save the results to a file (make sure it is algorithmCode-specific)
file = strcat(resultsPath,'FeatureSelection',filesep,dataSet,'_',algorithmCode,'_fs','_result', '.mat');
save(file, 'RES');
end