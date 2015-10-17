response = [];
for idxExperiment = 1 : length(List)
    cartella = List{idxExperiment};
    %     folder1 = cartella(end-11:end-6)
    %     folder2 = cartella(end-4:end)
    %     cartella = [];
    %     cartella = sprintf('/Volumes/Neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/aPCx/awake/%s/%s', folder1, folder2);
    cd(cartella)
    disp(cartella)
    fatti = sprintf('%d out of %d done.', idxExperiment, length(List));
    disp(fatti)
    
    load('unitsNowarp')
    for idxShank = 1:4
        for idxUnit = 1:length(shankNowarp(idxShank).cell)
            for idxOdor = 1:odors
                response = [response; mean(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(:,pre*1000 - 1000 : pre*1000 + 1 + 1000))];
            end
        end
    end
end
xtime = -1:1/1000:1;
zresponse = zscore(response');
figure
avgResponse = mean(response);
avgResponse(end) = [];
plot(xtime,avgResponse)
pc1 = prctile(response, [5, 95]);
pc1(:,end) = [];
figure;
shadedErrorBar(xtime, avgResponse, pc1)

figure
zresponse = zresponse';
zresponseavg = mean(zresponse);
zresponseavg(end) = [];
plot(xtime,zresponseavg)