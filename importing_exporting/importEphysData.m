tic
extractDataFromIntan_multi2;
disp('Importing done')
toc
%%
folder = pwd;
options.probeType = 2;
options.singleOutputFile = 1;
options.formatOutputFile = 2;
options.commonReference = 2;
options.filterOn = 0;
samplingRate = 20000;

makeFileForSpikeSorting(folder, options, samplingRate);