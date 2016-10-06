tic
extractDataFromIntan_multi2;
disp('Importing done')
toc
%%
folder = pwd;
options.probeType = 2;
options.singleOutputFile = 0;
options.formatOutputFile = 2;
samplingRate = 20000;

makeFileForSpikeSorting(folder, options, samplingRate);
