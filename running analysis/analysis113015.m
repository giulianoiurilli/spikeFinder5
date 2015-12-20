whichOdors = [5,10,15];
psthExc = [];
% appRespExc = respExc1(infoExc1>0.1,:);
% appCellLog = cellLogExc1(infoExc1>0.1,:);
appRespExc = respExc300(:,whichOdors);
appCellLog = cellLogExc300;
idxCOP = 0;
for idxU = 1:size(appRespExc,1)
    idxExp = appCellLog(idxU,1);
    idxShank = appCellLog(idxU,2);
    idxUnit = appCellLog(idxU,3);
    if sum(appRespExc(idxU,:),2) > 0
        for idxO = 1:sum(appRespExc(idxU,:),2)
            idxOdor = [];
            idxOdorApp = [];
            idxCOP = idxCOP + 1;
            idxOdorApp = find(appRespExc(idxU,:) == 1);
            idxOdor = whichOdors(idxOdorApp);
            App = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
            psthExc(idxCOP,:) = slidePSTH(App,50,5);
        end
    end
end

times = linspace(0,size(App,2),size(psthExc,2)) - size(App,2)/2;


%%
odorToUse = [2 3 4 5;...
            7 8 9 10;...
            12 13 14 15];
clims = [0 1];
figure
aggiungi = 0;
set(gcf,'Color','w')
set(gcf,'Position',[208 22 722 1015]);
for idxUse = 1:3
    appResp = [];
    %appResp = auRocExc300(:,odorToUse(idxUse,:));
    appResp = auRoc300(:,odorToUse(idxUse,:));
    appResponsive = [];
    %appResponsive = respExc300(:,odorToUse(idxUse,:));
    appResponsive = resp300(:,odorToUse(idxUse,:));
    appResponsive = sum(appResponsive,2);
    appResp = appResp(appResponsive>0,:);
    ccCoeff = [];
    for idxU = 1:size(appResp,1)
        ccCoeff(idxU) = corr([1:4]', appResp(idxU,:)');
    end
    appResp = [appResp ccCoeff'];
    appResp = sortrows(appResp, size(appResp,2));
    appResp(:,size(appResp,2)) = [];
    subplot(7,3,idxUse)
    imagesc(appResp, clims), axis xy, colormap(brewermap([],'*RdBu')); axis tight; 
    set(gca,'YTick',[])
    %set(gca,'YColor','w')
    set(gca,'XTick',[])
    set(gca,'XColor','w')
    set(gca,'Box','off');
end
aggiungi = aggiungi + 3;
for idxUse = 1:3
    appResp = [];
    %appResp = auRocExc300(:,odorToUse(idxUse,:));
    appResp = auRoc300(:,odorToUse(idxUse,:));
    appResponsive = [];
    %appResponsive = respExc300(:,odorToUse(idxUse,:));
    appResponsive = resp300(:,odorToUse(idxUse,:));
    appResponsive = sum(appResponsive,2);
    appResp = appResp(appResponsive>0,:);
    appRespMean = mean(appResp);
    appRespSem = std(appResp)/sqrt(size(appResp,1));
    subplot(7,3,idxUse+aggiungi)
    errorbar(appRespMean, appRespSem, 'bx')
    axis tight;
    set(gca,'YTick',[])
    %set(gca,'YColor','w')
    set(gca,'XTick',[])
    set(gca,'Box','off');
end 
aggiungi = aggiungi + 3;       
for idxUse = 1:3
    appResp = [];
    %appResp = responsesExc300MinusMean(:,odorToUse(idxUse,:));
    appResp = responses300MinusMean(:,odorToUse(idxUse,:));
    appResponsive = [];
    %appResponsive = respExc300(:,odorToUse(idxUse,:));
    appResponsive = resp300(:,odorToUse(idxUse,:));
    appResponsive = sum(appResponsive,2);
    appResp = appResp(appResponsive>0,:);
    appRespMean = mean(appResp);
    appRespSem = std(appResp)/sqrt(size(appResp,1));
    subplot(7,3,idxUse+aggiungi)
    errorbar(appRespMean, appRespSem, 'rx')
    axis tight;
        axis tight;
    set(gca,'YTick',[])
    %set(gca,'YColor','w')
    set(gca,'XTick',[])
    set(gca,'Box','off');
end   
aggiungi = aggiungi + 3;       
for idxUse = 1:3
    appResp = [];
    appResp = onsetExc300(:,odorToUse(idxUse,:));
    appResponsive = [];
    appResponsive = respExc300(:,odorToUse(idxUse,:));
    %appResponsive = resp300(:,odorToUse(idxUse,:));
    appResponsive = sum(appResponsive,2);
    appResp = appResp(appResponsive>0,:);
    appRespMean = nanmean(appResp);
    appRespSem = nanstd(appResp)/sqrt(size(appResp,1));
    subplot(7,3,idxUse+aggiungi)
    errorbar(appRespMean, appRespSem, 'kx')
    axis tight;
        axis tight;
    set(gca,'YTick',[])
    %set(gca,'YColor','w')
    set(gca,'XTick',[])
    set(gca,'Box','off');
end 
aggiungi = aggiungi + 3;       
for idxUse = 1:3
    appResp = [];
    appResp = widthExc300(:,odorToUse(idxUse,:));
    appResponsive = [];
    appResponsive = respExc300(:,odorToUse(idxUse,:));
    %appResponsive = resp300(:,odorToUse(idxUse,:));
    appResponsive = sum(appResponsive,2);
    appResp = appResp(appResponsive>0,:);
    appRespMean = nanmean(appResp);
    appRespSem = nanstd(appResp)/sqrt(size(appResp,1));
    subplot(7,3,idxUse+aggiungi)
    errorbar(appRespMean, appRespSem, 'gx')
    axis tight;
        axis tight;
    set(gca,'YTick',[])
    %set(gca,'YColor','w')
    set(gca,'XTick',[])
    set(gca,'Box','off');
end 
aggiungi = aggiungi + 3;       
for idxUse = 1:3
    appResp = [];
    %appResp = responsesExc300(:,odorToUse(idxUse,:));
    appResp = responses300(:,odorToUse(idxUse,:));
    appResponsive = [];
    %appResponsive = respExc300(:,odorToUse(idxUse,:));
    appResponsive = resp300(:,odorToUse(idxUse,:));
    appResponsive = sum(appResponsive,2);
    appResp = appResp(appResponsive>0,:);
    appRespMean = sum(appResp);
    subplot(7,3,idxUse+aggiungi)
    h = area(appRespMean);
    h.FaceColor = [203,24,29]/255;
    axis tight;
        axis tight;
    set(gca,'YTick',[])
    %set(gca,'YColor','w')
    set(gca,'XTick',[])
    set(gca,'Box','off');
end 
aggiungi = aggiungi + 3;       
for idxUse = 1:3
    appResponsive = [];
    %appResponsive = respExc300(:,odorToUse(idxUse,:));
    appResponsive = resp300(:,odorToUse(idxUse,:));
    appResponsive1 = sum(appResponsive,2);
    appResponsive(appResponsive1==0,:) = [];
    pResponsive = sum(appResponsive)./ cells;
    subplot(7,3,idxUse+aggiungi)
    h = bar(pResponsive);
    h.FaceColor = [82,82,82]/255;
    axis tight;
        axis tight;
    set(gca,'YTick',[])
    %set(gca,'YColor','w')
    set(gca,'Box','off');
end 















