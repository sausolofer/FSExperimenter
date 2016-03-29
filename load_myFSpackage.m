curPath = pwd;

%% load extenal jar libraries, and common interfacing methods.
path(path, [curPath, filesep, 'libs', filesep, 'otherLibs']);
path(path, [curPath, filesep, 'libs', filesep, 'otherLibs', filesep, 'weka']);
loadWeka(['libs', filesep, 'otherLibs' filesep 'weka']);
path(path, [curPath, filesep, 'libs', filesep, 'otherLibs', filesep, 'KFST']);
javaaddpath([curPath,filesep,'libs',filesep,'otherLibs',filesep,'KFST',filesep,'KFST-1.0.jar']);


%% other java paths
path(path, [curPath, filesep, 'libs', filesep, 'myLibs']);
javaaddpath([curPath,filesep,'libs',filesep,'myLibs',filesep,'evaluador2.jar']);

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
path(path,[curPath, filesep, 'scripts' filesep 'preprocessor']);

%% process

%% evaluator
path(path,[curPath, filesep, 'scripts', filesep, 'evaluator', filesep, 'fsevaluator']);

%% My scripts
path(path,[curPath, filesep, 'scripts', filesep,'myScripts']);
%path(path,[curPath filesep 'myScripts' filesep 'process']);

%% ability to run experiments.
path(path, [curPath, filesep, 'scripts', filesep ...
    'result_statistic', filesep, 'supervised', filesep]);

clear curPath;