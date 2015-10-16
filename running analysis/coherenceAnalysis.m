useOdor = 5;
idxTrial = 5;
idxPair = 3;
wname  = 'cmor1-1';
scales = 1:512;
ntw = 2;
%t  = linspace(0,1,2048);
% x = sin(16*pi*t)+0.25*randn(size(t));
% y = sin(16*pi*t+pi/4)+0.25*randn(size(t));

A(1,:) = zscore(-downsample(squeeze(breath(idxTrial,from*20000:to*20000,useOdor)),20));
A(2,:) = zscore((squeeze(lfpTrials(idxTrial,from*1000:to*1000,useOdor))));
A(3,:) = zscore(spikesPSTHs{idxOdor}(idxPair,from*1000:to*1000,idxTrial));
x = A(2,:);
y = A(3,:);

wcoher(x,y,scales,wname,'ntw',ntw,'plot','all');