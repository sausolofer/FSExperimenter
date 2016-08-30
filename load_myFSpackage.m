%% Load packages and resources

%% Current path
curPath = pwd;

%% load extenal jar libraries, and common interfacing methods.
path(path, [curPath, filesep, 'libs', filesep, 'otherLibs']);
path(path, [curPath, filesep, 'libs', filesep, 'otherLibs', filesep, 'weka']);
loadWeka(['libs', filesep, 'otherLibs' filesep 'weka']);
javaaddpath([curPath,filesep,'libs',filesep,'otherLibs',filesep,'KFST-1.0.jar']);

%% other java paths (my libs)
path(path, [curPath, filesep, 'libs', filesep, 'myLibs']);
javaaddpath([curPath,filesep,'libs',filesep,'myLibs',filesep,'fsmdl.jar']);

%% scripts' subdirectories
path(path,[curPath, filesep, 'scripts', filesep,'core']);
path(path,[curPath, filesep, 'scripts', filesep,'conf']);
path(path,[curPath, filesep, 'scripts', filesep,'utils'])
path(path,[curPath, filesep, 'scripts', filesep,'validationMeasures'])
path(path,[curPath filesep 'scripts' filesep 'wekaInterface']);
path(path,[curPath filesep 'scripts' filesep 'preprocess']);
path(path,[curPath filesep 'scripts' filesep 'plotting']);

%% feature selection algorithms
%Supervised
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_blogreg']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_cfs']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_chisquare']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_fcbf']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_fisher_score']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_gini_index']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_information_gain']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_kruskalwallis']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_mrmr']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_relieff']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_sbmlr']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'sfsAlgorithms' filesep 'fs_sup_ttest']);
%Unsupervised
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_spec']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_laplacian_score']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_svd_entropy']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_distance_entropy']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_fsfs']);
%KFST library algorithms
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_ufsaco']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_mgsaco']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_rrfsaco']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_irrfsaco']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_mutual_correlation']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_rrfs']);

path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_dash_and_liu']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_yun_li_et_al']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_fs_kmeans']);
%Our methods

path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_simple_ranking']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_ls_wnch']);

%For mixed data
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_sud']);
path(path,[curPath filesep 'scripts' filesep 'fsAlgorithms' filesep 'ufsAlgorithms' filesep 'fs_uns_ufsm']);

%% Learning algorithms
path(path,[curPath filesep 'scripts' filesep 'learningAlgorithms' filesep 'classifiers' filesep 'knn']);
path(path,[curPath filesep 'scripts' filesep 'learningAlgorithms' filesep 'classifiers' filesep 'svm']);
path(path,[curPath filesep 'scripts' filesep 'learningAlgorithms' filesep 'classifiers' filesep 'wekaClassifiers']);
path(path,[curPath filesep 'scripts' filesep 'learningAlgorithms' filesep 'clusteringAlgorithms' filesep 'kmeans']);

clear curPath;