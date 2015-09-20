close all;
clear all;


extractDataFromIntan_multi1;

load('tetrodes.mat');

quick_OEP_arrangeFiles_Buzsaki32_polytrode;
%arrangeFiles_buzsaki32;
%arrangeFiles;
disp('files arranged!')
filterTraces(tetrodes);
disp('filterTraces done!')
reReference(tetrodes);
disp('reReference done!')
prepare_for_Klein(tetrodes);