
ante = 500; %baseline length in ms
start = 2 * 1000;
window = 1000;
dopo = 0;
n_trials = 5; %n_trials;
odor_list = {'tmt3', 'dmt3', 'mmt3', 'iba3', 'iaa3',...
             'hed3', 'but3', 'tmt1', 'dmt1', 'mmt1',...
             'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};
ncyclesNoWarp = [];
ncycles = [];
 

cycleLength = 360;

ii = 1;
idxOdor = 1;
for i=1:n_trials * odors
    l=0;
    for idxExp = 1:length(List)
        for idxShank = 1:4
            for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
                l = l + 1;
                ncycles(1).A(i).data(l,:) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixWarp(ii,360*10 + 1:360*11);
                ncycles(2).A(i).data(l,:) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixWarp(ii,360*11 + 1:360*12);
                ncycles(3).A(i).data(l,:) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixWarp(ii,360*13 + 1:360*14);
                ncycles(4).A(i).data(l,:) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixWarp(ii,360*15 + 1:360*16);
                ncycles(5).A(i).data(l,:) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixWarp(ii,360*17 + 1:360*18);
                ncycles(6).A(i).data(l,:) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixWarp(ii,360*8 + 1:360*18);
                ncycles(7).A(i).data(l,:) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixWarp(ii,360*10 + 1:360*14);
                ncyclesNoWarp(1).A(i).data(l,:) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp(ii,15000 + 1:16000);
                ncyclesNoWarp(2).A(i).data(l,:) =  exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp(ii,14500 + 1:17000);  
            end
        end
    end
%     label = sprintf('reach%d', k);
%     D(i).condition = label;
    ncycles(1).A(i).condition = odor_list{idxOdor};
    ncycles(2).A(i).condition = odor_list{idxOdor};
    ncycles(3).A(i).condition = odor_list{idxOdor};
    ncycles(4).A(i).condition = odor_list{idxOdor};
    ncycles(5).A(i).condition = odor_list{idxOdor};
    ncycles(6).A(i).condition = odor_list{idxOdor};
    ncycles(7).A(i).condition = odor_list{idxOdor};
    ncyclesNoWarp(1).A(i).condition = odor_list{idxOdor};
    ncyclesNoWarp(2).A(i).condition = odor_list{idxOdor};
    ii = ii + 1;
    if ii > n_trials
        ii = 1;
        idxOdor = idxOdor + 1;
    end
%     ncycles(1).A(i).epochStarts = [360];
%     ncycles(2).A(i).epochStarts = [360]; 
%     ncycles(3).A(i).epochStarts = [360]; 
%     ncycles(4).A(i).epochStarts = [360]; 
%     ncycles(5).A(i).epochStarts = [360]; 
%     ncycles(6).A(i).epochStarts = [360*2]; 
%     ncycles(1).A(i).epochColors = [240,59,32]/255;
%     ncycles(2).A(i).epochColors = [240,59,32]/255; 
%     ncycles(3).A(i).epochColors = [240,59,32]/255; 
%     ncycles(4).A(i).epochColors = [240,59,32]/255;
%     ncycles(5).A(i).epochColors = [240,59,32]/255; 
%     ncycles(6).A(i).epochColors = [240,59,32; 252,78,42; 254,178,76]/255; 
end

save('dataHigh.mat', 'ncycles', 'ncyclesNoWarp')