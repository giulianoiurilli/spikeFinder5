sdfTMTCoa = [];
sdfRoseCoa = [];
sdfCRECoa = [];
sdfTMTPcx = [];
sdfRosePcx = [];
sdfCREPcx = [];

rspExcTMT1000Coa = [];
rspExcTMT1000Pcx = [];
rspExcRose1000Coa = [];
rspExcRose1000Pcx = [];
rspExcCRE1000Coa = [];
rspExcCRE1000Pcx = [];

rspInhTMT1000Coa = [];
rspInhTMT1000Pcx = [];
rspInhRose1000Coa = [];
rspInhRose1000Pcx = [];
rspInhCRE1000Coa = [];
rspInhCRE1000Pcx = [];
%% COA
c = 0;
for idxExp = 1 : length(coa15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa15.esp(idxExp).shankNowarp(idxShank).cell)
            if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                TMT = [];
                if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).DigitalResponse300ms == 1 || coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).DigitalResponse1000ms == 1
                    TMT = double(coa151.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).spikeMatrix(:,14000:20000));
                    sdfTMTCoa = [sdfTMTCoa; slidePSTH(TMT, 100, 5)];
                end
                if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).DigitalResponse1000ms == 1
                    rspExcTMT1000Coa = [rspExcTMT1000Coa mean(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).AnalogicResponse1000ms)-mean(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).AnalogicBsl1000ms)];
                end
                if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).DigitalResponse1000ms == -1
                    rspInhTMT1000Coa = [rspInhTMT1000Coa mean(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).AnalogicResponse1000ms)-mean(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).AnalogicBsl1000ms)];
                end
            end
        end
    end
end
c = 0;
for idxExp = 1 : length(coaAA.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coaAA.esp(idxExp).shankNowarp(idxShank).cell)
            if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                TMT = [];
                if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).DigitalResponse300ms == 1 || coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).DigitalResponse1000ms == 1
                    TMT = double(coaAA1.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).spikeMatrix(:,14000:20000));
                    sdfTMTCoa = [sdfTMTCoa; slidePSTH(TMT, 100, 5)];
                end
                if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).DigitalResponse1000ms == 1
                    rspExcTMT1000Coa = [rspExcTMT1000Coa mean(coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).AnalogicResponse1000ms)-mean(coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).AnalogicBsl1000ms)];
                end
                if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).DigitalResponse1000ms == -1
                    rspInhTMT1000Coa = [rspInhTMT1000Coa mean(coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).AnalogicResponse1000ms)-mean(coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).AnalogicBsl1000ms)];
                end
            end
        end
    end
end


c = 0;
for idxExp = 1 : length(coaAA.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coaAA.esp(idxExp).shankNowarp(idxShank).cell)
            if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                ROSE = [];
                if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).DigitalResponse300ms == 1 || coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).DigitalResponse1000ms == 1
                    ROSE = double(coaAA1.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).spikeMatrix(:,14000:20000));
                    sdfRoseCoa = [sdfRoseCoa; slidePSTH(ROSE, 100, 5)];
                end
                if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).DigitalResponse1000ms == 1
                    rspExcRose1000Coa = [rspExcRose1000Coa mean(coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).AnalogicResponse1000ms)-mean(coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).AnalogicBsl1000ms)];
                end
                if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).DigitalResponse1000ms == -1
                    rspInhRose1000Coa = [rspInhRose1000Coa mean(coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).AnalogicResponse1000ms)-mean(coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).AnalogicBsl1000ms)];
                end
            end
        end
    end
end

c = 0;
for idxExp = 1 : length(coa15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa15.esp(idxExp).shankNowarp(idxShank).cell)
            if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                CRE = [];
                if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).DigitalResponse300ms == 1 || coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).DigitalResponse1000ms == 1
                    CRE = double(coa151.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).spikeMatrix(:,14000:20000));
                    sdfCRECoa = [sdfCRECoa; slidePSTH(CRE, 100, 5)];
                end
                if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).DigitalResponse1000ms == 1
                    rspExcCRE1000Coa = [rspExcCRE1000Coa mean(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).AnalogicResponse1000ms)-mean(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).AnalogicBsl1000ms)];
                end
                if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).DigitalResponse1000ms == -1
                    rspInhCRE1000Coa = [rspInhCRE1000Coa mean(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).AnalogicResponse1000ms)-mean(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).AnalogicBsl1000ms)];
                end
            end
        end
    end
