%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Feature Selection Experimenter (Main script)
% Institution INAOE
% Author: Saul Solorio Fdez.
% Version 1.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% clear workspace 
clc;
clear all;

%% Load experiment's packages and configurations 
load_myFSpackage;
experimentConf = loadExperimentConf;

%% Run experiment 
%[ok]=runExperimentOnDatasets(selectorsCell,datasetsCell,experimentName,numOfFeaturesACCrankingEvaluation,resultsPath)
[ok] = runExperimentOnDatasets(experimentConf);
%%
disp('Experiment finished');
