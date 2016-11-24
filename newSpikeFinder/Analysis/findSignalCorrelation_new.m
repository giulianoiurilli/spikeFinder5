function  [sigCorr1000ms, corrM, sigCorr1000msSig, corrMSig] = findSignalCorrelation_new(esp, odorsRearranged)

% odorsRearranged = 1:15;
% esp = coa15.esp;

idxC = 0;
idxCell1000ms = 0;
tuningCell1000ms = [];
for idxExp = 1: length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.1
                    idxCell1000ms = idxCell1000ms + 1;
                    idxO = 0;
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        tuningCell1000ms(idxCell1000ms,idxO) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                            esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                        tuningCellAuroc1000ms(idxCell1000ms,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).auROC1000ms;
                        app(idxO) = ~(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms==0);
                    end
                    if sum(app>0)
                        idxC = idxC + 1;
                        tuningCell1000msSig(idxC,:) = tuningCell1000ms(idxCell1000ms,:);
                    end
                end
            end
        end
    end
end

tuningCell1000ms = zscore(tuningCell1000ms');
tuningCell1000ms = tuningCell1000ms';
sigCorr1000ms = 1-pdist(tuningCell1000ms, 'correlation');
corrM = squareform(sigCorr1000ms);

tuningCell1000msSig = zscore(tuningCell1000msSig');
tuningCell1000msSig = tuningCell1000msSig';
sigCorr1000msSig = 1-pdist(tuningCell1000msSig, 'correlation');
corrMSig = squareform(sigCorr1000msSig);

