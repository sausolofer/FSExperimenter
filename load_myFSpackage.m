curPath = pwd;

%% load weka jar, and common interfacing methods.
path(path, [curPath, filesep, 'externalLibsAndScripts', filesep, 'lib']);
path(path, [curPath, filesep, 'externalLibsAndScripts', filesep, 'lib', filesep, 'weka']);
loadWeka(['externalLibsAndScripts', filesep, 'lib' filesep 'weka']);

%% other java paths
path(path, [curPath, filesep, 'externalLibsAndScripts', filesep, 'myLibs']);
javaaddpath([curPath,filesep,'ExternalLibsAndScripts',filesep,'myLibs',filesep,'PPLCbeta.jar']);
javaaddpath([curPath,filesep,'ExternalLibsAndScripts',filesep,'myLibs',filesep,'evaluador2.jar']);
javaaddpath([curPath,filesep,'ExternalLibsAndScripts',filesep,'myLibs',filesep,'PPLCWekaBridge.jar']);

%% feature selection algorithms
%Supervised
path(path,[curPath filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_blogreg']);
path(path,[curPath filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_cfs']);
path(path,[curPath filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_chisquare']);
path(path,[curPath filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_fcbf']);
path(path,[curPath filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_fisher_score']);
path(path,[curPath filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_gini_index']);
path(path,[curPath filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_information_gain']);
path(path,[curPath filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_kruskalwallis']);
path(path,[curPath filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_mrmr']);
path(path,[curPath filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_relieff']);
path(path,[curPath filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_sbmlr']);
path(path,[curPath filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_ttest']);
%unsupervised
path(path,[curPath filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_spec']);
path(path,[curPath filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_laplacian_score']);
path(path,[curPath filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_svd_entropy']);
path(path,[curPath filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_distance_entropy']);

%% predictors
path(path,[curPath filesep 'classifiers' filesep 'knn']);
path(path,[curPath filesep 'classifiers' filesep 'svm']);
path(path,[curPath filesep 'classifiers' filesep 'j48']);
path(path,[curPath filesep 'classifiers' filesep 'bayes']);
path(path,[curPath filesep 'clusters' filesep 'kmeans']);

%% data preprocessors
path(path,[curPath, filesep, 'preprocessor']);


%% evaluator
path(path,[curPath, filesep, 'externalLibsAndScripts', filesep, 'evaluator', filesep, 'fsevaluator']);

%% My scripts
path(path,[curPath filesep 'myScripts']);
%path(path,[curPath filesep 'myScripts' filesep 'process']);

%% ability to run experiments.
path(path, [curPath, filesep, 'externalLibsAndScripts', filesep ...
    'result_statistic', filesep, 'supervised', filesep]);

clear curPath;