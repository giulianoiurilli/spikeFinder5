function selectivity = selectivityIndexes(esp, odorsRearranged)

% esp = pcx15.esp;
% odorsRearranged = 1:15;
n_odors = length(odorsRearranged);
%%
c300 = 0;
c1000 = 0;
c = 0;
t = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            t = t + 1;
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                app300 = nan(n_odors,1);
                app1000 = nan(n_odors,1);
                for idxOdor = odorsRearranged
                    app300(idxOdor) = abs(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms) == 1;
                    app1000(idxOdor) = abs(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                end
                appT300 = sum(app300);
                appT1000 = sum(app1000);
                if appT300 > 0 %&& esp(idxExp).shankNowarp(idxShank).cell(idxUnit).reliabilityPvalue < 0.05
                    c300 = c300 + 1;
                end
                if appT1000 > 0 %&& esp(idxExp).shankNowarp(idxShank).cell(idxUnit).reliabilityPvalue < 0.05
                    c1000 = c1000 + 1;
                end
            end
        end
    end
end

%%
selectivity.info300 = nan(c300,1);
selectivity.info1000 = nan(c1000,1);
selectivity.ls300 = nan(c300,1);
selectivity.ls1000 = nan(c1000,1);
selectivity.responsivenessExc300ms = zeros(c,n_odors);
selectivity.responsivenessInh300ms = zeros(c,n_odors);
selectivity.responsivenessExc1000ms = zeros(c,n_odors);
selectivity.responsivenessInh1000ms = zeros(c,n_odors);
selectivity.info300Gradient = nan(length(esp),4);
selectivity.info1000Gradient = nan(length(esp),4);
selectivity.ls300Gradient = nan(length(esp),4);
selectivity.ls1000Gradient = nan(length(esp),4);
selectivity.excNeuron300 = nan(c,1);
selectivity.inhNeuron300 = nan(c,1);
selectivity.excNeuron1000 = nan(c,1);
selectivity.inhNeuron1000 = nan(c,1);
selectivity.exc300Gradient = nan(length(esp),4);
selectivity.inh300Gradient = nan(length(esp),4);
selectivity.exc1000Gradient = nan(length(esp),4);
selectivity.inh1000Gradient = nan(length(esp),4);
selectivity.cellLog300 = nan(c300,3);
selectivity.cellLog1000 = nan(c1000,3);

c = 0;
c300 = 0;
c1000 = 0;
for idxExp =  1:length(esp)
    info300Shank = nan(1,4);
    info1000Shank = nan(1,4);
    ls300Shank= nan(1,4);
    ls1000Shank = nan(1,4);
    excNeuron300Shank = nan(1,4);
    inhNeuron300Shank = nan(1,4);
    excNeuron1000Shank = nan(1,4);
    inhNeuron1000Shank = nan(1,4);
    for idxShank = 1:4
        appLs300 = [];
        appLs1000 = [];
        appI300 = [];
        appI1000 = [];
        appLsAuroc300 = [];
        appLsAuroc1000 = [];
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            app5 = zeros(1,n_odors);
            app6 = zeros(1,n_odors);
            app7 = zeros(1,n_odors);
            app8 = zeros(1,n_odors);
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                app300 = nan(n_odors,1);
                app1000 = nan(n_odors,1);
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app300(idxOdor) = abs(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms) == 1;
                    app1000(idxOdor) = abs(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                    selectivity.responsivenessExc300ms(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                    selectivity.responsivenessInh300ms(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
                    selectivity.responsivenessExc1000ms(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    selectivity.responsivenessInh1000ms(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == -1;
                end
                appT300 = sum(app300);
                appT1000 = sum(app1000);
                if appT300 > 0 %&& esp(idxExp).shankNowarp(idxShank).cell(idxUnit).reliabilityPvalue < 0.05
                    c300 = c300 + 1;
                    appI300 = [appI300 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I300ms];
                    selectivity.info300(c300) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I300ms;
                    appLs300 = [appLs300 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls300ms];
                    selectivity.ls300(c300) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls300ms;
                    appLsAuroc300 = [appLsAuroc300 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).lsAuroc300ms];
                    selectivity.lsAuroc300(c300) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).lsAuroc300ms;
                    selectivity.LI300(c300) = sum(selectivity.responsivenessExc300ms(c,:));
                    selectivity.cellLog300(c300,:) = [idxExp idxShank idxUnit];
                end
                if appT1000 > 0 %&& esp(idxExp).shankNowarp(idxShank).cell(idxUnit).reliabilityPvalue < 0.05
                    c1000 = c1000 + 1;
                    appI1000 = [appI1000 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s];
                    selectivity.info1000(c1000) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s;
                    appLs1000 = [appLs1000 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls1s];
                    selectivity.ls1000(c1000) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls1s;
                    appLsAuroc1000 = [appLsAuroc1000 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).lsAuroc1s];
                    selectivity.lsAuroc1000(c1000) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).lsAuroc1s;
                    selectivity.LI1000(c1000) = sum(selectivity.responsivenessExc1000ms(c,:));
                    selectivity.cellLog1000(c1000,:) = [idxExp idxShank idxUnit];
                end
           excOdors300  = sum(selectivity.responsivenessExc300ms(c,:));
           inhOdors300 = sum(selectivity.responsivenessInh300ms(c,:));
           excOdors1000 = sum(selectivity.responsivenessExc1000ms(c,:));
           inhOdors1000 = sum(selectivity.responsivenessInh1000ms(c,:));
           app5 = excOdors300>0;
           app6 = inhOdors300>0;
           app7 = excOdors1000>0;
           app8 = inhOdors1000>0;
           selectivity.excNeuron300(c) = app5;
           selectivity.inhNeuron300(c) = app6;
           selectivity.excNeuron1000(c) = app7;
           selectivity.inhNeuron1000(c) = app8;
           end
        end
        info300Shank(idxShank) = mean(appI300);
        info1000Shank(idxShank) = mean(appI1000);
        ls300Shank(idxShank) = mean(appLs300);
        ls1000Shank(idxShank) = mean(appLs1000);
        excNeuron300Shank(idxShank) = sum(app5) / numel(app5);
        inhNeuron300Shank(idxShank) = sum(app6) / numel(app6);
        excNeuron1000Shank(idxShank) = sum(app7) / numel(app7);
        inhNeuron1000Shank(idxShank) = sum(app8) / numel(app8);
    end
    if info300Shank(1) > 0
        selectivity.info300Gradient(idxExp,:) = info300Shank;%/ info300Shank(1);
    else
        selectivity.info300Gradient(idxExp,:) = info300Shank;% / min(info300Shank);
    end
    if info1000Shank(1) > 0
        selectivity.info1000Gradient(idxExp,:) = info1000Shank;% / info1000Shank(1);
    else
        selectivity.info1000Gradient(idxExp,:) = info1000Shank;% / min(info1000Shank);
    end
    if ls300Shank(1) > 0
        selectivity.ls300Gradient(idxExp,:) = ls300Shank;% / ls300Shank(1);
    else
        selectivity.ls300Gradient(idxExp,:) = ls300Shank;% / min(ls300Shank);
    end
    if ls1000Shank(1) > 0
        selectivity.ls1000Gradient(idxExp,:) = ls1000Shank;% / ls1000Shank(1);
    else
        selectivity.ls1000Gradient(idxExp,:) = ls1000Shank;% / min(ls1000Shank);
    end
    
    if excNeuron300Shank(1) > 0
        selectivity.exc300Gradient(idxExp,:) = inhNeuron300Shank;% / excNeuron300Shank(1);
    else
        selectivity.exc300Gradient(idxExp,:) = inhNeuron300Shank;% / min(inhNeuron300Shank);
    end
    if inhNeuron300Shank(1) > 0
        selectivity.inh300Gradient(idxExp,:) = inhNeuron300Shank;% / inhNeuron300Shank(1);
    else
        selectivity.inh300Gradient(idxExp,:) = inhNeuron300Shank;% / min(inhNeuron300Shank);
    end
    if excNeuron1000Shank(1) > 0
        selectivity.exc1000Gradient(idxExp,:) = excNeuron1000Shank;% / excNeuron1000Shank(1);
    else
        selectivity.exc1000Gradient(idxExp,:) = excNeuron1000Shank;% / min(excNeuron1000Shank);
    end
    if inhNeuron1000Shank(1) > 0
        selectivity.inh1000Gradient(idxExp,:) = inhNeuron1000Shank;% / inhNeuron1000Shank(1);
    else
        selectivity.inh1000Gradient(idxExp,:) = inhNeuron1000Shank;% / min(inhNeuron1000Shank);
    end
end

selectivity.numberExcNeurons300 = sum(selectivity.responsivenessExc300ms,2);
selectivity.numberInhNeurons300 = sum(selectivity.responsivenessInh300ms,2);
selectivity.numberExcNeurons1000 = sum(selectivity.responsivenessExc1000ms,2);
selectivity.numberInhNeurons1000 = sum(selectivity.responsivenessInh1000ms,2);