end

%% PCX

c = 0;
for idxExp = 1 : length(pcx15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx15.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                TMT = [];
                if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).DigitalResponse300ms == 1 || pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).DigitalResponse1000ms == 1
                    TMT = double(pcx151.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).spikeMatrix(:,14000:20000));
                    sdfTMTPcx = [sdfTMTPcx; slidePSTH(TMT, 100, 5)];
                end
                if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).DigitalResponse1000ms == 1
                    rspExcTMT1000Pcx = [rspExcTMT1000Pcx mean(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).AnalogicResponse1000ms)-mean(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).AnalogicBsl1000ms)];
                end
                if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).DigitalResponse1000ms == -1
                    rspInhTMT1000Pcx = [rspInhTMT1000Pcx mean(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).AnalogicResponse1000ms)-mean(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(10).AnalogicBsl1000ms)];
                end
            end
        end
    end
end
c = 0;
for idxExp = 1 : length(pcxAA.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcxAA.esp(idxExp).shankNowarp(idxShank).cell)
            if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                TMT = [];
                if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).DigitalResponse300ms == 1 || pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).DigitalResponse1000ms == 1
                    TMT = double(pcxAA1.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).spikeMatrix(:,14000:20000));
                    sdfTMTPcx = [sdfTMTPcx; slidePSTH(TMT, 100, 5)];
                end
                if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).DigitalResponse1000ms == 1
                    rspExcTMT1000Pcx = [rspExcTMT1000Pcx mean(pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).AnalogicResponse1000ms)-mean(pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).AnalogicBsl1000ms)];
                end
                if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).DigitalResponse1000ms == -1
                    rspInhTMT1000Pcx = [rspInhTMT1000Pcx mean(pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).AnalogicResponse1000ms)-mean(pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(1).AnalogicBsl1000ms)];
                end
            end
        end
    end
end


c = 0;
for idxExp = 1 : length(pcxAA.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcxAA.esp(idxExp).shankNowarp(idxShank).cell)
            if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                ROSE = [];
                if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).DigitalResponse300ms == 1 || pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).DigitalResponse1000ms == 1
                    ROSE = double(pcxAA1.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).spikeMatrix(:,14000:20000));
                    sdfRosePcx = [sdfRosePcx; slidePSTH(ROSE, 100, 5)];
                end
                if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).DigitalResponse1000ms == 1
                    rspExcRose1000Pcx = [rspExcTMT1000Pcx mean(pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).AnalogicResponse1000ms)-mean(pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).AnalogicBsl1000ms)];
                end
                if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).DigitalResponse1000ms == -1
                    rspInhRose1000Pcx = [rspInhTMT1000Pcx mean(pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).AnalogicResponse1000ms)-mean(pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(7).AnalogicBsl1000ms)];
                end
            end
        end
    end
end

c = 0;
for idxExp = 1 : length(pcx15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx15.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                CRE = [];
                if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).DigitalResponse300ms == 1 || pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).DigitalResponse1000ms == 1
                    CRE = double(pcx151.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).spikeMatrix(:,14000:20000));
                    sdfCREPcx = [sdfCREPcx; slidePSTH(CRE, 100, 5)];
                end
                if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).DigitalResponse1000ms == 1
                    rspExcCRE1000Pcx = [rspExcCRE1000Pcx mean(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).AnalogicResponse1000ms)-mean(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).AnalogicBsl1000ms)];
                end
                if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).DigitalResponse1000ms == -1
                    rspInhCRE1000Pcx = [rspInhCRE1000Pcx mean(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).AnalogicResponse1000ms)-mean(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(9).AnalogicBsl1000ms)];
                end
            end
        end
    end
end

