
%% clear workspace 
clc;
clear all;
load_fspackage;

disp('making partitions');
buildStratyfiedPartitionsOnDataSets('C:\Users\SSF\Dropbox\Personal\Articulo_congreso\codigos\ExperimentsCode\dataSets\matDatasets\',10)
disp('finished');