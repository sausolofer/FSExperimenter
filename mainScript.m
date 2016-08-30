%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Feature Selection Experimenter (Main script)
% Institution INAOE
% Author: Saul Solorio Fdez.
% Version 1.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% clear workspace 
clc;
clearvars;
%clear all;

%% Load experimenter's packages and configurations 
load_myFSpackage;
experimentConf = loadExperimentConf;

%% Run experiment 
[ok] = runGlobalExperiment(experimentConf);
%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('Experiment finished');