%%
iaaC = [55,126,184]./255;
tmtC = [228,26,28]./255;
roseC = [77,175,74]./255;

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(mean(sdfTMTCoa), 'linewidth', 2, 'color', tmtC)
hold on
plot(mean(sdfCRECoa), 'linewidth', 2,  'color', iaaC)
hold on
plot(mean(sdfRoseCoa), 'linewidth', 2,  'color', roseC)
set(gca,'box', 'off')

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(mean(sdfTMTPcx), 'linewidth', 2, 'color', tmtC)
hold on
plot(mean(sdfCREPcx), 'linewidth', 2,  'color', iaaC)
hold on
plot(mean(sdfRosePcx), 'linewidth', 2,  'color', roseC)
set(gca,'box', 'off')

%%
s11 = size(rspExcCRE1000Coa,2);
s12 = size(rspExcTMT1000Coa,2);
s13 = size(rspExcRose1000Coa,2);
s21 = size(rspExcCRE1000Pcx,2);
s22 = size(rspExcTMT1000Pcx,2);
s23 = size(rspExcRose1000Pcx,2);
excCoa = [rspExcCRE1000Coa'; rspExcTMT1000Coa'; rspExcRose1000Coa'];
excPcx = [rspExcCRE1000Pcx'; rspExcTMT1000Pcx'; rspExcRose1000Pcx'];
excRsp = [excCoa; excPcx];
groupsExc = nan(size(excRsp,1),2);
groupsExc(1:size(excCoa,1), 1) = 1;
groupsExc(size(excCoa,1)+1:end, 1) = 2;
groupsExc(1:s11, 2) = 1;
groupsExc(s11+1:s11+s12, 2) = 2;
groupsExc(s11+s12+1:s11+s12+s13, 2) = 3;
groupsExc(s11+s12+s13+1:s11+s12+s13+s21, 2) = 1;
groupsExc(s11+s12+s13+s21+1:s11+s12+s13+s21+s22, 2) = 2;
groupsExc(s11+s12+s13+s21+s22+1:s11+s12+s13+s21+s22+s23, 2) = 3;

colors = nan(size(groupsExc,1),3);
colors(groupsExc(:,2) == 1,:) = iaaC;
colors(groupsExc(:,2) == 2,:) = tmtC;
colors(groupsExc(:,2) == 3,:) = roseC;
factors = groupsExc(:,1);

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
boxplot(excRsp, factors, 'Notch', 'on', 'filled', 'ColorGroup', colors, 'FactorSeparator', 'auto', 'FactorGap', 'auto')




s11 = size(rspInhCRE1000Coa,2);
s12 = size(rspInhTMT1000Coa,2);
s13 = size(rspInhRose1000Coa,2);
s21 = size(rspInhCRE1000Pcx,2);
s22 = size(rspInhTMT1000Pcx,2);
s23 = size(rspInhRose1000Pcx,2);
inhCoa = [rspInhCRE1000Coa'; rspInhTMT1000Coa'; rspInhRose1000Coa'];
inhPcx = [rspInhCRE1000Pcx'; rspInhTMT1000Pcx'; rspInhRose1000Pcx'];
inhRsp = [inhCoa; inhPcx];
groupsInh = nan(size(inhRsp,1),2);
groupsInh(1:size(inhCoa,1), 1) = 1;
groupsInh(size(inhCoa,1)+1:end, 1) = 2;
groupsInh(1:s11, 2) = 1;
groupsInh(s11+1:s11+s12, 2) = 2;
groupsInh(s11+s12+1:s11+s12+s13, 2) = 3;
groupsInh(s11+s12+s13+1:s11+s12+s13+s21, 2) = 1;
groupsInh(s11+s12+s13+s21+1:s11+s12+s13+s21+s22, 2) = 2;
groupsInh(s11+s12+s13+s21+s22+1:s11+s12+s13+s21+s22+s23, 2) = 3;

colors = nan(size(groupsInh,1),3);
colors(groupsInh(:,2) == 1,:) = iaaC;
colors(groupsInh(:,2) == 2,:) = tmtC;
colors(groupsInh(:,2) == 3,:) = roseC;
factors = groupsInh(:,1);

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
boxplot(excRsp, factors, 'Notch', 'on', 'outline', 'ColorGroup', colors, 'FactorSeparator', 'auto', 'FactorGap', 'auto')

