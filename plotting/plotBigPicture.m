%function plotBigPicture(timeWindow)

clear all

load('valveOnsets.mat')
load('adc1.mat')
load('parameters.mat');
load('units.mat');
load('dig1.mat');
load('breathing.mat');

movement = ADC;

[B, A] = butter(2, [10 40]/(fs/2), 'bandpass');
movement = filtfilt(B, A, movement);
movement = detrend(movement);
movement = abs(movement);


breathingFrequency = repmat(1,1,length(interInhalationDelay))./interInhalationDelay';

timAx = 0:1/20000:length(ADC)/20000;
timAx(end) = [];
idxSniffing = find(breathingFrequency>5);
timeSniffing = inhal_on(idxSniffing + 1);
timeSniffing_minus1 = inhal_on(idxSniffing);
timeSniffing = floor(timeSniffing*fs);
timeSniffing_minus1 = floor(timeSniffing_minus1*fs);

breathPattern = repmat(0,1,length(timAx));
for i = 1:length(timeSniffing_minus1)
    breathPattern(timeSniffing_minus1(i):timeSniffing(i)) = 0.5;
end
    


odorOn = Dig_inputs/2;



respiration = respiration';

time_InhalOn = floor(inhal_on *fs);
inhalTrace = -3 * repmat(1,1,length(timAx));
inhalTrace(time_InhalOn) = respiration(time_InhalOn);





figure; histogram(breathingFrequency, 'Normalization', 'probability')




%% 

from = 1;
to = 150;

from = floor(from * fs);
to = floor(to * fs);

figure; plot(timAx(from+1:to), movement(from+1:to))
% hold on
% plot(timAx(from+1:to), breathPattern(from+1:to), 'r')
hold on
plot(timAx(from+1:to), odorOn(from+1:to), 'g')
hold on 
scaledRespiration = respiration ./ max(abs(respiration));
fastRespirationBar = repmat(5,1,length(scaledRespiration));
fastRespirationBar(breathPattern == 0.5) = 0.2;
% fastRespiration = repmat(5,1,length(scaledRespiration));
% fastRespiration(breathPattern == 0.5) = scaledRespiration(breathPattern == 0.5);
% plot(timAx(from:to), scaledRespiration(from:to), 'k')
plot(timAx(from:to), fastRespirationBar(from:to), 'r', 'linewidth', 1)
% hold on
% plot(timAx(from:to), fastRespiration(from:to), 'r')
% hold on
% plot(timAx(from:to), inhalTrace(from:to), 'ko')

from = floor(from/fs);
to = floor(to/fs);
up = -0.01;
down = up - 0.01;
for s = 1:length(shank(1).spiketimesUnit)
    sua = [];
    sua1 = [];
    sua = shank(1).spiketimesUnit{s};
    sua1 = sua(sua>from & sua<to);
    
    for k = 1:length(sua1)
        line([sua1(k) sua1(k)], [down up], 'Color',[1 0 1])
        
    end
    up = down - 0.005;
    down = up - 0.01;    
end
for s = 1:length(shank(2).spiketimesUnit)
    sua = [];
    sua2 = [];
    sua = shank(2).spiketimesUnit{s};
    sua2 = sua(sua>from & sua<to);
    
    for k = 1:length(sua2)
        line([sua2(k) sua2(k)], [down up], 'Color',[0 0 1])
        
    end
    up = down - 0.005;
    down = up - 0.01 ; 
end
for s = 1:length(shank(3).spiketimesUnit)
    sua = [];
    sua3 = [];
    sua = shank(3).spiketimesUnit{s};
    sua3 = sua(sua>from & sua<to);
    
    for k = 1:length(sua3)
        line([sua3(k) sua3(k)], [down up], 'Color',[1 0 0])
        
    end
    up = down - 0.005;
    down = up - 0.01;  
end
for s = 1:length(shank(4).spiketimesUnit)
    sua = [];
    sua4 = [];
    sua = shank(4).spiketimesUnit{s};
    sua4 = sua(sua>from & sua<to);
    
    for k = 1:length(sua4)
        line([sua4(k) sua4(k)], [down up], 'Color',[0 1 0])
        
    end
    up = down - 0.005;
    down = up - 0.01;  
end

xlim([from to])
ylim([-0.6 0.5])
