close all


fs = 20000;
thres = 0.5;
delay = 0.05;
max_delay = 0.6;
odors = 15;
n_trials = 10;
pre = 15;
pre1 = 3;
post = 15;
post1 = 5;
response_window = 0.3;%0.2
pre_bsl = response_window;
bin_size = 0.1;
edgesPSTH = -pre:bin_size:post;
sigma = 0.05;
min_firingResp = 1; %Hz
shank_lfp = [0 6 28 30];
best = 100;
preInhalations = 10;
postInhalations = 10;
bslCycles = 2;
rspCycles = 2;
averageCycleMs = 320;
radPerMs = round(2*pi/averageCycleMs, 2);
sigmaDeg = 10; %sigma in degrees for spike density
cycleLength = round(2*pi, 4);
cycleLengthDeg = 360;
edgesSpikeMatrixRad = 0:2*pi/360:(preInhalations+postInhalations)*2*pi;

save('parameters.mat', 'fs', 'thres', 'delay', 'max_delay', 'odors', 'pre', 'pre_bsl', 'post', 'response_window', 'bin_size',...
     'edgesPSTH', 'sigma', 'shank_lfp', 'min_firingResp', 'best', 'n_trials',...
     'preInhalations', 'postInhalations', 'bslCycles', 'rspCycles', 'averageCycleMs', 'radPerMs', 'sigmaDeg', 'cycleLength', 'cycleLengthDeg', 'edgesSpikeMatrixRad',...
     'pre1', 'post1')
