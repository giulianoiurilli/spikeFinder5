%%
fileToSave = 'pcx_AAmix_2_2.mat';
load('parameters.mat');
startingFolder = pwd;
odorsRearranged = 1:15; 
odors = length(odorsRearranged);

%%

for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                                    meanSpikeCount = zeros(1,odors);
                    varSpikeCount = zeros(1,odors);
                for idxOdor = odorsRearranged
                    meanSpikeCount(idxOdor) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                    varSpikeCount(idxOdor) = var(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                end
                fun = @(x,meanSpikeCount)meanSpikeCount + x(1)*meanSpikeCount.^2;
                x0 = [0,0];
                x = lsqcurvefit(fun,x0,meanSpikeCount,varSpikeCount);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).gVar = x(1);
            end
        end
    end
end

cd(startingFolder)
clearvars -except esp fileToSave 
save(fileToSave, 'esp', '-append')
%%
% odorsRearranged = 1:15;
% odors = length(odorsRearranged);
% meanSpikeCount = zeros(1,odors);
% varSpikeCount = zeros(1,odors);
% for idxOdor = 1:15
%     meanSpikeCount(idxOdor) = mean(esp(1).shankNowarp(1).cell(5).odor(idxOdor).AnalogicResponse1000ms);
%     varSpikeCount(idxOdor) = var(esp(1).shankNowarp(1).cell(5).odor(idxOdor).AnalogicResponse1000ms);
% end
% figure
% plot(meanSpikeCount, varSpikeCount, 'ok')