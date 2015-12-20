odResp = 0;
odResp = zeros(1,odors);
odorAuRoc = zeros(1,odors);
odorOnset = zeros(1,odors);
odorWidth = zeros(1,odors);
for idxCell = 1:size(respExc300,1)
    for idxOdor = 1:size(respExc300,2)
        if respExc300(idxCell,idxOdor) > 0 
            odResp(idxOdor)  = odResp(idxOdor) + 1;
            odorAuRoc(idxOdor) = odorAuRoc(idxOdor) + auRocExc300(idxCell, idxOdor);
        end
    end
end
%%
odResp = 0;
odResp = zeros(1,odors);
odorAuRoc = zeros(1,odors);
odorOnset = zeros(1,odors);
odorWidth = zeros(1,odors);
for idxCell = 1:size(respExc300,1)
    for idxOdor = 1:size(respExc300,2)
        if respExc300(idxCell,idxOdor) > 0 
            odResp(idxOdor)  = odResp(idxOdor) + 1;
            odorAuRoc(idxOdor) = odorAuRoc(idxOdor) + auRocExc300(idxCell, idxOdor);
            odorOnset(idxOdor) = odorOnset(idxOdor) + onsetExc300(idxCell, idxOdor);
            odorWidth(idxOdor) = odorWidth(idxOdor) + widthExc300(idxCell, idxOdor);
        end
    end
end
%%
allAurocs = 0.5*ones(cells,odors);
allAurocs1 = 0.5*ones(cells,odors);
allResponses300 = zeros(cells,odors);
allResponses1 = zeros(cells,odors);
idxCell = 0;
for idxExp = 1: length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            idxCell = idxCell + 1;
            for idxOdor = 1:odors
                allAurocs300(idxCell, idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                allAurocs1(idxCell, idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                allSpikes300(idxCell, idxOdor) = sum(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);
                allResponses300(idxCell, idxOdor) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);%-...
                    %mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                allResponses1(idxCell, idxOdor) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
            end
        end
    end
end

%%
condP = zeros(odors);
for idxCell = 1:size(respExc300,1)
    for idxOdor = 1:odors
        if respExc300(idxCell,idxOdor) > 0
            for idxO = 1:odors
                condP(idxOdor, idxO) =  condP(idxOdor, idxO) + respExc300(idxCell,idxO);
            end
        end
    end
end
    
allCells = repmat(sum(respExc300)',1,odors);
condP = condP./allCells;
figure; imagesc(condP); axis xy; axis tight

%%
figure; clim = [0 1]; imagesc(auRoc300, clim);  axis xy, colormap(brewermap([],'*RdBu')); axis tight;
hold on; edges = 0:0.1:1; histogram(ls300,edges, 'normalization', 'probability');

alspikesapcx = sum(allSpikes300apcx)./sum(allSpikes300apcx(:));
alspikesplcoa = sum(allSpikes300)./sum(allSpikes300(:));
for idxO=1:8
    AAA(idxO,1) = alspikesapcx(idxO);
    AAA(idxO,2) = alspikesplcoa(idxO);
end
figure; bar(AAA);

a = mean(allAurocs300apcx);
b = mean(allAurocs300);
for idxO=1:8
    BBB(idxO,1) = a(idxO);
    BBB(idxO,2) = b(idxO);
end
figure; bar(BBB)

k = 1;
for i = 1:size(A2,1)

    if mod(i,11) == 0
        k = k+1;
    end
    colori2(i,:) = colori(k,:);
end
figure; scatter3(score(:,1),score(:,2),score(:,3),50,colori2/255,'filled')
            