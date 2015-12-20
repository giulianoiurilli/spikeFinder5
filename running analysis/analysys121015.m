%%
%odorToUse = [2 3 4 5;...
            7 8 9 10;...
            12 13 14 15];
whichOdors = 1:7;
%whichOdors = odorToUse(:,4)';

plcoaColors = [254,240,217;...
253,204,138;...
252,141,89;...
215,48,31]/255;

apcxColors = [247,247,247;...
204,204,204;...
150,150,150;...
82,82,82]/255;

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
            idxOdor = whichOdors(idxOdorApp(idxO));
            App = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
            psthExc(idxCOP,:) = slidePSTH(App,100,5);
        end
    end
end


times = linspace(0,size(App,2),size(psthExc,2)) - size(App,2)/2;

hold on; plot(times,mean(psthExc), 'color', apcxColors(4,:))
xlim([-1000 5000])