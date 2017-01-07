stimuli = [4     6     7     9    10     1     2     3     5     8];
esp = coaAA.esp;
tuningCurvesCoa = [];
dataAll = [];
idxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    resp = zeros(1,10);
                    idxS = 0;
                    for idxStimulus = stimuli
                        idxS = idxS + 1;
                        resp(idxS) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).DigitalResponse1000ms) == 1;
                    end
                    if sum(resp) > 0
                        idxCell = idxCell + 1;
                        idxO = 0;
                        for idxStimulus = stimuli
                            idxO = idxO + 1;
                            tuningCurvesCoa(idxCell,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).auROC1000ms;
%                             tuningCurvesCoa(idxCell,idxO) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponse1000ms) -...
%                                 mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsl1000ms);
                        end
                    end
                end
            end
        end
    end
end


stimuli = [4     6     7     9    10     1     2     3     5     8];
esp = pcxAA.esp;
tuningCurvesPcx = [];
dataAll = [];
idxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    resp = zeros(1,10);
                    idxS = 0;
                    for idxStimulus = stimuli
                        idxS = idxS + 1;
                        resp(idxS) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).DigitalResponse1000ms) == 1;
                    end
                    if sum(resp) > 0
                        idxCell = idxCell + 1;
                        idxO = 0;
                        for idxStimulus = stimuli
                            idxO = idxO + 1;
                            tuningCurvesPcx(idxCell,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxStimulus).auROC1000ms;
%                             tuningCurvesPcx(idxCell,idxO) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponse1000ms) -...
%                                 mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsl1000ms);
                        end
                    end
                end
            end
        end
    end
end


%%
stimuli = [4     6     7     9    10     1     2     3     5     8];
[auRocVCoa significant] = findAurocValence(coaAA.esp, stimuli, 1);
[auRocVPcx significant] = findAurocValence(pcxAA.esp, stimuli, 1);
%%
tuningCurvesCoa = [tuningCurvesCoa mean(weigthsValenceCoa_2,2)];
tuningCurvesCoa = sortrows(tuningCurvesCoa, size(tuningCurvesCoa,2));
tuningCurvesCoa(:,size(tuningCurvesCoa,2)) = [];




tuningCurvesPcx = [tuningCurvesPcx mean(weigthsValencePcx_2,2)];
tuningCurvesPcx = sortrows(tuningCurvesPcx, size(tuningCurvesPcx,2));
tuningCurvesPcx(:,size(tuningCurvesPcx,2)) = [];




clims = [0 1];
figure
imagesc(tuningCurvesCoa, clims)
colormap(brewermap([],'*RdBu'));
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
set(gcf,'Position',[482 107 259 694]);

clims = [0 1];
figure
imagesc(tuningCurvesPcx, clims)
colormap(brewermap([],'*RdBu'));
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
set(gcf,'Position',[482 107 259 694]);


%%
tuningCurvesCoa = [tuningCurvesCoa auRocVCoa'];
tuningCurvesCoa = sortrows(tuningCurvesCoa, size(tuningCurvesCoa,2));
tuningCurvesCoa(:,size(tuningCurvesCoa,2)) = [];

tuningCurvesPcx = [tuningCurvesPcx auRocVPcx'];
tuningCurvesPcx = sortrows(tuningCurvesPcx, size(tuningCurvesPcx,2));
tuningCurvesPcx(:,size(tuningCurvesPcx,2)) = [];


clims = [0 1];
figure
imagesc(tuningCurvesCoa, clims)
colormap(brewermap([],'*RdBu'));
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
set(gcf,'Position',[482 107 259 694]);

clims = [0 1];
figure
imagesc(tuningCurvesPcx, clims)
colormap(brewermap([],'*RdBu'));
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
set(gcf,'Position',[482 107 259 694]);

%%



clims = [0 1];
figure
imagesc(tuningCurvesCoa, clims)
colormap(brewermap([],'*RdBu'));
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
set(gcf,'Position',[482 107 259 694]);

clims = [0 1];
figure
imagesc(tuningCurvesPcx, clims)
colormap(brewermap([],'*RdBu'));
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
set(gcf,'Position',[482 107 259 694]);



