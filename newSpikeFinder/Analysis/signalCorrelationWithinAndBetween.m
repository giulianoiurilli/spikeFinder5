function [CorrSame, CorrOther] = signalCorrelationWithinAndBetween(esp, odors, lratio, onlyexc)

% esp = coaNM.esp;
% odors = 1:13;
% onlyexc = 0;
% lratio = 0.5;

odorsRearranged = odors;
odors = length(odorsRearranged);


%%
idxCell1 = zeros(length(esp),4);
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    resp = zeros(1,odors);
                    for idxOdor = 1:odors
                        if onlyexc
                            resp(idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        else
                            resp(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                        end
                    end
                    if sum(resp)>0
                        idxCell1(idxExp, idxShank) = idxCell1(idxExp, idxShank) + 1;
                    end
                end
            end
        end
    end
end


%%
signalCorr_0_1000ms = [];
signalCorr_1_1000ms = [];
signalCorr_2_1000ms = [];
signalCorr_3_1000ms = [];
signalCell1000ms=[];
for idxExp = 1: length(esp)
    for idxShank = 1:4
        signalCell1000ms(idxShank).shank = nan(idxCell1(idxExp, idxShank),odors);
        idxCell1000ms = 0;
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    resp = zeros(1,odors);
                    for idxOdor = 1:odors
                        if onlyexc
                            resp(idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        else
                            resp(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                        end
                        
                    end
                    if sum(resp)>0
                        idxCell1000ms = idxCell1000ms + 1;
                        idxO = 0;
                        for idxOdor = odorsRearranged
                            idxO = idxO + 1;
                            signalCell1000ms(idxShank).shank(idxCell1000ms,idxO) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms)-...
                                mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                        end
                    end
                end
            end
        end
        if size(signalCell1000ms(idxShank).shank,1) > 0
            signalCell1000ms(idxShank).shank = signalCell1000ms(idxShank).shank';
            if size(signalCell1000ms(idxShank).shank,2) > 1
                rho = pdist(signalCell1000ms(idxShank).shank', 'correlation');
                rho = 1 - rho;
                signalCorr_0_1000ms = [signalCorr_0_1000ms rho];
            end
        end
    end
    
    %%
    for probe = 1:3
        next = probe+1;
        if ~isempty(signalCell1000ms(probe).shank) && ~isempty(signalCell1000ms(next).shank)
            app = corr(signalCell1000ms(probe).shank, signalCell1000ms(next).shank);
            app = app(~isnan(app));
            signalCorr_1_1000ms = [signalCorr_1_1000ms app(:)'];
        else
            app = [];
            signalCorr_1_1000ms = [signalCorr_1_1000ms app(:)'];
        end
    end
    
    for probe = 1:2
        next = probe+2;
        if ~isempty(signalCell1000ms(probe).shank) && ~isempty(signalCell1000ms(next).shank)
            app = corr(signalCell1000ms(probe).shank, signalCell1000ms(next).shank);
            app = app(~isnan(app));
            signalCorr_2_1000ms = [signalCorr_2_1000ms app(:)'];
        else
            app = [];
            signalCorr_2_1000ms = [signalCorr_2_1000ms app(:)'];
        end
    end
    
    probe = 1;
    next = 4;
    if ~isempty(signalCell1000ms(probe).shank) && ~isempty(signalCell1000ms(next).shank)
        app = corr(signalCell1000ms(probe).shank, signalCell1000ms(next).shank);
        index = find(triu(ones(size(app))));
        app = app(~isnan(app));
        signalCorr_3_1000ms = [signalCorr_3_1000ms app(:)'];
    else
        app = [];
        signalCorr_3_1000ms = [signalCorr_3_1000ms app(:)'];
    end
end


%%
CorrSame = signalCorr_0_1000ms;
CorrOther = [signalCorr_1_1000ms signalCorr_2_1000ms signalCorr_3_1000ms;];

%%
% figure
% 
% [fPcx,xiPcx] = ksdensity(CorrSameCoa);
% plot(xiPcx,fPcx,'color', coaC, 'linewidth', 1)
% xlabel('signal correlation')
% ylabel('p.d.f.')
% xlim([-1.2 1.2])
% hold on
% 
% [fPcx,xiPcx] = ksdensity(CorrOtherCoa);
% plot(xiPcx,fPcx,'--','color', coaC, 'linewidth', 1)
% xlabel('signal correlation')
% ylabel('p.d.f.')
% xlim([-1.2 1.2])
