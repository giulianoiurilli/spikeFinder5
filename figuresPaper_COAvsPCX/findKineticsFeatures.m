odorsRearranged = 1:15;
odors = length(odorsRearranged);
%%
responsiveUnit300ms = 0;
responsiveUnit1s = 0;
responsiveUnitExc300ms = 0;
responsiveUnitInh300ms = 0;
responsiveUnitExc1s = 0;
responsiveUnitInh1s = 0;
cells = 0;
for idxExp = 1: length(pcx2.esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                cells = cells + 1;
                responsivenessExc300ms = zeros(1,odors);
                responsivenessExc1000ms = zeros(1,odors);
                idxO = 0;
                aurocs300ms = 0.5*ones(1,odors);
                aurocs1s = 0.5*ones(1,odors);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExc300ms(idxO) = pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessExc1000ms(idxO) = pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    aurocs300ms(idxO) =  pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocs1000ms(idxO) = pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
                %vincolo reliability               
                responsivenessExc300ms(aurocs300ms<=0.75) = 0;
                responsivenessExc1000ms(aurocs1000ms<=0.75) = 0;               
                if sum(responsivenessExc1000ms + responsivenessExc300ms) > 0
                    responsiveUnitExc1s = responsiveUnitExc1s + 1;
                end

            end
        end
    end
end
%%
onsetExc1Pcx = zeros(responsiveUnitExc1s, odors);
peakExc1Pcx = zeros(responsiveUnitExc1s, odors);
widthExc1Pcx = zeros(responsiveUnitExc1s, odors);

idxCellExc1 = 0;
neuroneOdore = 0;
neurone = 0;
for idxExp = 1: length(pcx2.esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                neurone = neurone + 1;
                responsivenessExc300ms = zeros(1,odors);
                responsivenessExc1000ms = zeros(1,odors);
                aurocs300ms = 0.5*ones(1,odors);
                aurocs1000ms = 0.5*ones(1,odors);
                idxO = 0;
                for idxOdor = odorsRearranged
                    neuroneOdore = neuroneOdore + 1;
                    idxO = idxO + 1;
                    responsivenessExc300ms(idxO) = pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessExc1000ms(idxO) = pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    aurocs300ms(idxO) =  pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocs1000ms(idxO) = pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
                %vincolo reliability
                responsivenessExc300ms(aurocs300ms<=0.75) = 0;
                responsivenessExc1000ms(aurocs1000ms<=0.75) = 0;
                if sum(responsivenessExc1000ms + responsivenessExc300ms) > 0
                    idxCellExc1 = idxCellExc1 + 1;
                    idxO = 0;
                    for idxOdor = odorsRearranged
                        try
                            idxO = idxO + 1;
                            onsetExc1Pcx(idxCellExc1, idxO) = pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).onsetLatency;
                            peakExc1Pcx(idxCellExc1, idxO) = pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency;
                            widthExc1Pcx(idxCellExc1, idxO) = pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth;
                        catch
                        end
                    end
                    onsetExc1Pcx(idxCellExc1, responsivenessExc1000ms<1) = NaN;
                    peakExc1Pcx(idxCellExc1, responsivenessExc1000ms<1) = NaN;
                    widthExc1Pcx(idxCellExc1, responsivenessExc1000ms<1) = NaN;
                end
            end
        end
    end
end

%%
responsiveUnit300ms = 0;
responsiveUnit1s = 0;
responsiveUnitExc300ms = 0;
responsiveUnitInh300ms = 0;
responsiveUnitExc1s = 0;
responsiveUnitInh1s = 0;
cells = 0;
for idxExp = 1: length(coa2.esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(coa2.esp(idxExp).shankNowarp(idxShank).cell)
            if coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                cells = cells + 1;
                responsivenessExc300ms = zeros(1,odors);
                responsivenessExc1000ms = zeros(1,odors);
                idxO = 0;
                aurocs300ms = 0.5*ones(1,odors);
                aurocs1s = 0.5*ones(1,odors);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExc300ms(idxO) = coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessExc1000ms(idxO) = coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    aurocs300ms(idxO) =  coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocs1000ms(idxO) = coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
                %vincolo reliability               
                responsivenessExc300ms(aurocs300ms<=0.75) = 0;
                responsivenessExc1000ms(aurocs1000ms<=0.75) = 0;               
                if sum(responsivenessExc1000ms + responsivenessExc300ms) > 0
                    responsiveUnitExc1s = responsiveUnitExc1s + 1;
                end

            end
        end
    end
end
onsetExc1Pcx = onsetExc1Pcx(:);
peakExc1Pcx = peakExc1Pcx(:);
hwidthExc1Pcx = widthExc1Pcx(:);
onsetExc1Pcx(isnan(onsetExc1Pcx)) = [];
peakExc1Pcx(isnan(peakExc1Pcx)) = [];
hwidthExc1Pcx(isnan(widthExc1Pcx)) = [];
%%
onsetExc1Coa = zeros(responsiveUnitExc1s, odors);
peakExc1Coa = zeros(responsiveUnitExc1s, odors);
widthExc1Coa = zeros(responsiveUnitExc1s, odors);



idxCellExc1 = 0;
neuroneOdore = 0;
neurone = 0;
for idxExp = 1: length(coa2.esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(coa2.esp(idxExp).shankNowarp(idxShank).cell)
            if coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                neurone = neurone + 1;
                responsivenessExc300ms = zeros(1,odors);
                responsivenessExc1000ms = zeros(1,odors);
                aurocs300ms = 0.5*ones(1,odors);
                aurocs1000ms = 0.5*ones(1,odors);
                idxO = 0;
                for idxOdor = odorsRearranged
                    neuroneOdore = neuroneOdore + 1;
                    idxO = idxO + 1;
                    responsivenessExc300ms(idxO) = coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessExc1000ms(idxO) = coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    aurocs300ms(idxO) =  coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocs1000ms(idxO) = coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
                %vincolo reliability
                responsivenessExc300ms(aurocs300ms<=0.75) = 0;
                responsivenessExc1000ms(aurocs1000ms<=0.75) = 0;
                if sum(responsivenessExc1000ms + responsivenessExc300ms) > 0
                    idxCellExc1 = idxCellExc1 + 1;
                    idxO = 0;
                    for idxOdor = odorsRearranged
                        try
                            idxO = idxO + 1;
                            onsetExc1Coa(idxCellExc1, idxO) = coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).onsetLatency;
                            peakExc1Coa(idxCellExc1, idxO) = coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency;
                            widthExc1Coa(idxCellExc1, idxO) = coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth;
                        catch
                        end
                    end
                    onsetExc1Coa(idxCellExc1, responsivenessExc1000ms<1) = NaN;
                    peakExc1Coa(idxCellExc1, responsivenessExc1000ms<1) = NaN;
                    widthExc1Coa(idxCellExc1, responsivenessExc1000ms<1) = NaN;
                end
            end
        end
    end
end
onsetExc1Coa = onsetExc1Coa(:);
peakExc1Coa = peakExc1Coa(:);
hwidthExc1Coa = widthExc1Coa(:);
onsetExc1Coa(isnan(onsetExc1Coa)) = [];
peakExc1Coa(isnan(peakExc1Coa)) = [];
hwidthExc1Coa(isnan(widthExc1Coa)) = [];